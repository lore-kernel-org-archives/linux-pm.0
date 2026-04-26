Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022114.outbound.protection.outlook.com [52.101.96.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB051A316E;
	Sun, 26 Apr 2026 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777219298; cv=fail; b=fqfoIRywaFUhCvOAnKMktygNs78blXbzxAZIrqnHOmNEYpjs7vl8QNo1zF0bccm8WLar8Pz4EWBpMvk7KPlIS4a/JAAEWOgnm7jHOcHCZ1pTki8UKzo0PqK9q1A5PO6gYZTdA/sHxLYfqNeSVqQE7KoElVVeuPNWX7yDhX4Lr+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777219298; c=relaxed/simple;
	bh=e/2Z7xj2YhlZfonTHLA0RzmrMkzRaoCfLZHwy+9GKf8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=czh1zMspjhM8CL8HXlWBPIw5cbNJHAlGlnhjDPLbvGzwCX+nlZgxrwx9ZnPbJac32B8Kuyf/4pjVyvkg3dOJkP74jxwkqCejPdD8fgW94SocFb0vTOWYy2XCi5q06PWZby5Tt53dAFCmT8myW617Kg7MydASdlmVz4+s2etcD08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6GFG2EyZJme0J0Luq5qjaGWGz6Vn6YebY3NdRw1O2GKLiaqgGUyToRGyjRDlWrqisfP7SEkdrpaKsYILLXxph1y2lqpJeJcxfXgA+wGHGnZrZfcni1wqLnP4M2qfP0qNArzwIuQEk4ubOA2Zv2Zh03Dw/2tlxfFno5iOHnRZvsTyDKxxFxM7lZrXqw85zYY+vYKs+J1ASCK28bjo6NEXmm6Fthv4nBjVb8dJrzo2oT5gE93YfYhv887b1mMt/CjR77oxpZE2IRCpfLsSAazjZmaGS9tWlHnG7hI5IHKL69P7z8QrLVGnV4lUD2GO/VxMXfn/xNvipaNffOXRBzFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82eWCZQTMp5AQGbSvH1DNX28M55vaqbXn1ExBCzjXnw=;
 b=v/ecpjwGca73GjZgV0VdzNkg+Uzb6sCEbV1xuHzJZmCJRkdJ6BcGHkPHlnaRAEIT2iFFOQdqa7uKHH4Gr1d2Gp4JGTHlNiVMgydrF7Tkk5NvaXhHGIj3e0WvY6BO6atKx1eLU5qm2xYokuQxAZ07Z440zDpji2SgDdtguxFeS/rX8aLLUof/MzUU6hwLsDAaXfrhWSBRc9eFzYZMXkIqOD3UfTAagYjrPel4P62+IBxkX+eOCf865rELZaPAF0IdS3AGgVYYm3uoFi/8bgGFYpCMCwAAuCBt7dUMeYL0DQCW1UeustvwJwz/8BJQk26bWjAvx/LxJ02WMTsTJXKRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO0P123MB6784.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.25; Sun, 26 Apr
 2026 16:01:32 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.021; Sun, 26 Apr 2026
 16:01:31 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: rafael@kernel.org,
	dakr@kernel.org,
	pavel@kernel.org,
	lenb@kernel.org
Cc: zhongqiu.han@oss.qualcomm.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	pmladek@suse.com,
	rdunlap@infradead.org,
	feng.tang@linux.alibaba.com,
	pawan.kumar.gupta@linux.intel.com,
	kees@kernel.org,
	elver@google.com,
	arnd@arndb.de,
	fvdl@google.com,
	lirongqing@baidu.com,
	bhelgaas@google.com,
	neelx@suse.com,
	sean@ashe.io,
	mproche@gmail.com,
	chjohnst@gmail.com,
	nick.lange@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v5] PM: QoS: Introduce boot parameter pm_qos_resume_latency_us
