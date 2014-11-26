From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v10 02/10] qcom: scm: Add SCM warmboot support for quad
 core SoCs
Date: Wed, 26 Nov 2014 10:41:35 +0100
Message-ID: <5475A04F.9070508@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org> <1416593037-27527-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39618 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaKZJlj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 04:41:39 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so4290353wiw.4
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 01:41:38 -0800 (PST)
In-Reply-To: <1416593037-27527-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 11/21/2014 07:03 PM, Lina Iyer wrote:
> Quad core SoCs like APQ8074, APQ8064, APQ8084 need SCM support set up
> warm boot addresses in the Secure Monitor. Extend the SCM flags to
> support warm boot addresses for secondary cores.
>
> We do not need to export the warmboot flags. Move them into the
> implementation file.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

+ one comment below

> ---
>   drivers/soc/qcom/scm-boot.c | 31 +++++++++++++++++++++++++++++++
>   include/soc/qcom/scm-boot.h |  3 +--
>   2 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/scm-boot.c b/drivers/soc/qcom/scm-boot.=
c
> index 60ff7b4..0871659 100644
> --- a/drivers/soc/qcom/scm-boot.c
> +++ b/drivers/soc/qcom/scm-boot.c
> @@ -21,6 +21,23 @@
>   #include <soc/qcom/scm.h>
>   #include <soc/qcom/scm-boot.h>
>
> +#define SCM_FLAG_WARMBOOT_CPU0		0x04
> +#define SCM_FLAG_WARMBOOT_CPU1		0x02
> +#define SCM_FLAG_WARMBOOT_CPU2		0x10
> +#define SCM_FLAG_WARMBOOT_CPU3		0x40
> +
> +struct scm_warmboot {
> +	int flag;
> +	void *entry;
> +};
> +
> +static struct scm_warmboot scm_flags[] =3D {
> +	{ .flag =3D SCM_FLAG_WARMBOOT_CPU0 },
> +	{ .flag =3D SCM_FLAG_WARMBOOT_CPU1 },
> +	{ .flag =3D SCM_FLAG_WARMBOOT_CPU2 },
> +	{ .flag =3D SCM_FLAG_WARMBOOT_CPU3 },
> +};
> +
>   /*
>    * Set the cold/warm boot address for one of the CPU cores.
>    */
> @@ -37,3 +54,17 @@ int scm_set_boot_addr(phys_addr_t addr, int flags)
>   			&cmd, sizeof(cmd), NULL, 0);
>   }
>   EXPORT_SYMBOL(scm_set_boot_addr);
> +
> +int scm_set_warm_boot_addr(void *entry, int cpu)
> +{
> +	int ret;
> +
> +	if (entry =3D=3D scm_flags[cpu].entry)
> +		return 0;

IMO, this test deserves a comment of why this is needed.

> +
> +	ret =3D scm_set_boot_addr(virt_to_phys(entry), scm_flags[cpu].flag)=
;
> +	if (!ret)
> +		scm_flags[cpu].entry  =3D entry;
> +
> +	return ret;
> +}
> diff --git a/include/soc/qcom/scm-boot.h b/include/soc/qcom/scm-boot.=
h
> index 6aabb24..529f55a 100644
> --- a/include/soc/qcom/scm-boot.h
> +++ b/include/soc/qcom/scm-boot.h
> @@ -16,9 +16,8 @@
>   #define SCM_FLAG_COLDBOOT_CPU1		0x01
>   #define SCM_FLAG_COLDBOOT_CPU2		0x08
>   #define SCM_FLAG_COLDBOOT_CPU3		0x20
> -#define SCM_FLAG_WARMBOOT_CPU0		0x04
> -#define SCM_FLAG_WARMBOOT_CPU1		0x02
>
>   int scm_set_boot_addr(phys_addr_t addr, int flags);
> +int scm_set_warm_boot_addr(void *entry, int cpu);
>
>   #endif
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

