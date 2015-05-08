From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 2/5] ACPI / processor: always compile perflib if CONFIG_ACPI_PROCESSOR
Date: Fri, 08 May 2015 11:06:26 +0100
Message-ID: <554C8AA2.8020105@arm.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>	<1430922690-6966-3-git-send-email-sudeep.holla@arm.com> <CAJ5Y-eYJ9ydv3Meoco3o9KHhSXSxrRmot1ZW2_ZJosG4h+eprg@mail.gmail.com> <554C7960.4040107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <554C7960.4040107@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "ahs3@redhat.com" <ahs3@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org



On 08/05/15 09:52, Hanjun Guo wrote:
> On 2015=E5=B9=B405=E6=9C=8807=E6=97=A5 02:36, Ashwin Chaugule wrote:
>> Hello,
>>
>> On 6 May 2015 at 10:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>> Similar to the  idle, thermal and throttling libraries, always comp=
ile
>>> the perflib if CONFIG_ACPI_PROCESSOR is enabled. This not only make=
s
>>> perflib alligned with other libraries but also helps in some sanity
>>> testing of these ACPI methods even when a particular feature is not
>>> enabled in the kernel configuration.
>>>
>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>> ---
>>>    drivers/acpi/Makefile    |  2 +-
>>>    include/acpi/processor.h | 29 -----------------------------
>>>    include/linux/cpufreq.h  |  4 ++++
>>>    3 files changed, 5 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>> index 8a063e276530..33aef9d8b260 100644
>>> --- a/drivers/acpi/Makefile
>>> +++ b/drivers/acpi/Makefile
>>> @@ -84,7 +84,7 @@ obj-$(CONFIG_ACPI_BGRT)               +=3D bgrt.o
>>>    # processor has its own "processor." module_param namespace
>>>    processor-y                    :=3D processor_driver.o processor=
_throttling.o
>>>    processor-y                    +=3D processor_idle.o processor_t=
hermal.o
>>> -processor-$(CONFIG_CPU_FREQ)   +=3D processor_perflib.o
>>> +processor-y                    +=3D processor_perflib.o
>>
>> I'd prefer that we create a separate kconfig option for this. (perha=
ps
>> even default it to 'y'). This library is quite specific to a certain
>> type of CPU performance management methods (includes _PSS and friend=
s)
>> which are superseded by CPPC. The OS is not expected to support both
>> at runtime, so by keeping this a config option, we can then disable =
it
>> at compile time when CPPC is enabled. We could couple
>
> I agree. CPPC and _PSS are different way of controlling CPU freq,
> and I think _PSS may not be used on ARM.
>

While I agree having a separate config option is good, but I won't
assume _PSS might not be used on ARM as I have seen patches posted on
the list in past to use _PSS on ARM platform[1].

Regards,
Sudeep

[1] http://marc.info/?l=3Dlinaro-acpi&m=3D139745485418399&w=3D2
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
