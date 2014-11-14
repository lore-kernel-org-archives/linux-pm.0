From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v9 1/9] qcom: scm: scm_set_warm_boot_addr() to set the
 warmboot address
Date: Fri, 14 Nov 2014 09:33:32 -0700
Message-ID: <20141114163332.GF45276@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
 <1414194024-55547-2-git-send-email-lina.iyer@linaro.org>
 <5465BD97.5070506@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38815 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161115AbaKNQde (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Nov 2014 11:33:34 -0500
Received: by mail-pd0-f172.google.com with SMTP id r10so16978060pdi.17
        for <linux-pm@vger.kernel.org>; Fri, 14 Nov 2014 08:33:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5465BD97.5070506@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On Fri, Nov 14 2014 at 01:30 -0700, Daniel Lezcano wrote:
>On 10/25/2014 01:40 AM, Lina Iyer wrote:
>>Set the warmboot address using an SCM call, only if the new address i=
s
>>different than the old one.
>
>Please could you elaborate why a new address can be changed ?
>
Hotplug could have a different warmboot address.


>>Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>---
>>  drivers/soc/qcom/scm-boot.c | 22 ++++++++++++++++++++++
>>  include/soc/qcom/scm-boot.h |  1 +
>>  2 files changed, 23 insertions(+)
>>
>>diff --git a/drivers/soc/qcom/scm-boot.c b/drivers/soc/qcom/scm-boot.=
c
>>index 60ff7b4..5710967 100644
>>--- a/drivers/soc/qcom/scm-boot.c
>>+++ b/drivers/soc/qcom/scm-boot.c
>>@@ -37,3 +37,25 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
>>  			&cmd, sizeof(cmd), NULL, 0);
>>  }
>>  EXPORT_SYMBOL(scm_set_boot_addr);
>>+
>>+
>
>extra line.
>
>>+int scm_set_warm_boot_addr(void *entry, int cpu)
>>+{
>>+	static int flags[NR_CPUS] =3D {
>>+		SCM_FLAG_WARMBOOT_CPU0,
>>+		SCM_FLAG_WARMBOOT_CPU1,
>>+		SCM_FLAG_WARMBOOT_CPU2,
>>+		SCM_FLAG_WARMBOOT_CPU3,
>>+	};
>
>Please do not do that, you don't know what NR_CPUS value could be in=20
>the future with the single kernel image and that could lead to a bug=20
>very hard to find. The kernel stack is 4096.
>
>Move this out of the function:
>
>static int scm_flags[] =3D {
>	SCM_FLAG_WARMBOOT_CPU0,
>	SCM_FLAG_WARMBOOT_CPU1,
>	SCM_FLAG_WARMBOOT_CPU2,
>	SCM_FLAG_WARMBOOT_CPU3,
>};
Sure.
>
>>+	static DEFINE_PER_CPU(void *, last_known_entry);
>
>It sounds odd to add those static declaration here even if I=20
>understand that is to encapsulate them.
>
Sure.
>>+	int ret;
>>+
>>+	if (entry =3D=3D per_cpu(last_known_entry, cpu))
>>+		return 0;
>
>My question is: why scm_set_warm_boot_addr could be called with=20
>different addresses ?
>
>If this is really needed, please replace the per_cpu variable by:
>
>struct scm_boot_addr {
>	int flag;
>	phys_addr_t entry;
>};
>
>static struct scm_boot_addr scm_flags[] =3D {
>	{ SCM_FLAG_WARMBOOT_CPU0, },
>	{ SCM_FLAG_WARMBOOT_CPU1, },
>	{ SCM_FLAG_WARMBOOT_CPU2, },
>	{ SCM_FLAG_WARMBOOT_CPU3, },
>};
>
Hmm.. OK.

>>+	ret =3D scm_set_boot_addr(virt_to_phys(entry), flags[cpu]);
>>+	if (!ret)
>>+		per_cpu(last_known_entry, cpu) =3D entry;
>>+
>>+	return ret;
>>+}
>>diff --git a/include/soc/qcom/scm-boot.h b/include/soc/qcom/scm-boot.=
h
>>index 02b445c..100938b 100644
>>--- a/include/soc/qcom/scm-boot.h
>>+++ b/include/soc/qcom/scm-boot.h
>>@@ -22,5 +22,6 @@
>>  #define SCM_FLAG_WARMBOOT_CPU3		0x40
>
>By the way, if you look for encapsulation, perhaps these macros could=20
>be moved into scm-boot.c, no ?
>
Dont think anybody outside the file needs it.

>>  int scm_set_boot_addr(phys_addr_t addr, int flags);
>>+int scm_set_warm_boot_addr(void *entry, int cpu);
>>
>>  #endif
>>
>
>
>--=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs
>
>Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
><http://twitter.com/#!/linaroorg> Twitter |
><http://www.linaro.org/linaro-blog/> Blog
>
