From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC] cpufreq: Add "dvfs-method" binding to probe cpufreq drivers
Date: Wed, 26 Nov 2014 17:04:33 +0000
Message-ID: <54760821.5020909@arm.com>
References: <596a6d49f2b3e2837aa9a54a3e1249161d3c9265.1416991009.git.viresh.kumar@linaro.org> <5476071B.1060705@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38554 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaKZREg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 12:04:36 -0500
In-Reply-To: <5476071B.1060705@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, "rob.herring@linaro.org" <rob.herring@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@oracle.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "kesavan.abhilash@gmail.com" <kesavan.abhilash@gmail.com>, Catalin Marinas <Catalin.Marinas@arm.com>, "k.chander@samsung.com" <k.chander@samsung.com>, "olof@lixom.net" <olof@lixom.net>, "ta.omasab@gmail.com" <ta.omasab@gmail.com>



On 26/11/14 17:00, Sudeep Holla wrote:
> Hi Viresh,
>

[...]

>> diff --git a/Documentation/devicetree/bindings/cpufreq/drivers.txt b/Documentation/devicetree/bindings/cpufreq/drivers.txt
>> new file mode 100644
>> index 0000000..bd14917
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/cpufreq/drivers.txt
>> @@ -0,0 +1,53 @@
>> +Binding to select which cpufreq driver to register
>> +
>> +It is a generic DT binding for selecting which cpufreq-driver to register for
>> +any platform.
>> +
>> +The property  listed below must be defined under node /cpus/cpu@0 node. We don't
>> +support multiple CPUFreq driver currently for different cluster and so this
>> +information isn't required to be present in CPUs of all clusters.
>> +
>> +Required properties:
>> +- None
>> +
>> +Optional properties:
>> +- dvfs-method: CPUFreq driver to probe. For example: "arm-bL-cpufreq-dt",
>> +  "cpufreq-dt", etc
>> +
>
> You should manage this with compatible rather than a new property as
> it's not a real hardware property. IMHO Rob's suggestion[1] should work
> fine.
>
> IIUC, you can have the driver which create this platform device if DT
> has generic compatible unconditionally(e.g "cpufreq-dt" as you have
> chosen above). For all existing DT you can create a blacklist of
> compatibles to match(as it doesn't have the generic compatible) covering
> all the existing platforms using cpufreq-dt driver, there by you can
> even remove the platform device creating from multiple places.
> IMO something like the patch below should work(not tested, also
> late_initcall is used just to demonstrate the idea)
>
> Rob, please correct me if my understanding is wrong.
>
> Regards,
> Sudeep
>
> [1]
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/256191.html
>
> --->8
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index f657c571b18e..19a616e298e0 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -387,6 +387,32 @@ static struct platform_driver dt_cpufreq_platdrv = {
>    };
>    module_platform_driver(dt_cpufreq_platdrv);
>
> +static const struct of_device_id compatible_machine_match[] = {
> +       /* All new machines must have the below compatible to use this
> driver */
> +       { .compatible = "cpufreq-generic-dt" },
> +       /* BLACKLIST of existing users of cpufreq-dt below */
> +       { .compatible = "samsung,exynos5420" },
> +       { .compatible = "samsung,exynos5800" },

Please ignore the above 2 compatible values in this context, I just
chose randomly 2 values but I now realize that there are big-little
platforms and might not use this driver :(

Regards,
Sudeep

