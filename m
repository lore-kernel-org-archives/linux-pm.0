From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Invert CPUIDLE_FLAG_TIME_VALID logic
Date: Mon, 17 Nov 2014 13:53:15 +0100
Message-ID: <5469EFBB.6000806@linaro.org>
References: <1415804630-5055-1-git-send-email-daniel.lezcano@linaro.org> <20141113145609.GA9726@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20141113145609.GA9726@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "tony@atomide.com" <tony@atomide.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-a
List-Id: linux-pm@vger.kernel.org

On 11/13/2014 03:56 PM, Lorenzo Pieralisi wrote:
> On Wed, Nov 12, 2014 at 03:03:50PM +0000, Daniel Lezcano wrote:
>> The only place where the time is invalid is when the ACPI_CSTATE_FFH=
 entry
>> method is not set. Otherwise for all the drivers, the time can be co=
rrectly
>> measured.
>>
>> Instead of duplicating the CPUIDLE_FLAG_TIME_VALID flag in all the d=
rivers
>> for all the states, just invert the logic by replacing it by the fla=
g
>> CPUIDLE_FLAG_TIME_INVALID, hence we can set this flag only for the a=
cpi idle
>> driver, remove the former flag from all the drivers and invert the l=
ogic with
>> this flag in the different governor.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Are we sure that ACPI C1 invalid residency time is *still* an issue a=
fter
> we moved the residency accounting to the idle core ?

(Cc'ed linux-acpi@)

Hi x86 guys,

any comment on that ?

Thanks in advance

  -- Daniel

> I have a feeling you can remove this flag entirely, but I will let x8=
6
> guys speak for themselves.

[ ... ]

>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index 17f9ec5..380b4b4 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -985,8 +985,8 @@ static int acpi_processor_setup_cpuidle_states(s=
truct acpi_processor *pr)
>>                  state->flags =3D 0;
>>                  switch (cx->type) {
>>                          case ACPI_STATE_C1:
>> -                       if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
>> -                               state->flags |=3D CPUIDLE_FLAG_TIME_=
VALID;
>> +                       if (cx->entry_method !=3D ACPI_CSTATE_FFH)
>> +                               state->flags |=3D CPUIDLE_FLAG_TIME_=
INVALID;

[ ... ]


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
