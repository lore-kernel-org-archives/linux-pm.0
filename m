From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ARM: tegra: Add soctherm and thermal zones to
 Tegra124 device tree
Date: Wed, 20 Aug 2014 13:42:27 -0600
Message-ID: <53F4FA23.3000409@wwwdotorg.org>
References: <1407320706-17440-1-git-send-email-mperttunen@nvidia.com> <1407320706-17440-3-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407320706-17440-3-git-send-email-mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 08/06/2014 04:25 AM, Mikko Perttunen wrote:
> This adds the soctherm thermal sensing and management unit to the
> Tegra124 device tree along with the four thermal zones corresponding
> to the four thermal sensors provided by soctherm.

> diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi

> +	thermal-zones {

> +	soctherm: soctherm@0,700e2000 {

>   	cpus {

The sort order of these nodes is wrong; nodes with reg should be sorted 
according to the reg value. Nodes without reg should be sorted 
alpha-numerically. That would place soctherm after sdhci@0,700b0600, and 
thermal-zones before timer.

soctherm isn't a generic node name but sounds more like an identity; 
thermal-sensor sounds like a better node name (but the node label can 
still be soctherm if you want; label names don't show up in the DT ABI).

If these are the only issues, they can probably be fixed manually when 
applying the patches, assuming a Tegra maintainer does it - I wouldn't 
want to burden anyone else with that.
