From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 5 Dec 2014 08:45:26 -0700
Message-ID: <20141205154526.GC2995@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org>
 <8625951.Wbs2MxLnhi@wuerfel>
 <20141204162834.GA2995@linaro.org>
 <2519415.GklIQeMgWR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2519415.GklIQeMgWR@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 04 2014 at 11:20 -0700, Arnd Bergmann wrote:
>On Thursday 04 December 2014 09:28:34 Lina Iyer wrote:
>> On Thu, Dec 04 2014 at 02:02 -0700, Arnd Bergmann wrote:
>> >On Thursday 04 December 2014 09:52:39 Daniel Lezcano wrote:
>> >> On 12/03/2014 09:35 PM, Arnd Bergmann wrote:
>> >> > On Wednesday 03 December 2014 07:31:22 Lina Iyer wrote:
>> >> >>>>> +static int __init qcom_spm_init(void)
>> >> >>>>> +{
>> >> >>>>> +    int ret;
>> >> >>>>> +
>> >> >>>>> +    /*
>> >> >>>>> +     * cpuidle driver need to registered before the cpuidle device
>> >> >>>>> +     * for any cpu. Register the device for the the cpuidle driver.
>> >> >>>>> +     */
>> >> >>>>> +    ret = platform_device_register(&qcom_cpuidle_drv);
>> >> >>>>> +    if (ret)
>> >> >>>>> +        return ret;
>> >> >>>> Stephen pointed out that we would have the platform device lying around
>> >> >>>> on a non-QCOM device when using multi_v7_defconfig.
>> >> >>>
>> >> >>> Perhaps I am missing the point, but this is not supposed to happen, no ?
>> >> >>>
>> >> >> This would happen, since the file would compile on multi_v7 and we would
>> >> >> initialize and register this device regardless. The cpuidle-qcom.c
>> >> >> driver probe would bail out looking for a matching compatible property.
>> >> >> So we would not register a cpuidle driver but the device would lay
>> >> >> around.
>> >> >
>> >> > I think the problem is registering a platform_device. I've complained
>> >> > about this before, but it still seems to get copied all over the
>> >> > place. Please don't do this but have a driver that looks at DT to
>> >> > figure out whether to access hardware or not.
>> >>
>> >> We did this approach but, I can remember why, someone was complaining
>> >> about it also
>> >>
>> >> The platform device/driver paradigm allowed us to split the arch
>> >> specific parts by passing the pm ops through the platform data.
>> >>
>> >> Would make sense to have a single common place for the ARM arch where we
>> >> initialize the platform device for cpuidle ?
>> >
>> >No. It's really not a device, and if you pretend that it is, you get
>> >into problems like this.
>>
>> Arnd, the problem is that the provides function pointers to the SoC code
>> that the cpuilde driver uses to call based on the idle state.
>>
>> After much discussions, we came down to using function pointers from
>> translating from DT strings, other than using that again, I dont see a
>> good way of achieving the ability of cpuidle driver staying a separate
>> driver from the SPM driver.
>>
>> Daniel, thoughts?
>
>Maybe the problem is trying too hard to separate two things that really
>belong together then. In general, the strategy of coming up with subsystems
>for a class of devices and them turning platform code into drivers for
>that subsystem has worked out really well, but I think for cpufreq, cpuidle
>and smp, it really hasn't, and in the third case we haven't even tried
>coming up with a subsystem for that reason.
>
>Having all cpuidle code generally live in drivers/cpuidle is still a good
>idea IMO, but using a platform device just for the purpose of passing
>data between some platform specific code and another platform specific
>driver hasn't worked out that well here.
>
To achieve both, I cant think of a better way to initialize the cpuidle
driver without the use of reference count (0 ==>
platform_driver_register).

I tried creating dummy platform device in the DT but something or
another gives in to an ugly implementation.

Any other ideas?

Lina.
