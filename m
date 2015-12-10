From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 08/10] cpufreq: st: Provide runtime initialised driver
 for ST's platforms
Date: Thu, 10 Dec 2015 07:37:37 +0530
Message-ID: <20151210020737.GB29459@ubuntu>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
 <1449676697-25432-9-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33678 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbLJCHl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 21:07:41 -0500
Received: by pabur14 with SMTP id ur14so39130578pab.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 18:07:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1449676697-25432-9-git-send-email-lee.jones@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net, devicetree@vger.kernel.org, ajitpal.singh@st.com

On 09-12-15, 15:58, Lee Jones wrote:
> +/*
> + * Only match on "suitable for ALL versions" entries
> + *
> + * This will be used with the BIT() macro.  It sets the
> + * top bit of a 32bit value and is equal to 0x80000000.
> + */
> +#define DEFAULT_VERSION		31

Okay, I misread it in the earlier version. This looks fine.

> +static int sti_cpufreq_set_opp_info(void)
> +{

> +	sprintf(name, "pcode%d", pcode);

I would use snprintf here, in case I haven't counted the string
properly. That should guarantee that we don't access the anything else
than the 'name' array.

> +
> +	ret = dev_pm_opp_set_prop_name(dev, name);
> +	if (ret) {
> +		dev_err(dev, "Failed to set prop name\n");
> +		return ret;
> +	}
> +
> +	version[0] = BIT(major);
> +	version[1] = BIT(minor);
> +	version[2] = BIT(substrate);
> +
> +	ret = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
> +	if (ret) {
> +		dev_err(dev, "Failed to set supported hardware\n");
> +		return ret;
> +	}
> +
> +	dev_err(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
> +		pcode, major, minor, substrate);
> +	dev_err(dev, "version[0]: %x version[1]: %x version[2]: %x\n",
> +		version[0], version[1], version[2]);

These aren't errors.. dev_info ?

> +
> +	return 0;
> +}
> +

> +static int sti_cpufreq_init(void)
> +{
> +	int ret;
> +
> +	ddata.cpu = get_cpu_device(0);
> +	if (!ddata.cpu) {
> +		dev_err(ddata.cpu, "Failed to get device for CPU0\n");
> +		goto skip_voltage_scaling;
> +	}
> +
> +	if (!of_get_property(ddata.cpu->of_node, "operating-points-v2", NULL)) {
> +		dev_err(ddata.cpu, "OPP-v2 not supported\n");

Should be:
                dev_dbg(ddata.cpu, "OPP-v2 not supported, skip voltage scaling\n");

> +		goto skip_voltage_scaling;
> +	}
> +
> +	ret = sti_cpufreq_fetch_syscon_regsiters();
> +	if (ret)
> +		goto skip_voltage_scaling;
> +
> +	ret = sti_cpufreq_set_opp_info();
> +	if (ret)

Shouldn't this be !ret ? You should have jumped on success here.

> +		goto register_cpufreq_dt;
> +
> +skip_voltage_scaling:
> +	dev_err(ddata.cpu, "Not doing voltage scaling\n");

This doesn't look nice as you are adding unnecessary jumps to just
save on a print message. And because of the earlier suggestion you can
do:

	ret = sti_cpufreq_set_opp_info();
	if (ret)
                dev_err(ddata.cpu, "Skip voltage scaling\n");

> +
> +register_cpufreq_dt:
> +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +
> +	return 0;
> +}
> +module_init(sti_cpufreq_init);
> +
> +MODULE_DESCRIPTION("STMicroelectronics CPUFreq/OPP driver");
> +MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh@st.com>");
> +MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1

-- 
viresh
