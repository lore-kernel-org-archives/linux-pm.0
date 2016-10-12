From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq driver
 for Broadcom STB SoCs
Date: Wed, 12 Oct 2016 11:08:42 +0530
Message-ID: <20161012053842.GF19385@vireshk-i7>
References: <1475882487-2155-1-git-send-email-mmayer@broadcom.com>
 <1475882487-2155-3-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475882487-2155-3-git-send-email-mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 07-10-16, 16:21, Markus Mayer wrote:
> +static int brcm_avs_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +	struct private_data *priv = policy->driver_data;
> +
> +	iounmap(priv->base);
> +	iounmap(priv->avs_intr_base);
> +
> +	return 0;
> +}

Shouldn't the above be done in the below routine instead ?

> +static int brcm_avs_cpufreq_remove(struct platform_device *pdev)
> +{
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return cpufreq_unregister_driver(&brcm_avs_driver);
> +}

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
