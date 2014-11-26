From: ethan <ethan.kernel@gmail.com>
Subject: Re: [PATCH 1/2 v3] intel_pstate: skip this driver if Sun server has _PPC method
Date: Wed, 26 Nov 2014 08:15:32 +0800
Message-ID: <51EBF1F9-C972-4A40-BC44-944E4DD71CDD@gmail.com>
References: <1416891578-14171-1-git-send-email-ethan.zhao@oracle.com> <1416891578-14171-2-git-send-email-ethan.zhao@oracle.com> <547498BC.9020704@intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <547498BC.9020704@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Ethan Zhao <ethan.zhao@oracle.com>, "linda.knippers@hp.com" <linda.knippers@hp.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "corbet@lwn.net" <corbet@lwn.net>, "dirk.j.brandewie@intel.com" <dirk.j.brandewie@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dirk,

> =D4=DA 2014=C4=EA11=D4=C225=C8=D5=A3=AC22:57=A3=ACDirk Brandewie <dir=
k.brandewie@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
>> On 11/24/2014 08:59 PM, Ethan Zhao wrote:
>> Oracle Sun X86 servers have dynamic power capping capability that wo=
rks via
>> ACPI _PPC method etc, so skip loading this driver if Sun server has =
ACPI _PPC
>> enabled.
> How about this patch? only compile tested.
>=20
Looks good to me, and obviously my one is much simpler :)
I will test it and give you feed back.

Thanks,
Ethan

> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_p=
state.c
> index 3468387..db7b8b2 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1025,15 +1025,46 @@ static bool intel_pstate_no_acpi_pss(void)
>    return true;
> }
>=20
> +static bool intel_pstate_has_acpi_ppc(void)
> +{
> +    int i;
> +
> +    for_each_possible_cpu(i) {
> +        struct acpi_processor *pr =3D per_cpu(processors, i);
> +
> +        if (!pr)
> +            continue;
> +        if (acpi_has_method(pr->handle, "_PPC"))
> +            return true;
> +    }
> +    return false;
> +}
> +
> +enum {
> +    PSS,
> +    PCC,
> +};
> +
> struct hw_vendor_info {
>    u16  valid;
>    char oem_id[ACPI_OEM_ID_SIZE];
>    char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> +    int  oem_pwr_table;
> };
>=20
> /* Hardware vendor-specific info that has its own power management mo=
des */
> static struct hw_vendor_info vendor_info[] =3D {
> -    {1, "HP    ", "ProLiant"},
> +    {1, "HP    ", "ProLiant", PSS},
> +    {1, "ORACLE", "X4-2    ", PCC},
> +    {1, "ORACLE", "X4-2L   ", PCC},
> +    {1, "ORACLE", "X4-2B   ", PCC},
> +    {1, "ORACLE", "X3-2    ", PCC},
> +    {1, "ORACLE", "X3-2L   ", PCC},
> +    {1, "ORACLE", "X3-2B   ", PCC},
> +    {1, "ORACLE", "X4470M2 ", PCC},
> +    {1, "ORACLE", "X4270M3 ", PCC},
> +    {1, "ORACLE", "X4270M2 ", PCC},
> +    {1, "ORACLE", "X4170M2 ", PCC},
>    {0, "", ""},
> };
>=20
> @@ -1057,15 +1088,20 @@ static bool intel_pstate_platform_pwr_mgmt_ex=
ists(void)
>=20
>    for (v_info =3D vendor_info; v_info->valid; v_info++) {
>        if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE) &&
> -            !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OE=
M_TABLE_ID_SIZE) &&
> -            intel_pstate_no_acpi_pss())
> -            return true;
> +            !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OE=
M_TABLE_ID_SIZE))
> +            switch (v_info->oem_pwr_table) {
> +            case PSS:
> +                return intel_pstate_no_acpi_pss();
> +            case PCC:
> +                return intel_pstate_has_acpi_ppc();
> +            }
>    }
>=20
>    return false;
> }
> #else /* CONFIG_ACPI not enabled */
> static inline bool intel_pstate_platform_pwr_mgmt_exists(void) { retu=
rn false; }
> +static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
> #endif /* CONFIG_ACPI */
>=20
> static int __init intel_pstate_init(void)
>=20
>=20
