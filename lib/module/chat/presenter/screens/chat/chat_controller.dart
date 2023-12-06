class ChatController {
  final List<Map<String, String>> messages = [
    {
      "category": "script analysis",
      "prompt":
          "Here is a miniscript policy:\n```miniscript_policy\nor(pk(key_1),or(pk(key_2),or(pk(key_3),or(pk(key_4),or(pk(key_5),or(pk(key_6),or(pk(key_7),pk(key_8))))))))\n```\nExplain what this policy does in plain English.",
      "explanation":
          "This Bitcoin miniscript policy requires that the transaction is signed by at least one of the eight specified public keys (key_1, key_2, key_3, ..., key_8).",
      "flowchart":
          "assets/flow-sa1.png",
      "code":
          "or(pk(key_1),or(pk(key_2),or(pk(key_3),or(pk(key_4),or(pk(key_5),or(pk(key_6),or(pk(key_7),pk(key_8))))))))"
    },
    {
      "category": "script analysis",
      "prompt":
          "Here is a miniscript policy:\n```miniscript_policy\nor(pk(key_1),or(pk(key_2),or(pk(key_3),or(pk(key_4),or(pk(key_5),or(pk(key_6),or(pk(key_7),or(pk(key_8),or(pk(key_9),pk(key_10))))))))))\n```\nExplain what this policy does in plain English.",
      "explanation":
          "This Bitcoin miniscript policy requires that the transaction is signed by at least one of the ten specified public keys (key_1 to key_10).",
      "flowchart":
          "none"
    },
    {
      "category": "script analysis",
      "prompt":
          "Here is a miniscript policy:\n```miniscript_policy\nor(pk(key_1),or(pk(key_2),or(pk(key_3),or(pk(key_4),or(pk(key_5),pk(key_6))))))\n```\nExplain what this policy does in plain English.",
      "explanation":
          "This Bitcoin miniscript policy requires that the transaction is signed by either key_1, key_2, key_3, key_4, key_5, or key_6.",
      "flowchart":
          "none"
    },
    {
      "category": "script analysis",
      "prompt":
          "Here is a miniscript policy:\n```miniscript_policy\nthresh(2,pk(key1),pk(key2))\n```\nExplain what this policy does in plain English.",
      "explanation":
          "This Bitcoin miniscript policy specifies that two out of the two provided conditions must be met for the script to be satisfied. Specifically, it requires that both public keys named 'key1' and 'key2' must provide valid signatures.",
      "flowchart":
          "none"
    },
    {
      "category": "script analysis",
      "prompt":
          "Here is a miniscript policy:\n```miniscript_policy\npk(NAME)\n```\nExplain what this policy does in plain English.",
      "explanation":
          "The `pk(NAME)` policy in Bitcoin miniscript requires that a transaction must be signed by the private key corresponding to the public key named 'NAME' in order to be valid. The 'NAME' is a placeholder for any string up to 16 characters that represents a specific public key.",
      "flowchart":
          "none"
    },
    {
      "category": "usecase",
      "prompt":
          "Here is a use case:\nBitcoin account controlled by either one of two keys: a preferred one that is used most often (90% of the time) and an alternate one that is used in specific circumstances (10% of the time) or as backup\n\nPropose a miniscript policy for that use case and explain how it addresses it.",
      "explanation":
          "Suggested miniscript policy:\n```miniscript_policy\nor(9@pk(key_preferred),pk(key_alternate))\n```\n\n- `9@pk(key_preferred)`: This term represents the preferred key, which is used 90% of the time. It requires the signature of the public key named 'key_preferred'.\n- `pk(key_alternate)`: This term represents the alternate key, which is used 10% of the time. It requires the signature of the public key named 'key_alternate'.\n\nThe overall miniscript policy states that the Bitcoin account can be controlled by either the preferred key or the alternate key. The preferred key is used most often, with a probability of 90%, while the alternate key is used in specific circumstances or as a backup, with a probability of 10%. This policy allows for flexibility in controlling the account based on the specific needs and usage patterns outlined in the use case.",
      "flowchart":
          "none"
    },
    {
      "category": "usecase",
      "prompt":
          "Here is a use case:\nBitcoin account for my day-to-day use. It should work with my signing device but also a backup key that I have in a vault in case the signing device is lost or damaged.\n\nPropose a miniscript policy for that use case and explain how it addresses it.",
      "explanation":
          "Suggested miniscript policy:\n```miniscript_policy\nor(99@pk(regular_key),pk(backup_key))\n```\n\n- `or(99@pk(regular_key),pk(backup_key))`: This is a logical OR condition that allows for two different methods of authorizing a transaction.\n- `99@pk(regular_key)`: This part of the policy specifies that the public key named 'regular_key' is the primary method for authorizing transactions, with a relative probability weight of 99. This means it is intended to be used 99 times more often than the alternative method.\n- `pk(backup_key)`: This part of the policy specifies that there is a secondary method for authorizing transactions using a public key named 'backup_key'. This is the backup method and is intended to be used less frequently.\n\nThe miniscript policy provided is designed to accommodate the user's need for a primary and a backup method of accessing their Bitcoin account. The primary method is through the use of a signing device associated with the 'regular_key', which is expected to be used for the majority of transactions, as indicated by the high relative probability weight of 99. The 'backup_key' is a secondary method that is intended for use in exceptional circumstances, such as if the signing device is lost or damaged. This backup key is stored securely in a vault. The policy ensures that the user can continue to access their funds in either scenario, providing both convenience for everyday use and security in case of an emergency.",
      "flowchart":
          "none"
    },
    {
      "category": "usecase",
      "prompt":
          "Here is a use case:\nA married couple wants to have a joint Bitcoin account for their day-to-day expenses which either of them can spend from.\n\nPropose a miniscript policy for that use case and explain how it addresses it.",
      "explanation":
          "Suggested miniscript policy:\n```miniscript_policy\nor(pk(wife_key),pk(husband_key))\n```\n\n- `pk(wife_key)`: This part of the policy specifies that the wife's public key is required to authorize a transaction. The term 'wife_key' is a placeholder for the actual public key that the wife would use.\n- `pk(husband_key)`: Similarly, this part of the policy specifies that the husband's public key is required to authorize a transaction. The term 'husband_key' is a placeholder for the actual public key that the husband would use.\n- `or(POL,POL)`: The 'or' operator in the policy indicates that satisfying either of the subpolicies enclosed within it is sufficient for the policy to be met.\n\nThe miniscript policy described here is designed for a joint Bitcoin account that the married couple can use for their daily expenses. It allows for flexibility in that either the wife or the husband can independently authorize transactions from the account. The use of the 'or' operator means that it is not necessary for both parties to sign off on every transaction; instead, the signature of either the wife or the husband is enough to spend funds from the account. This setup is practical for a couple who trust each other and want the convenience of being able to manage their joint expenses without the need for both parties to be present for every transaction.",
      "flowchart":
          "none"
    },
    {
      "category": "usecase",
      "prompt":
          "Here is a use case:\nA contractual agreement where two parties must agree to spend.\n\nPropose a miniscript policy for that use case and explain how it addresses it.",
      "explanation":
          "Suggested miniscript policy:\n```miniscript_policy\nand(pk(party_1), pk(party_2))\n```\n\n- `pk(party_1)`: Requires the signature of a public key named 'party_1'.\n- `pk(party_2)`: Requires the signature of a public key named 'party_2'.\n\nThe miniscript policy 'and(pk(party_1), pk(party_2))' ensures that both parties, 'party_1' and 'party_2', must agree to spend the funds. This means that the transaction can only be valid if both parties sign it. This policy is suitable for a contractual agreement where two parties need to mutually consent to the spending of the funds.",
      "flowchart":
          "none"
    },
    {
      "category": "usecase",
      "prompt":
          "Here is a use case:\nImplement the Lightning BOLT #3 to_local policy.\n\nPropose a miniscript policy for that use case and explain how it addresses it.",
      "explanation":
          "Suggested miniscript policy:\n```miniscript_policy\nor(pk(key_revocation),and(pk(key_local),older(1008)))\n```\n\n- `pk(key_revocation)`: This part of the policy requires a signature from a public key named 'key_revocation'. This key is typically held by the counterparty in a Lightning channel and can be used to claim funds in case of a channel breach (i.e., if one party tries to close the channel with an outdated state).\n- `pk(key_local)`: This requires a signature from a public key named 'key_local'. This key is usually held by the owner of the funds within the Lightning channel and is used to authorize transactions under normal circumstances.\n- `older(1008)`: This condition requires that the transaction can only be included in a block if at least 1008 blocks have been mined since the transaction was initially added to the blockchain. This is a time-delay mechanism that ensures the transaction cannot be spent until a certain amount of time has passed.\n- `and(pk(key_local),older(1008))`: This combined policy requires both the signature from 'key_local' and the 'older(1008)' condition to be met. It ensures that the owner of the funds can only spend them after a time delay, providing a safety period during which any fraudulent attempts to close the channel can be countered.\n- `or(pk(key_revocation),and(pk(key_local),older(1008)))`: This overall policy allows for two possible ways to spend the funds. Either the counterparty can use the revocation key to immediately claim the funds (in case of a breach), or the owner can claim the funds after a delay of 1008 blocks using their local key. This setup is part of the security mechanism in Lightning channels, where the time delay acts as a dispute resolution period, allowing the counterparty to penalize a dishonest party trying to close the channel with an outdated state.\n\nThe miniscript policy described here is designed to enforce the rules of the Lightning Network's BOLT #3 for the 'to_local' output of a commitment transaction. This output represents the funds that can be claimed by the local node (the owner of the funds) under normal circumstances, but with a security measure that prevents immediate spending. The policy ensures that the local node can only spend these funds after a delay, giving the counterparty a chance to react if the local node tries to broadcast an old state. Conversely, if the local node tries to cheat, the counterparty can use the revocation key to claim the funds immediately. This dual-condition setup is crucial for maintaining the integrity and trustless nature of the Lightning Network's payment channels.",
      "flowchart":
          "none"
    },
    {
      "category": "error",
      "prompt":
          "The following miniscript policy does not compile:\nthresh(1, and(pk(key1),pk(key2)), and(pk(key1),pk(key3)))\n\nPropose a corrected policy and explain what caused the error and how the corrected policy addresses it.",
      "explanation":
          "Corrected policy:\n```miniscript_policy\nand(pk(key1), or(pk(key2), pk(key3)))\n```\n\nThe error in the original Bitcoin miniscript policy is caused by a violation of the rule that the same key cannot appear in two different subpolicies. In the original policy, both `pk(key1)` and `pk(key1)` are used in different subpolicies, which is not allowed. To fix this, the policy was refactored in the corrected version by combining the two subpolicies that use `pk(key1)` into a single subpolicy using the `or` operator. This ensures that the same key is not repeated in different subpolicies, resolving the compilation error. The corrected policy is `and(pk(key1), or(pk(key2), pk(key3)))`.",
      "flowchart":
          "none"
    },
    {
      "category": "error",
      "prompt":
          "The following miniscript policy does not compile:\nthresh(2, pk(keyA), pk(keyB, or(pk(keyC),after(1081201)))\n\nPropose a corrected policy and explain what caused the error and how the corrected policy addresses it.",
      "explanation":
          "Corrected policy:\n```miniscript_policy\nthresh(2, pk(keyA), pk(keyB), or(pk(keyC), after(1081201)))\n```\n\nThe error in the original Bitcoin miniscript policy is a mismatched parentheses. The opening parentheses after 'pk(keyB' is not closed, causing a syntax error. In the corrected policy, the missing closing parentheses is added after 'pk(keyB)'. This ensures that the parentheses are balanced and the policy is correctly formatted.",
      "flowchart":
          "none"
    },
    {
      "category": "error",
      "prompt":
          "The following miniscript policy does not compile:\nmulti(2, pk(keyA),pk(keyB),pk(keyC))\n\nPropose a corrected policy and explain what caused the error and how the corrected policy addresses it.",
      "explanation":
          "Corrected policy:\n```miniscript_policy\nthresh(2, pk(keyA),pk(keyB),pk(keyC))\n```\n\nThe error in the original Bitcoin miniscript policy `multi(2, pk(keyA),pk(keyB),pk(keyC))` is caused by using the unsupported operator `multi` instead of the correct operator `thresh`. The `multi` operator is not a valid operator in Bitcoin miniscript. To fix the error, the operator `multi` was replaced with the correct operator `thresh` in the corrected policy `thresh(2, pk(keyA),pk(keyB),pk(keyC))`. The `thresh` operator specifies that a certain number of subpolicies must be met, in this case, at least 2 out of the 3 public key subpolicies (`pk(keyA)`, `pk(keyB)`, `pk(keyC)`) must be satisfied.",
      "flowchart":
          "none"
    },
    {
      "category": "error",
      "prompt":
          "The following miniscript policy does not compile:\nor(and(pk(A),pk(B)),and(pk(A),pk(C)))\n\nPropose a corrected policy and explain what caused the error and how the corrected policy addresses it.",
      "explanation":
          "Corrected policy:\n```miniscript_policy\nthresh(2, pk(A), or(pk(B),pk(C)))\n```\n\nThe error in the original Bitcoin miniscript policy `or(and(pk(A),pk(B)),and(pk(A),pk(C)))` is a violation of the rule that the same key cannot appear in two different subpolicies. In this case, the key `A` is used in both subpolicies. To fix this, the policy was refactored to `thresh(2, pk(A), or(pk(B),pk(C)))`, where the common key `A` is included in one subpolicy only. This corrected policy satisfies the requirement of having at least two out of the three subpolicies (`pk(A)`, `pk(B)`, `pk(C)`) met.",
      "flowchart":
          "none"
    },
    {
      "category": "comparison",
      "prompt":
          "Compare the following two miniscript policies:\n```miniscript_policy\nthresh(1,pk(key1),pk(key2))\n```\n\n```miniscript_policy\nor(pk(key1),pk(key2))\n```",
      "explanation":
          "The two policies are logically equivalent but compile into different scripts.\n\nThe spending cost is also almost the same assuming the two keys are equally likely to be used (with more weight on the script than the spending transaction in the case of the 'thresh' policy). If however key1 is more likely to be used than key2, the 'or' policy is significantly more economical on average.\n\nTherefore the 'or' script policy should be favored in this case, with the most frequent key in front.",
      "flowchart":
          "none"
    },
    {
      "category": "comparison",
      "prompt":
          "Compare the following two miniscript policies:\n```miniscript_policy\nthresh(1,pk(key1),pk(key2),pk(key3))\n```\n\n```miniscript_policy\nor(pk(key1),or(pk(key2),pk(key3)))\n```",
      "explanation":
          "The two policies are logically equivalent but compile into different scripts.\n\nThe spending cost is also almost the same, assuming the three keys are equally likely to be used (with more weight on the script than the spending transaction in the case of the 'thresh' policy). However, if key1 is more likely to be used than key2 and key3, the 'or' policy is significantly more economical on average.\n\nTherefore, the 'or' script policy should be favored in this case, with the most frequent key (key1) in front.",
      "flowchart":
          "none"
    },
    {
      "category": "comparison",
      "prompt":
          "Compare the following two miniscript policies:\n```miniscript_policy\nthresh(4,pk(key1),pk(key2),pk(key3),pk(key4))\n```\n\n```miniscript_policy\nand(pk(key1),and(pk(key2),and(pk(key3),pk(key4))))\n```",
      "explanation":
          "The two policies are logically equivalent and compile into the same script.",
      "flowchart":
          "none"
    },
    {
      "category": "comparison",
      "prompt":
          "Compare the following two miniscript policies:\n```miniscript_policy\nthresh(2,pk(key1),pk(key2),pk(key3))\n```\n\n```miniscript_policy\nor(and(pk(key1),pk(key2)),or(and(pk(key1),pk(key3)),and(pk(key2),pk(key3))))\n```",
      "explanation":
          "The policy with the 'or' and 'and' operators, though it would seem logically equivalent to the 'thresh' policy, actually does not compile into a script. Instead, it produces an error.",
      "flowchart":
          "none"
    }
  ];
}
