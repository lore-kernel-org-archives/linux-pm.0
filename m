From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
Date: Wed, 09 Dec 2015 10:15:54 +0100
Message-ID: <3682335.fAt9xNcJFr@wuerfel>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org> <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, ajitpal.singh@st.com, maxime.coquelin@st.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 08 December 2015 14:32:01 Lee Jones wrote:
> @@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops = {
>         .smp_secondary_init     = sti_secondary_init,
>         .smp_boot_secondary     = sti_boot_secondary,
>  };
> +
> +/**
> + * CPUFreq Registration
> + */
> +void init_cpufreq(void)
> +{
> +       platform_device_register_simple("sti-cpufreq", -1, NULL, 0);
> +}
> 

Can you please do this under drivers/cpufreq somewhere?

I really don't want to any more of these in platform code. Requiring a
device to be created just to probe the driver is really silly.

	Arnd
