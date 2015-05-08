From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH RFC 2/5] ACPI / processor: always compile perflib if CONFIG_ACPI_PROCESSOR
Date: Fri, 08 May 2015 16:52:48 +0800
Message-ID: <554C7960.4040107@linaro.org>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>	<1430922690-6966-3-git-send-email-sudeep.holla@arm.com> <CAJ5Y-eYJ9ydv3Meoco3o9KHhSXSxrRmot1ZW2_ZJosG4h+eprg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34621 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbbEHIxf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 04:53:35 -0400
Received: by pdbqa5 with SMTP id qa5so71682893pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2015 01:53:34 -0700 (PDT)
In-Reply-To: <CAJ5Y-eYJ9ydv3Meoco3o9KHhSXSxrRmot1ZW2_ZJosG4h+eprg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On 2015=E5=B9=B405=E6=9C=8807=E6=97=A5 02:36, Ashwin Chaugule wrote:
> Hello,
>
> On 6 May 2015 at 10:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Similar to the  idle, thermal and throttling libraries, always compi=
le
>> the perflib if CONFIG_ACPI_PROCESSOR is enabled. This not only makes
>> perflib alligned with other libraries but also helps in some sanity
>> testing of these ACPI methods even when a particular feature is not
>> enabled in the kernel configuration.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/acpi/Makefile    |  2 +-
>>   include/acpi/processor.h | 29 -----------------------------
>>   include/linux/cpufreq.h  |  4 ++++
>>   3 files changed, 5 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>> index 8a063e276530..33aef9d8b260 100644
>> --- a/drivers/acpi/Makefile
>> +++ b/drivers/acpi/Makefile
>> @@ -84,7 +84,7 @@ obj-$(CONFIG_ACPI_BGRT)               +=3D bgrt.o
>>   # processor has its own "processor." module_param namespace
>>   processor-y                    :=3D processor_driver.o processor_t=
hrottling.o
>>   processor-y                    +=3D processor_idle.o processor_the=
rmal.o
>> -processor-$(CONFIG_CPU_FREQ)   +=3D processor_perflib.o
>> +processor-y                    +=3D processor_perflib.o
>
> I'd prefer that we create a separate kconfig option for this. (perhap=
s
> even default it to 'y'). This library is quite specific to a certain
> type of CPU performance management methods (includes _PSS and friends=
)
> which are superseded by CPPC. The OS is not expected to support both
> at runtime, so by keeping this a config option, we can then disable i=
t
> at compile time when CPPC is enabled. We could couple

I agree. CPPC and _PSS are different way of controlling CPU freq,
and I think _PSS may not be used on ARM.

Thanks
Hanjun
