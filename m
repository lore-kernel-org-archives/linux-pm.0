From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] of: Add of_match_machine helper
Date: Fri, 8 Aug 2014 16:23:26 +0300
Message-ID: <53E4CF4E.6010500@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com> <1407452515-2390-2-git-send-email-ttynkkynen@nvidia.com> <20140808094123.GC5387@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140808094123.GC5387@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 08/08/14 12:41, Thierry Reding wrote:
> 
>> +const struct of_device_id *of_match_machine(const struct of_device_id *matches)
>> +{
>> +	const struct of_device_id *match;
>> +	struct device_node *root;
>> +
>> +	root = of_find_node_by_path("/");
>> +	if (!root)
>> +		return NULL;
>> +
>> +	match = of_match_node(matches, root);
>> +	of_node_put(root);
>> +	return match;
>> +}
>> +EXPORT_SYMBOL(of_match_machine);
> 
> I wonder if of_find_node_by_path("/") is somewhat overkill here. Perhaps
> simply of_node_get(of_allnodes) would be more appropriate here since the
> function is implemented in the core?

of_machine_is_compatible() uses of_find_node_by_path("/") as well, of_allnodes
seems to be only used when during iterating. So I'd prefer to have them
consistent.

-- 
nvpublic
