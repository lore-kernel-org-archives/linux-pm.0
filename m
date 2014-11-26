From: ethan <ethan.kernel@gmail.com>
Subject: Re: [PATCH 2/2 v3] intel_pstate: add kernel parameter to enable loading on  Sun X86 servers.
Date: Wed, 26 Nov 2014 08:08:35 +0800
Message-ID: <D6E27056-FD4B-479A-8764-324696A83C05@gmail.com>
References: <1416891578-14171-1-git-send-email-ethan.zhao@oracle.com> <1416891578-14171-3-git-send-email-ethan.zhao@oracle.com> <54749777.7020802@intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <54749777.7020802@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: Ethan Zhao <ethan.zhao@oracle.com>, "linda.knippers@hp.com" <linda.knippers@hp.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "corbet@lwn.net" <corbet@lwn.net>, "dirk.j.brandewie@intel.com" <dirk.j.brandewie@intel.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dirk,

> =D4=DA 2014=C4=EA11=D4=C225=C8=D5=A3=AC22:51=A3=ACDirk Brandewie <dir=
k.brandewie@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
>> On 11/24/2014 08:59 PM, Ethan Zhao wrote:
>> To force loading on Oracle Sun X86 servers, provide one kernel comma=
nd line
>> parameter
>>=20
>>   intel_pstate =3D onora
>>=20
>> For those who be aware of the risk doing so.
>>=20
>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
>> ---
>>  v2: change to hardware vendor specific naming parameter.
>>=20
>>  Documentation/kernel-parameters.txt | 3 +++
>>  drivers/cpufreq/intel_pstate.c      | 6 +++++-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/ker=
nel-parameters.txt
>> index 479f332..e4b1b81 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -1446,6 +1446,9 @@ bytes respectively. Such letter suffixes can a=
lso be entirely omitted.
>>                 disable
>>                   Do not enable intel_pstate as the default
>>                   scaling driver for the supported processors
>> +               onora
>> +                 Enable loading intel_pstate on Oracle Sun Servers(=
X86).
>> +             only for those who be aware of the risk.
>=20
> What are the risks?  What is the behaviour if platform power manageme=
nt is
> enabled and intel_pstate is trying to control P state selection as we=
ll?
So far test shows intel_pstate could run.
>=20
> If intel_pstate will be able to successfully control P state selectio=
n
> with platform power management enabled then how about the name "oracl=
e_force"?
Oracle_force seems a suggestion from oracle, not an option would be use=
d as choice
In case of no other method.

> Also the documentation should say what the risks are.

The risk is the sever lost power capping capability, that may cause ser=
vice down, for example,
The server has two power supply units, one is faulty, without power cap=
ping, could't limit the power consumption within one power supply's cap=
ability, this could cause the last power supply
Unit overload and power down.

Thanks,
Ethan
>=20
>>=20
>>      intremap=3D    [X86-64, Intel-IOMMU]
>>              on    enable Interrupt Remapping (default)
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index fa67fb3..e49b050 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -866,6 +866,7 @@ static struct cpufreq_driver intel_pstate_driver=
 =3D {
>>  };
>>=20
>>  static int __initdata no_load;
>> +static unsigned int  load_on_sun;
>>=20
>>  static int intel_pstate_msrs_not_valid(void)
>>  {
>> @@ -1005,7 +1006,8 @@ static bool intel_pstate_platform_pwr_mgmt_exi=
sts(void)
>>          if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE) =
&&
>>              !strncmp(hdr.oem_table_id, v_info->oem_table_id,
>>                  ACPI_OEM_TABLE_ID_SIZE) &&
>> -            intel_pstate_has_acpi_ppc())
>> +            intel_pstate_has_acpi_ppc() &&
>> +            !load_on_sun)
>>              return true;
>>      }
>>=20
>> @@ -1080,6 +1082,8 @@ static int __init intel_pstate_setup(char *str=
)
>>=20
>>      if (!strcmp(str, "disable"))
>>          no_load =3D 1;
>> +    if (!strcmp(str, "onora"))
>> +        load_on_sun =3D 1;
>>      return 0;
>>  }
>>  early_param("intel_pstate", intel_pstate_setup);
>=20
