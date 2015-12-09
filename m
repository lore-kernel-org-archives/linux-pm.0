From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
Date: Wed, 9 Dec 2015 08:09:46 +0530
Message-ID: <20151209023946.GU3692@ubuntu>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com
List-Id: linux-pm@vger.kernel.org

On 08-12-15, 14:32, Lee Jones wrote:
> +/**
> + * SMP Operations
> + */

Why do you need a documentation style comment here?

>  static void write_pen_release(int val)
>  {
>  	pen_release = val;
> @@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops = {
>  	.smp_secondary_init	= sti_secondary_init,
>  	.smp_boot_secondary	= sti_boot_secondary,
>  };
> +
> +/**
> + * CPUFreq Registration
> + */

Here too.

> +void init_cpufreq(void)
> +{
> +	platform_device_register_simple("sti-cpufreq", -1, NULL, 0);
> +}

I don't think you need this, as you can do all the stuff you want from
the module_init() function in the driver. You just have to make sure
that your driver is only compilable and workable on the right STi platform.

-- 
viresh
