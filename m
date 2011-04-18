From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 8/9] OMAP1 / PM: Use generic clock
	manipulation routines for runtime PM
Date: Mon, 18 Apr 2011 17:18:09 +0900
Message-ID: <20110418081809.GA32457__34898.2301111848$1303114852$gmane$org@linux-sh.org>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
	<201104170143.28980.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104170143.28980.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 17, 2011 at 01:43:28AM +0200, Rafael J. Wysocki wrote:
> @@ -75,24 +69,7 @@ static int __init omap1_pm_runtime_init(
>  	if (!cpu_class_is_omap1())
>  		return -ENODEV;
>  
> -	pm = platform_bus_get_pm_ops();
> -	if (!pm) {
> -		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
> -			__func__);
> -		return -ENODEV;
> -	}
> -
> -	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
> -	if (!omap_pm) {
> -		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
> -			__func__);
> -		return -ENOMEM;
> -	}
> -
> -	omap_pm->runtime_suspend = omap1_pm_runtime_suspend;
> -	omap_pm->runtime_resume = omap1_pm_runtime_resume;
> -
> -	platform_bus_set_pm_ops(omap_pm);
> +	pm_runtim_clock_add_notifier(&platform_bus_type, &platform_bus_notifier);
>  
Presumably you meant pm_runtime_clock_add_notifier() here. You seem to
have the same typo in a few other places too.
