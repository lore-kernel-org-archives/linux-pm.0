From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: instantiate cpufreq-cpu0 as a platform_driver
Date: Mon, 28 Jan 2013 09:42:29 +0530
Message-ID: <CAOh2x=kCKbxX6ThzEty0F-MxxhsRMhh8++Nc7BqBaXNfaozoJw@mail.gmail.com>
References: <1359208550-16402-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1359208550-16402-1-git-send-email-shawn.guo@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, AnilKumar Ch <anilkumar@ti.com>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Andrew Lunn <andrew@lunn.ch>
List-Id: linux-pm@vger.kernel.org

On Sat, Jan 26, 2013 at 7:25 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> As multiplatform build is being adopted by more and more ARM platforms,
> initcall function should be used very carefully.  For example, when
> GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> will be called on all the platforms to initialize cpufreq-cpu0 driver.
>
> To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> driver to have it instantiated as a platform_driver.  Then it will only
> run on platforms that create the platform_device "cpufreq-cpu0".
>
> Along with the change, it also changes cpu_dev to be &pdev->dev,
> so that managed functions can start working, and module build gets
> supported too.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Rafael,
>
> The patch depends patch "power: export opp cpufreq functions".
> https://patchwork.kernel.org/patch/1847261/
>
> AnilKumar,
>
> Unfortunately, the change will require some platform level adoption
> to have cpufreq-cpu0 driver continue working for am33xx.  But it should
> be as simple as something like below.
>
>         struct platform_device_info devinfo = { .name = "cpufreq-cpu0", };
>         platform_device_register_full(&devinfo);

Something similar was being discussed with Andrew (cc'd) on his patch
for kikwood cpufreq driver.

We shouldn't encourage addition of above as we are moving towards DT.
So, i would except an compatible array too in your patch and then driver
can be probed based on compatible string being present in cpu node.

What do you say?

--
viresh
