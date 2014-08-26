From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v4 3/3] memory: tegra124-emc: Add EMC driver
Date: Tue, 26 Aug 2014 11:17:45 -0600
Message-ID: <53FCC139.6020703@wwwdotorg.org>
References: <1409058728-13347-1-git-send-email-tomeu.vizoso@collabora.com> <1409058728-13347-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409058728-13347-4-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?windows-1252?Q?Terje_Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 08/26/2014 07:12 AM, Tomeu Vizoso wrote:
> Sets the EMC clock rate based on the bandwidth requirements registered by
> memory clients through the PM_QOS_MEMORY_BANDWIDTH class.
>
> Note: this is just an example and not a proper driver for a external memory
> controller. Its only purpose is to illustrate how such a driver would set the
> frequency of the external memory clock based on the bandwidth requirements of
> memory clients.

> diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c

> @@ -112,6 +117,11 @@ static void __init tegra_dt_init(void)
>   	parent = soc_device_to_device(soc_dev);
>
>   	/*
> +	 * HACK: register a platform device to probe the driver
> +	 */
> +	platform_device_register(&tegra_emc);

I don't think this is a hack, except for the bug: That should only 
happen on Tegra124 not on all Tegra SoCs.

Do you intend all 3 patches in this series to be merged? You'd mentioned 
you didn't when asked about this for a previous version. I'm not sure if 
that's changed?

To merge, I'd need Thierry's ack on patch 2, and Thierry's, Peter's, 
Mikko's, and/or Tuomas's on this patch.
