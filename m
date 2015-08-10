From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 2/3] ARM: berlin: register cpufreq-dt for the BG2Q
Date: Mon, 10 Aug 2015 22:22:44 +0200
Message-ID: <55C90814.3050505@gmail.com>
References: <1438259752-16320-1-git-send-email-antoine.tenart@free-electrons.com> <1438259752-16320-3-git-send-email-antoine.tenart@free-electrons.com> <20150731141602.28b28f21@xhacker>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150731141602.28b28f21@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: zmxu@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 31.07.2015 08:16, Jisheng Zhang wrote:
> On Thu, 30 Jul 2015 14:35:51 +0200
> Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
>
>> The BG2Q SoC uses cpufreq-dt for cpufreq. Register a platform device for
>> this.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>> ---
[...]
>> diff --git a/arch/arm/mach-berlin/berlin.c b/arch/arm/mach-berlin/berlin.c
>> index ac181c6797ee..0de906374994 100644
>> --- a/arch/arm/mach-berlin/berlin.c
>> +++ b/arch/arm/mach-berlin/berlin.c
>> @@ -15,9 +15,21 @@
[...]
>> +static void __init berlin_init_late(void)
>> +{
>> +	if (of_find_matching_node(NULL, berlin2q_match))
>> +		platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>
> I'm not sure is it acceptable to always register cpufreq-dt platform device.
> In cpufreq-dt driver, the probe will exit if there's no cpuclk node.

Jisheng,

registering the _device_ without checking for any requirements of
the _driver_ is usual practice. It it the driver's job to check
all of them and report an error or warning. So, I am fine with
adding the device unconditionally.

Using the .init_late() callback seems reasonable - but can you
evaluate if we can have cpufreq-dt also for BG2/BG2CD? I'd also
accept a single, default operating-point.

BTW, there is one true point about Jisheng's comment: try to order
your patches logically correct to avoid unnecessary warnings, i.e.

1/3 add cpuclk
2/3 add cpufreq-dt properties
3/3 register cpufreq-dt device

If you consider a git-bisect run, you can land in between any of the
three patches but they are always in the above order - so ordering is
important.

Sebastian

>> +}
>> +
>>   static const char * const berlin_dt_compat[] = {
>>   	"marvell,berlin",
>>   	NULL,
>> @@ -25,6 +37,7 @@ static const char * const berlin_dt_compat[] = {
>>
>>   DT_MACHINE_START(BERLIN_DT, "Marvell Berlin")
>>   	.dt_compat	= berlin_dt_compat,
>> +	.init_late	= berlin_init_late,
>>   	/*
>>   	 * with DT probing for L2CCs, berlin_init_machine can be removed.
>>   	 * Note: 88DE3005 (Armada 1500-mini) uses pl310 l2cc
>