Date: Sun, 26 Apr 2026 12:01:27 -0400
Message-ID: <20260426160127.292486-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:408:e0::29) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO0P123MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: c323ebd2-b6b9-43fc-3091-08dea3ad154b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TWWD2ntkEF3XfDWhsTJCjyCERVjH2yQ77wD4VA7H+NXDUqPrgbzoKkk3CwSMUD5vBo+GyNrrW6xcmWV2eEkjUek6eRqBZZ+tKBtaWSBMj3H3d+GEK1tFT5IyeU0PSblRKghbNqKiSuNAiIci2FQZtysZagaPtbjRm2AzfA5oN7V5DIM56q5UHfjsWkJfsDR1vLT/+eZkXmP04Pp3bnB36t8EWa7EMI9vV6I5Ti+i/6DLPEYywlBG1aARSUpKVA6HQz3JC057FXw5Fj6zNInEy7pRQOgSm6B1HRjy2I1Eo+P5B42PhOxmlKdAuVusaI0YeBVk+BuflSJW9jQYKUGXz4vljib68ziIWVynm5dkaKj2FBM7XDS6VJ/UK/Ey9IRftav0v69/mp/hBeoKJMRjqApRjVwgl/ZKKvBosyG7DLvcHu4Lwa6gm7dOTB+tdZSecvwRSkm59lpd6w3I/SSWiTL9z66jIvGGzlopPeTN8KenOs601FzhakZEIZBPX5y35kyJVY6Iwl2wFBtFrLJTiH2YMcfiSDb6YZPenGr6ph0+ySYoo9RVowsZgyWdQDj4FNKGn8qeh5nYvChn1i/ummmDJVBSFcTvmnfbjc4s89zbmQgYYaJ+oKyOCq7BYjhG17qYlOWPpS8w2X5FJQHMzQ2qDNgeOVqcCmUNmO+W48qYRGQO4CGeOdT070uCkoT6kgCwaYhP7gCv54B5oggud+J9P+KxqR05uHh4Eknnifk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EthO9+pcmLXQ6IPcg9KA/5s4NEWrKwPGDc4eIHg7acGU1WQMl03lpkeFaiYz?=
 =?us-ascii?Q?fYsfkEAg/qQhifgDVXW5Zz+J1wV1azJ8udd6OOL2fBwxO8tp42MoXgd2Tu7/?=
 =?us-ascii?Q?PrLjbOUTgnKx0JMnJMvQT/ATfhYeFiU3XX9jVOl80CLosAvm38cLTIFvU3jZ?=
 =?us-ascii?Q?cRvkUo539u76dvMTFXodxNcBPUZxWe2KYB1Vuooip5IN20koOWA4JCZNPG11?=
 =?us-ascii?Q?Y7RzNxA9KTTZDy1YBT6RYcJYSfbqoUy3iQqVd5F697vALKpyyuVdSTRoIJxb?=
 =?us-ascii?Q?onAuwHpZyfDzWuLQtj30N1m7miAUDKp0yxFNAJPh45sbWc8e6wNDOzbJZTdE?=
 =?us-ascii?Q?wZYyuYwofLySDgihNxqL8FleEsWQ4uQL1ruU+zWagLm/Frhhzx3FaceA9uLM?=
 =?us-ascii?Q?3LNYvcHE06EDXbnAxidF+sSLVDSgUW0xo1ep+182F9E1K6OmvNzQUcSvVGFf?=
 =?us-ascii?Q?ndfA2p0d5OlLLX38oU0vI9DLjR52v4ci5qrRCemu13xkLJWd1L+gUtTQyZPS?=
 =?us-ascii?Q?B16+DXnh6I4oDmybBESDtO40c6nMljAccJ/U3eYfwQprl3cgmJgxsatIFFJs?=
 =?us-ascii?Q?02BEowEvu4q+RLBpjNAFWdCvUpbv/P0VvE2ae0rSWplNj5iOpn/lqdCsT0Rp?=
 =?us-ascii?Q?iIJtKltj4PXlgxOoBTegRWlGbyxEsYeRLOcm+msl0eFDatC3WoY2xPp+9pI/?=
 =?us-ascii?Q?JdZJQmWEp0bXNeWHbnE5uXpLcMEAlQLcInZ+aGIIdQ6ZlPWgctEnLIf4Zn0U?=
 =?us-ascii?Q?Xj5j37E/l6mC7JfgvPvii/jVod1t4wPXLXrZcpvQI2dSP6N8Cg1Gh3BEMl87?=
 =?us-ascii?Q?A5a3kc5+lRGQKXEnyO4ZUyZvUqXRYvEu51wWo4mV4/sC5OmAUnIJZ9BIDRTo?=
 =?us-ascii?Q?NlIyB1nfiU25vrVGDaSuNqBua94MlwqITXOh0f/gA8SdBv0twFfPYljyFz/1?=
 =?us-ascii?Q?4pY0cHQYvte83sBm23AXgs7E+VShj5tEJ/1kwendo8moQRwO3O6cotrzs+IP?=
 =?us-ascii?Q?cLiqZK2EcwLYfrjOvd3MUJtFWfgUxLbpFuO/rv5xNaru1Jv4Xeb8BL9MDYBi?=
 =?us-ascii?Q?7s9oQR2mXl0MznCQeYGErC/68sc5v+bpL7w9dZs+3uK6g2SyGzZNmz90gX2l?=
 =?us-ascii?Q?0Cxkpw34SIrcXy4+3rGlHNiaDgNiYpjOTIfp+Tn3KYyVOrFA7U6zHf3d5uYL?=
 =?us-ascii?Q?xyfchUrKZDEEr17GXZ9nazOc31qAdXgaPcJyGBiQYqTq1UusJCGhxwnUUIZG?=
 =?us-ascii?Q?FQpm8b4PhfaI5kER7WrTaaT4PgjOtcCs91xXjjg5xSlAi43EN3J1h5E9fVeP?=
 =?us-ascii?Q?JYEnWUQi7xQB+SUKKViRBYq7ohkc8B1MHk3wn0hMmm7wLM5O+c9fOeYDPkK4?=
 =?us-ascii?Q?MvdB7y9M+NcqXpHSOWH/UNGudGiKQDaKZRHFh48EutTGoc3r5eYAUtwqmR8u?=
 =?us-ascii?Q?T93xURDi8JS5I6CkDtCjzxD6H0DrJG2qrB50fbGTIuvF1smKQ0cCQtNokxEM?=
 =?us-ascii?Q?lWhdzFvWU0NS8Rr7WK0TPTlAZTO80jba23IsUFHdGvZVWSvSH3q5yDfDQ+71?=
 =?us-ascii?Q?l1C1vx8WF8Ap9JeHBwyebiT6irKtR335NB4Eb9AOYXlCJk/K0q3rwtLYynZx?=
 =?us-ascii?Q?5WOnkXQ+3u7ytrpjf28IcJTPcGSvpex1ouKEhWCUUOmiEGwF/i+QPkrCgp+h?=
 =?us-ascii?Q?X/uFoXm4Yd7UdsDPHJiq5poRecVB5X3yCGc1fiU9Szjir0qaYWkVshejJxCE?=
 =?us-ascii?Q?EfFhpy7QKg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c323ebd2-b6b9-43fc-3091-08dea3ad154b
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 16:01:31.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iNwbvKWSHzUpy+RgJlrCm2GpOT3civDiFs+KqS+ag13CL0L85K8vqCvjAyp0ISh1vKGGyaYXxMrdIyos9ZAig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6784

