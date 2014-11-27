From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Thu, 27 Nov 2014 09:54:53 +0000
Message-ID: <5476F4ED.6040206@arm.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org>	<5476071B.1060705@arm.com> <CAKohpomFE6xg+HfOicha4Ntkr9osqDK2gxdKce=BU_q35jfBxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54040 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754764AbaK0Jyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Nov 2014 04:54:53 -0500
In-Reply-To: <CAKohpomFE6xg+HfOicha4Ntkr9osqDK2gxdKce=BU_q35jfBxA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>

Hi,

On 27/11/14 05:29, Viresh Kumar wrote:
> Hi Sudeep,
>
> On 26 November 2014 at 22:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On 26/11/14 08:46, Viresh Kumar wrote:
>>> We only need to have one entry in cpus@cpu0 node which will match with
>>> drivers
>>> name.
>
>> This seems fundamentally broken as the driver always needs to
>> unconditionally refer to cpu0. Furthermore the node need not be called
>> cpu0 as the name depends on its reg field.
>
> I meant CPU0's node, whatever the name is. Its normally cpu0 now a days
> but yes it can be something else as well :)
>

Not really ;), have a look @ arch/arm/boot/dts/highbank.dts

>>> We can then add another file drivers/cpufreq/device_dt.c, which will add a
>>> platform device with the name it finds from cpus@cpu0 node and existing
>>> drivers
>>> will work without any change. Or something else if somebody have a better
>>> proposal. But lets fix the bindings first.
>>
>> IIUC you will retain the existing list of cpufreq-dt platform device
>> creation as is. If not that breaks compatibility with old DT.
>
> I couldn't get what exactly you understood :), but this is what I meant.
> - Currently cpufreq drivers (like cpufreq-dt.c) are registering a
> platform_driver
> and platform specific code are registering a platform-device to match to this
> driver.
> - What will change is this platform specific code. The driver will stay as is.
> - Now the devices wouldn't get created from platform-specific code, but
> cpufreq core (may be a separate file for this: device_dt.c) will create platform
> device based on the string it got from DT.
>
> Makes sense?
>

No that won't suffice. You can't modify the DTs of the platforms using
cpufreq-dt.c as of today. They should continue to work, so either you
retain all the existing platform device creation in platform code as is
or do something like below with the blacklist for those platforms.

>
>>> +Optional properties:
>>> +- dvfs-method: CPUFreq driver to probe. For example: "arm-bL-cpufreq-dt",
>>> +  "cpufreq-dt", etc
>>
>> You should manage this with compatible rather than a new property as
>> it's not a real hardware property. IMHO Rob's suggestion[1] should work
>> fine.
>>
>> IIUC, you can have the driver which create this platform device if DT
>> has generic compatible unconditionally(e.g "cpufreq-dt" as you have
>> chosen above). For all existing DT you can create a blacklist of
>> compatibles to match(as it doesn't have the generic compatible) covering
>
> I didn't get why you asked for a blacklist here. Why wouldn't "cpufreq-dt" in
> compatible work for them ?
>

Again for backward compatibility reasons :)

>> all the existing platforms using cpufreq-dt driver, there by you can
>> even remove the platform device creating from multiple places.
>
> Yeah, we can remove all such occurrences for a single driver this way.
> What I was suggesting earlier was to do this from a driver independent
> file, so that its done once for all possible DT drivers. Like "cpufreq-dt",
> "arm_big_little_dt". The same compatible property can be used there
> too..
>
>> IMO something like the patch below should work(not tested, also
>> late_initcall is used just to demonstrate the idea)
>>
>> Rob, please correct me if my understanding is wrong.
>
>> +static const struct of_device_id compatible_machine_match[] = {
>> +       /* All new machines must have the below compatible to use this
>> driver */
>> +       { .compatible = "cpufreq-generic-dt" },
>> +       /* BLACKLIST of existing users of cpufreq-dt below */
>> +       { .compatible = "samsung,exynos5420" },
>> +       { .compatible = "samsung,exynos5800" },
>> +       {},
>> +};
>> +
>> +static int cpufreq_generic_dt_init(void)
>> +{
>> +       struct device_node *root = of_find_node_by_path("/");
>> +       struct platform_device_info devinfo = { .name = "cpufreq-dt", };
>> +       /*
>> +        * Initialize the device for the platforms either
>> +        * blacklisted or compliant to generic compatible
>> +        */
>> +       if (!of_match_node(compatible_machine_match, root))
>> +               return -ENODEV;
>> +
>> +       /* Instantiate cpufreq-dt */
>> +       platform_device_register_full(&devinfo);
>> +       return 0;
>> +}
>> +late_initcall(cpufreq_generic_dt_init);
>
> Looks fine to me. Looks similar to what I had in mind for creating
> devices from platform-independent code.
>
OK, in this way you still continue to work on existing platforms with
*old DT*.

Regards,
Sudeep

