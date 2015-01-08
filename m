From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] drivers: cpuidle: don't initialize big.LITTLE driver
 if MCPM is unavailable
Date: Thu, 08 Jan 2015 16:01:43 +0530
Message-ID: <54AE5C8F.9080600@arm.com>
References: <1420698544-10277-1-git-send-email-sudeep.holla@arm.com>
 <54AE459B.8010703@linaro.org> <54AE4ADF.3030307@arm.com>
 <54AE55CE.6040201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54AE55CE.6040201@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "nicolas.pitre@linaro.org" <nicolas.pitre@linaro.org>, Kevin Hilman <kevin.hilman@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Thursday 08 January 2015 03:32 PM, Daniel Lezcano wrote:
> On 01/08/2015 10:16 AM, Sudeep Holla wrote:
>> Hi Daniel,
>>
>> On Thursday 08 January 2015 02:23 PM, Daniel Lezcano wrote:
>>> On 01/08/2015 07:29 AM, Sudeep Holla wrote:
>>>> If big.LITTLE driver is initialized even when MCPM is
>>>> unavailable, we get the below warning the first time cpu tries
>>>>  to enter deeper C-states.
>>>
>>> Can you elaborate why MCPM could be unavailable when the tc2 pm
>>> code registers the mcpm platform ops before the cpuidle driver ?
>>>
>>>
>> I can think of 3 possible scenarios. Let me know if these make
>> sense.
>>
>> 1. If the firmware settings in Vexpress configuration files are set
>> to boot in legacy mode, but MCPM is enabled in the kernel.
>
> If I am not wrong, we have a BUG_ON in this path, right ?
>

No we can't do that. E.g. on TC2 we should continue to boot in legacy
mode though none of the power management features work which is fine.
One scenario is I don't want to recompile the kernel, but try legacy
boot on TC2 flipping the firmware setting.

>> 2. If some failure occurs during MCPM initialization 3. For
>> example, if CCI is not accessible as in some Exynos boards [1], we
>>  don't want to wait till mpcm_cpu_suspend ?
>
> Well, I think if the firmware is preventing us to play with the CCI
> but MCPM is enabled. We should add BUG_ON also in the same

Again why if alternate method of booting exists with limited/no PM features.

> initialization path. IIRC, Kevin spent some time to figure out what
> was happening to its odroid-xu3 board before understanding mcpm
> wasn't able to deal with the CCI due to the broken firmware.
>

I agree, I did follow that thread, though I don't fully understand if
there exists alternate boot protocol on such boards. For sure TC2 or
Vexpress with any coretile in general have legacy boot support.

> The patch you are proposing is valid. Nevertheless, I would really
> like to have the firmwares to be fixed and your patch is hiding an
> incompatible firmware with the kernel configuration and letting the
> kernel continue to work in degraded mode.
>

I fully agree, but most of the time this argument is suppressed by
saying the product is shipped and firmware can't be upgraded.

> IMO, it would be better to be more strict with the mcpm
> initialization and not let the system boot if something is wrong with
> it which I believe is coming from the firmware and let the user to
> figure out what is really happening by letting him to disable mcpm in
> the kernel configuration (which in turn will disable cpuidle).

Again I fully agree, but in this case I manually switched to legacy boot
mode on TC2 and used same kernel with MCPM config enabled. Do you mean
to say we should not support that even when developer understand the
consequence of that ?

Regards,
Sudeep