Hi Rafael, Danilo, Pavel, Len,

Users currently lack a mechanism to define granular, per-CPU PM QoS
resume latency constraints during the early boot phase.

While the idle=poll boot parameter exists, it enforces a global
override, forcing all CPUs in the system to "poll". This global approach
is not suitable for asymmetric workloads where strict latency guarantees
are required only on specific critical CPUs, while housekeeping or
non-critical CPUs should be allowed to enter deeper idle states to save
energy.

Additionally, the existing sysfs interface
(/sys/devices/system/cpu/cpuN/power/pm_qos_resume_latency_us) becomes
available only after userspace initialisation. This is too late to
prevent deep C-state entry during the early kernel boot phase, which may
be required for debugging early boot hangs related to C-state
transitions or for workloads requiring strict latency guarantees
immediately upon system start.

This patch introduces the pm_qos_resume_latency_us kernel boot
parameter, which allows users to specify distinct resume latency
constraints for specific CPU ranges.

	Syntax: pm_qos_resume_latency_us=range:value;range:value...

This boot parameter mirrors the sysfs interface behaviour: the special
string "n/a" imposes a 0us latency constraint (polling), while the
integer 0 removes the constraint entirely.

For example:

	"pm_qos_resume_latency_us=0:n/a;1-15:20"

