From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system
 resume
Date: Mon, 29 Apr 2019 14:26:55 +0000 (UTC)
Message-ID: <20190429142655.81B08608D4@smtp.codeaurora.org>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2884043.Jv1Mn93hE8-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:

> ath10k_mac_vif_chan() always returns an error for the given vif
> during system-wide resume which reliably triggers two WARN_ON()s
> in ath10k_bss_info_changed() and they are not particularly
> useful in that code path, so drop them.
> 
> Tested: QCA6174 hw3.2 PCI with WLAN.RM.2.0-00180-QCARMSWPZ-1
> Tested: QCA6174 hw3.2 SDIO with WLAN.RMH.4.4.1-00007-QCARMSWP-1
> 
> Fixes: cd93b83ad927 ("ath10k: support for multicast rate control")
> Fixes: f279294e9ee2 ("ath10k: add support for configuring management packet rate")
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Claire Chang <tientzu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Patch applied to ath-current branch of ath.git, thanks.

9e80ad37f678 ath10k: Drop WARN_ON()s that always trigger during system resume

-- 
https://patchwork.kernel.org/patch/10837139/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
