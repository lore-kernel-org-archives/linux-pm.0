From: ethan zhao <ethan.zhao@oracle.com>
Subject: Re: [PATCH 3/3] intel_pstate: add module and kernel command line
 parameter to ignore ACPI _PPC
Date: Mon, 24 Nov 2014 09:56:31 +0800
Message-ID: <5472904F.8090009@oracle.com>
References: <1416299826-15813-1-git-send-email-ethan.zhao@oracle.com>	<1416299826-15813-8-git-send-email-ethan.zhao@oracle.com>	<20141119110548.24a0a808@kcaccard-desk.amr.corp.intel.com>	<41ADCDB8-C204-4661-833B-F68E7D687B61@gmail.com>	<20141120132317.00ad7210@kcaccard-desk.amr.corp.intel.com> <CABawtvO57bTEs2qCd1SRaOX-R24_VJYmHFLAoUatTRnmuenrdg@mail.gmail.com> <546EC6FE.1030807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:48407 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaKXB4r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 23 Nov 2014 20:56:47 -0500
In-Reply-To: <546EC6FE.1030807@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linda Knippers <ljklists@gmail.com>
Cc: Ethan Zhao <ethan.kernel@gmail.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "<dirk.j.brandewie@intel.com>" <dirk.j.brandewie@intel.com>, "<viresh.kumar@linaro.org>" <viresh.kumar@linaro.org>, "<rjw@rjwysocki.net>" <rjw@rjwysocki.net>, "<corbet@lwn.net>" <corbet@lwn.net>, "<linux-doc@vger.kernel.org>" <linux-doc@vger.kernel.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-pm@vger.kernel.org>" <linux-pm@vger.kernel.org>, "<joe.jin@oracle.com>" <joe.jin@oracle.com>, "<brian.maly@oracle.com>" <brian.maly@oracle.com>

Linda,

On 2014/11/21 13:00, Linda Knippers wrote:
>
> On 11/20/2014 10:07 PM, Ethan Zhao wrote:
>> Kristen,
>>     Whatever I would like there is a way to load intel_pstate and gi=
ve
>> it a try even it does not support all the PM features.
>>     I think 'force' is OK.
>> Linda,
>>    Do you like it ? if the 'intel_pstate=3Dforce' would force the dr=
iver
>> to be loaded on to HP too ?
> I'd prefer that it didn't.  If you force the intel_pstate driver when
> the platform thinks it's doing power management, then the OS and the
> firmware are trying to manage the power at the same time.  That's a
> mess.  If you want that for testing or debugging, what are you actual=
ly
> testing or debugging?  On an Oracle box, the firmware wouldn't stop
> doing whatever it's doing just because the intel_pstate driver is
> loaded, would it?
  Yes, the platform wouldn't stop doing PM and the SCI even the intel_p=
state
  was loaded.
  That option just give someone a chance who said "whatever I like=20
intel_pstate
  On Oracle Servers"
>
> I also wonder what it means to "force" the intel_pstate driver
> on systems with processors that aren't supported by the intel_pstate
> driver.  It wouldn't really be forced, would it?
  Yes, wouldn't, such as AMD cpu-id and some old intel CPUs released=20
before SandyBridge.
  So the best way to to do the 'force' should be specific enough for=20
"Oracle Sun server"

  Thanks,
  Ethan
