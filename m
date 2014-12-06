From: ethan <ethan.kernel@gmail.com>
Subject: Re: [PATCH 2/2 V8] intel_pstate: add kernel parameter to force loading.
Date: Sat, 6 Dec 2014 10:16:37 +0800
Message-ID: <CEF8DE9B-262F-4EED-B982-9CD52617EEC5@gmail.com>
References: <1417772453-22483-1-git-send-email-ethan.zhao@oracle.com> <5481D8B9.2030603@hp.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5481D8B9.2030603@hp.com>
Sender: linux-doc-owner@vger.kernel.org
To: Linda Knippers <linda.knippers@hp.com>
Cc: Ethan Zhao <ethan.zhao@oracle.com>, "dirk.j.brandewie@intel.com" <dirk.j.brandewie@intel.com>, "kristen@linux.intel.com" <kristen@linux.intel.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "corbet@lwn.net" <corbet@lwn.net>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "alexey.kodanev@oracle.com" <alexey.kodanev@oracle.com>
List-Id: linux-pm@vger.kernel.org

Linda=A3=AC

> =D4=DA 2014=C4=EA12=D4=C26=C8=D5=A3=AC00:09=A3=ACLinda Knippers <lind=
a.knippers@hp.com> =D0=B4=B5=C0=A3=BA
>=20
>> On 12/5/2014 4:40 AM, Ethan Zhao wrote:
>> To force loading on Oracle Sun X86 servers, provide one kernel comma=
nd line
>> parameter
>>=20
>>  intel_pstate =3D force
>>=20
>> For those who be aware of the risk of no power capping capabily work=
ing and
>> try to get better performance with this driver.
>>=20
>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
>> Tested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
>> ---
>> v2: change to hardware vendor specific naming parameter.
>> v4: refine code and doc.
>> v5&v6: fix a typo in doc.
>> v7: change enum PCC to PPC.
>> v8: change the name of kernel command line parameter to generic one.
>>=20
>> Documentation/kernel-parameters.txt | 5 +++++
>> drivers/cpufreq/intel_pstate.c      | 6 +++++-
>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/ker=
nel-parameters.txt
>> index 479f332..7d0983e 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -1446,6 +1446,11 @@ bytes respectively. Such letter suffixes can =
also be entirely omitted.
>>               disable
>>                 Do not enable intel_pstate as the default
>>                 scaling driver for the supported processors
>> +               force
>> +             Enable intel_pstate on systems where it may cause prob=
lems to
>> +             happen due to conflicts with platform firmware attempt=
ing to
>> +             drive P-states by itself in certain situations (for th=
ermal=20
>> +             control or power capping in general or other purposes)=
=2E
>=20
> I suggest something like:
>            Enable intel_pstate on systems that prohibit it by
>            default in favor of acpi-cpufreq.  Forcing the
>            intel_pstate driver instead of acpi-cpufreq may disable
>            platform features, such as thermal controls and power
>            capping, that rely on ACPI p-state information being
                                                         P-States=20
>             Used by the OS and therefore should be used with care.
               Indicated to OSPM                                       =
            caution=20
>            This option does not work with processors that aren't
>            supported by the intel_pstate driver or on platforms
>            that use pcc-cpufreq instead of acpi-cpufreq.
>=20
> Maybe this is too specific but I believe it is accurate.  Comments?
>=20

Looks better to me, except some words commented.=20

Thanks,
Ethan
> -- ljk
>=20
>>=20
>>    intremap=3D    [X86-64, Intel-IOMMU]
>>            on    enable Interrupt Remapping (default)
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index 1bb62ca..2654e13 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -866,6 +866,7 @@ static struct cpufreq_driver intel_pstate_driver=
 =3D {
>> };
>>=20
>> static int __initdata no_load;
>> +static unsigned int  force_load;
>>=20
>> static int intel_pstate_msrs_not_valid(void)
>> {
>> @@ -1003,7 +1004,8 @@ static bool intel_pstate_platform_pwr_mgmt_exi=
sts(void)
>>            case PSS:
>>                return intel_pstate_no_acpi_pss();
>>            case PPC:
>> -                return intel_pstate_has_acpi_ppc();
>> +                return intel_pstate_has_acpi_ppc() &&
>> +                    (!force_load);
>>            }
>>    }
>>=20
>> @@ -1078,6 +1080,8 @@ static int __init intel_pstate_setup(char *str=
)
>>=20
>>    if (!strcmp(str, "disable"))
>>        no_load =3D 1;
>> +    if (!strcmp(str, "force"))
>> +        force_load =3D 1;
>>    return 0;
>> }
>> early_param("intel_pstate", intel_pstate_setup);
>=20