Forces CPU 0 to poll on idle; constrains CPUs 1-15 to not enter a sleep
state that takes longer than 20 us to wake up. All other CPUs will have
the default (no resume latency) applied.

Implementation Details:

	- The parameter string is captured via __setup() and parsed in
	  an early_initcall() to ensure suitable memory allocators are
	  available.

	- Constraints are stored in a read-only linked list.

	- The constraints are queried and applied in register_cpu().
	  This ensures the latency requirement is active immediately
	  upon CPU registration, effectively acting as a "birth"
	  constraint before the cpuidle governor takes over.

	- The parsing logic enforces a "First Match Wins" policy: if a
	  CPU falls into multiple specified ranges, the latency value
	  from the first matching entry is used.

	- The constraints persist across CPU hotplug events.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
Changes since v4 [1]:
 - Modified the parsing logic so the boot parameter perfectly mirrors the
   existing sysfs interface. Passing the integer 0 now explicitly removes
   the constraint (i.e., maps to PM_QOS_RESUME_LATENCY_NO_CONSTRAINT), and
   the special string "n/a" safely imposes a 0us latency constraint
   (polling on idle)

 - Changed the outer tuple delimiter from a comma (",") to a semicolon
   (";"). This prevents strsep() from breaking standard, non-contiguous
   CPU lists (e.g., "0,2:n/a;4-7:20")

 - Moved the cpumask_or() coverage update to the end of the parsing loop

 - Updated documentation to reflect the new semicolon delimiter and updated
   semantic behavior in Documentation/admin-guide/kernel-parameters.txt

Changes since v3 [2]:
 - Moved pm_qos_get_boot_cpu_latency_limit() declaration out of the
   CONFIG_PM #ifdef block, as qos.c is compiled regardless

Changes since v2 [3]:
 - Add pr_fmt() to standardise log prefixes (Zhongqiu Han)
 - Drop <asm/setup.h> by duplicating the command line with kstrdup()
   (Zhongqiu Han)
 - Fix init_pm_qos_resume_latency_us_setup() error path to return -ENOMEM
   (Zhongqiu Han)

Changes since v1 [4]:
 - Removed boot_option_idle_override == IDLE_POLL check
 - Decoupled implementation from CONFIG_CPU_IDLE
 - Added kernel-parameters.txt documentation
 - Renamed internal setup functions for consistency

[1]: https://lore.kernel.org/lkml/20260308190421.46657-1-atomlin@atomlin.com/
[2]: https://lore.kernel.org/lkml/20260307200736.4192234-1-atomlin@atomlin.com/
[3]: https://lore.kernel.org/lkml/20260128033143.3456074-2-atomlin@atomlin.com/
[4]: https://lore.kernel.org/lkml/20260123010024.3301276-1-atomlin@atomlin.com/

 .../admin-guide/kernel-parameters.txt         |  22 +++
 drivers/base/cpu.c                            |   5 +-
 include/linux/pm_qos.h                        |   1 +
 kernel/power/qos.c                            | 153 ++++++++++++++++++
 4 files changed, 179 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6a3d6bd0746c..1beb4f82e038 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2238,6 +2238,28 @@ Kernel parameters
 	icn=		[HW,ISDN]
 			Format: <io>[,<membase>[,<icn_id>[,<icn_id2>]]]
 