>
> -- ljk
>
>> Thanks,
>> Ethan
>>
>> On Fri, Nov 21, 2014 at 5:23 AM, Kristen Carlson Accardi
>> <kristen@linux.intel.com> wrote:
>>> On Thu, 20 Nov 2014 08:57:34 +0800
>>> ethan <ethan.kernel@gmail.com> wrote:
>>>
>>>>
>>>>> =E5=9C=A8 2014=E5=B9=B411=E6=9C=8820=E6=97=A5=EF=BC=8C03:05=EF=BC=
=8CKristen Carlson Accardi <kristen@linux.intel.com> =E5=86=99=E9=81=93=
=EF=BC=9A
>>>>>
>>>>> On Tue, 18 Nov 2014 17:37:06 +0900
>>>>> Ethan Zhao <ethan.zhao@oracle.com> wrote:
>>>>>
>>>>>> Add kernel command line parameter
>>>>>> intel_pstate =3D ignore_acpi_ppc
>>>>>> and module parameter
>>>>>> ignore_acpi_ppc =3D 1
>>>>>> to allow driver to ignore the ACPI _PPC existence even for Sun x=
86 servers.
>>>>>> These parameter could be used for debug\test\workaround etc purp=
ose.
>>>>>>
>>>>>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
>>>>> What if we used a more generic parameter like "force" that would =
bypass
>>>>> any vendor specific checks and just load anyway?  This way we don=
't have
>>>>> to add new parameters everything some new thing shows up that we =
want to
>>>>> ignore.
>>>>>
>>>> To be honest, I prefer more generic parameter. But to avoid the po=
ssible negative affect
>>>> To another vendors. I back to this way.
>>> Well, your parameter can still impact other vendors as it is.  it
>>> is pretty typical to assume that using a parameter like "force" mea=
ns
>>> you know what you are doing and accept the risks.  Especially if it=
s
>>> documented as such.
>>>
>>>> Thanks,
>>>> Ethan
>>>>>> ---
>>>>>> Documentation/kernel-parameters.txt | 3 +++
>>>>>> drivers/cpufreq/intel_pstate.c      | 8 +++++++-
>>>>>> 2 files changed, 10 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/kernel-parameters.txt b/Documentation=
/kernel-parameters.txt
>>>>>> index 4c81a86..f502b85 100644
>>>>>> --- a/Documentation/kernel-parameters.txt
>>>>>> +++ b/Documentation/kernel-parameters.txt
>>>>>> @@ -1446,6 +1446,9 @@ bytes respectively. Such letter suffixes c=
an also be entirely omitted.
>>>>>>                disable
>>>>>>                  Do not enable intel_pstate as the default
>>>>>>                  scaling driver for the supported processors
>>>>>> +               ignore_acpi_ppc
>>>>>> +             Ignore the existence of ACPI method _PPC for Sun x=
86 servers
>>>>>> +             and load the driver.
>>>>>>
>>>>>>     intremap=3D    [X86-64, Intel-IOMMU]
>>>>>>             on    enable Interrupt Remapping (default)
>>>>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/in=
tel_pstate.c
>>>>>> index 7c5faea..388387b 100644
>>>>>> --- a/drivers/cpufreq/intel_pstate.c
>>>>>> +++ b/drivers/cpufreq/intel_pstate.c
>>>>>> @@ -870,6 +870,7 @@ static struct cpufreq_driver intel_pstate_dr=
iver =3D {
>>>>>> };
>>>>>>
>>>>>> static int __initdata no_load;
>>>>>> +static unsigned int  ignore_acpi_ppc;
>>>>>>
>>>>>> static int intel_pstate_msrs_not_valid(void)
>>>>>> {
>>>>>> @@ -990,7 +991,7 @@ static bool intel_pstate_platform_pwr_mgmt_e=
xists(void)
>>>>>>             intel_pstate_no_acpi_pss())
>>>>>>             return true;
>>>>>>         if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZ=
E) &&
>>>>>> -            intel_pstate_has_acpi_ppc())
>>>>>> +            intel_pstate_has_acpi_ppc() && !ignore_acpi_ppc)
>>>>>>             return true;
>>>>>>     }
>>>>>>
>>>>>> @@ -1066,11 +1067,16 @@ static int __init intel_pstate_setup(cha=
r *str)
>>>>>>
>>>>>>     if (!strcmp(str, "disable"))
>>>>>>         no_load =3D 1;
>>>>>> +    if (!strcmp(str, "ignore_acpi_ppc"))
>>>>>> +        ignore_acpi_ppc =3D 1;
>>>>>>     return 0;
>>>>>> }
>>>>>> early_param("intel_pstate", intel_pstate_setup);
>>>>>> #endif
>>>>>>
>>>>>> +module_param(ignore_acpi_ppc, uint, 0644);
>>>>>> +MODULE_PARM_DESC(ignore_acpi_ppc,
>>>>>> +    "value 0 or non-zero. non-zero -> ignore ACPI _PPC and load=
 this driver");
>>>>>> MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
>>>>>> MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core p=
rocessors");
>>>>>> MODULE_LICENSE("GPL");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

