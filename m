From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
Date: Wed, 03 Apr 2019 23:44:55 +0200
Message-ID: <1645947.WPhbVaNX0l@aspire.rjw.lan>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan> <20190403195718.GA74723@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190403195718.GA74723-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sriram R <srirrama-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pradeep Kumar Chitrapu <pradeepc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Claire Chang <tientzu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 3, 2019 9:57:20 PM CEST Brian Norris wrote:
> + Sriram, Pradeep, Claire
> 
> On Sun, Mar 03, 2019 at 06:24:33PM +0100, Rafael J. Wysocki wrote:
> 
> Ooh, exactly 1 month ago!
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > ath10k_mac_vif_chan() always returns an error for the given vif
> > during system-wide resume which reliably triggers two WARN_ON()s
> > in ath10k_bss_info_changed() and they are not particularly
> > useful in that code path, so drop them.
> > 
> 
> Particularly, when WOWLAN isn't enabled, we get called during resume via
> ieee80211_reconfig(), where we're not associated and don't have any
> channel contexts. AFAICT, we shouldn't need to communicate anything in
> particular to the firmware here, and so failing the 'if' is definitely
> not worth WARN-ing about.
> 
> I'd love to see this get applied with:
> 
> Fixes: cd93b83ad927 ("ath10k: support for multicast rate control")
> Fixes: f279294e9ee2 ("ath10k: add support for configuring management packet rate")
> 
> and sent to stable. This has been bugging people since 4.19. Spurious
> WARN_ON()s can trigger reports to various crash trackers, and on some
> systems appear as user-visible warnings ("System problem detected").
> 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> 
> Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Thanks Brian, appreciated!

I have been wondering whether or not I need to resend this patch or something ...

> > ---
> >  drivers/net/wireless/ath/ath10k/mac.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Index: linux-pm/drivers/net/wireless/ath/ath10k/mac.c
> > ===================================================================
> > --- linux-pm.orig/drivers/net/wireless/ath/ath10k/mac.c
> > +++ linux-pm/drivers/net/wireless/ath/ath10k/mac.c
> > @@ -5705,7 +5705,7 @@ static void ath10k_bss_info_changed(stru
> >  	}
> >  
> >  	if (changed & BSS_CHANGED_MCAST_RATE &&
> > -	    !WARN_ON(ath10k_mac_vif_chan(arvif->vif, &def))) {
> > +	    !ath10k_mac_vif_chan(arvif->vif, &def)) {
> >  		band = def.chan->band;
> >  		rateidx = vif->bss_conf.mcast_rate[band] - 1;
> >  
> > @@ -5743,7 +5743,7 @@ static void ath10k_bss_info_changed(stru
> >  	}
> >  
> >  	if (changed & BSS_CHANGED_BASIC_RATES) {
> > -		if (WARN_ON(ath10k_mac_vif_chan(vif, &def))) {
> > +		if (ath10k_mac_vif_chan(vif, &def)) {
> >  			mutex_unlock(&ar->conf_mutex);
> >  			return;
> >  		}
> > 
> 