+	pm_qos_resume_latency_us=	[KNL,EARLY]
+			Format: <cpu-list>:<value>[;<cpu-list>:<value>...]
+
+			Establish per-CPU resume latency constraints. These constraints
+			are applied immediately upon CPU registration and persist
+			across CPU hotplug events.
+
+			For example:
+				"pm_qos_resume_latency_us=0:n/a;1-15:20"
+
+			This restricts CPU 0 to a 0us resume latency (effectively
+			forcing polling) and limits CPUs 1-15 to C-states with a
+			maximum exit latency of 20us. All other CPUs remain
+			unconstrained by this parameter.
+
+			This boot parameter mirrors the sysfs interface behaviour.
+			The special string "n/a" imposes a 0us latency constraint
+			(polling), while the integer 0 removes the constraint.
+
+			NOTE: The parsing logic enforces a "First Match Wins" policy.
+			If a CPU is included in multiple specified ranges, the latency
+			value from the first matching entry takes precedence.
 
 	idle=		[X86,EARLY]
 			Format: idle=poll, idle=halt, idle=nomwait
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c6c57b6f61c6..1dea5bcd76a0 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -416,6 +416,7 @@ EXPORT_SYMBOL_GPL(cpu_subsys);
 int register_cpu(struct cpu *cpu, int num)
 {
 	int error;
+	s32 resume_latency;
 
 	cpu->node_id = cpu_to_node(num);
 	memset(&cpu->dev, 0x00, sizeof(struct device));
@@ -436,8 +437,8 @@ int register_cpu(struct cpu *cpu, int num)
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
-	dev_pm_qos_expose_latency_limit(&cpu->dev,
-					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	resume_latency = pm_qos_get_boot_cpu_latency_limit(num);
+	dev_pm_qos_expose_latency_limit(&cpu->dev, resume_latency);
 	set_cpu_enabled(num, true);
 
 	return 0;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 6cea4455f867..65ce276282e8 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -142,6 +142,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 			 struct pm_qos_flags_request *req,
 			 enum pm_qos_req_action action, s32 val);
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu);
 
 #ifdef CONFIG_CPU_IDLE
 s32 cpu_latency_qos_limit(void);
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index f7d8064e9adc..1c854e02ada0 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -18,6 +18,8 @@
  * global CPU latency QoS requests and frequency QoS requests are provided.
  */
 
+#define pr_fmt(fmt) "pm_qos: " fmt
+
 /*#define DEBUG*/
 
 #include <linux/pm_qos.h>
@@ -34,6 +36,9 @@
 #include <linux/kernel.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/cpumask.h>
+#include <linux/cpu.h>
+#include <linux/list.h>
 
 #include <linux/uaccess.h>
 #include <linux/export.h>
@@ -209,6 +214,154 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 	return prev_value != curr_value;
 }
 
+static LIST_HEAD(pm_qos_boot_list);
+static char *pm_qos_resume_latency_cmdline __initdata;
+
+struct pm_qos_boot_entry {
+	struct list_head node;
+	struct cpumask mask;
+	s32 latency;
+};
+
+static int __init pm_qos_resume_latency_us_setup(char *str)
+{
+	pm_qos_resume_latency_cmdline = str;
+	return 1;
+}
+__setup("pm_qos_resume_latency_us=", pm_qos_resume_latency_us_setup);
+
+/**
+ * init_pm_qos_resume_latency_us_setup - Parse the pm_qos_resume_latency_us boot parameter.
+ *
+ * Parses the kernel command line option "pm_qos_resume_latency_us=" to establish
+ * per-CPU resume latency constraints. These constraints are applied
+ * immediately when a CPU is registered.
+ *
+ * Syntax: pm_qos_resume_latency_us=<cpu-list>:<value>[;<cpu-list>:<value>...]
+ * Example: pm_qos_resume_latency_us=0-3:n/a;4-7:20
+ *
+ * The parsing logic enforces a "First Match Wins" policy. If a CPU is
+ * covered by multiple entries in the list, only the first valid entry
+ * applies. Any subsequent overlapping ranges for that CPU are ignored.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int __init init_pm_qos_resume_latency_us_setup(void)
+{
+	char *token, *cmd, *cmd_copy;
+	struct pm_qos_boot_entry *entry, *tentry;
+	cpumask_var_t covered;
+	int ret = 0;
+
+	if (!pm_qos_resume_latency_cmdline)
+		return 0;
+
+	cmd_copy = kstrdup(pm_qos_resume_latency_cmdline, GFP_KERNEL);
+	if (!cmd_copy)
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&covered, GFP_KERNEL)) {
+		pr_warn("Failed to allocate memory for parsing boot parameter\n");
+		ret = -ENOMEM;
+		goto free_cmd_copy;
+	}
+
+	cmd = cmd_copy;
+	while ((token = strsep(&cmd, ";")) != NULL) {
+		char *str_range, *str_val;
+
+		str_range = strsep(&token, ":");
+		str_val = token;
+
+		if (!str_val) {
+			pr_warn("Missing value range %s\n", str_range);
+			continue;
+		}
+
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry) {
+			pr_warn("Failed to allocate memory for boot entry\n");
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+
+		if (cpulist_parse(str_range, &entry->mask)) {
+			pr_warn("Failed to parse cpulist range %s\n", str_range);
+			kfree(entry);
+			continue;
+		}
+
+		cpumask_andnot(&entry->mask, &entry->mask, covered);
+		if (cpumask_empty(&entry->mask)) {
+			pr_warn("Entry %s already covered, ignoring\n", str_range);
+			kfree(entry);
+			continue;
+		}
+
+		if (!strcmp(str_val, "n/a")) {
+			entry->latency = 0;
+		} else if (kstrtos32(str_val, 0, &entry->latency)) {
+			pr_warn("Invalid latency requirement value %s\n", str_val);
+			kfree(entry);
+			continue;
+		} else if (entry->latency == 0) {
+			entry->latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+		}
+
+		if (entry->latency < 0) {
+			pr_warn("Latency requirement cannot be negative: %d\n", entry->latency);
+			kfree(entry);
+			continue;
+		}
+
+		cpumask_or(covered, covered, &entry->mask);
+
+		list_add_tail(&entry->node, &pm_qos_boot_list);
+	}
+
+	free_cpumask_var(covered);
+	kfree(cmd_copy);
+	return 0;
+
+cleanup:
+	list_for_each_entry_safe(entry, tentry, &pm_qos_boot_list, node) {
+		list_del(&entry->node);
+		kfree(entry);
+	}
+	free_cpumask_var(covered);
+free_cmd_copy:
+	kfree(cmd_copy);
+	return ret;
+}
+early_initcall(init_pm_qos_resume_latency_us_setup);
+
+/**
+ * pm_qos_get_boot_cpu_latency_limit - Get boot-time latency limit for a CPU.
+ * @cpu: Logical CPU number to check.
+ *
+ * Checks the read-only boot-time constraints list to see if a specific
+ * PM QoS latency override was requested for this CPU via the kernel
+ * command line.
+ *
+ * Return: The latency limit in microseconds if a constraint exists,
+ * or PM_QOS_RESUME_LATENCY_NO_CONSTRAINT if no boot override applies.
+ */
+s32 pm_qos_get_boot_cpu_latency_limit(unsigned int cpu)
+{
+	struct pm_qos_boot_entry *entry;
+
+	if (list_empty(&pm_qos_boot_list))
+		return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+
+	list_for_each_entry(entry, &pm_qos_boot_list, node) {
+		if (cpumask_test_cpu(cpu, &entry->mask))
+			return entry->latency;
+	}
+
+	return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+}
+EXPORT_SYMBOL_GPL(pm_qos_get_boot_cpu_latency_limit);
+
 #ifdef CONFIG_CPU_IDLE
 /* Definitions related to the CPU latency QoS. */
 
-- 
2.51.0

