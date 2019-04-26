From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
Date: Fri, 26 Apr 2019 10:18:16 +0300
Message-ID: <87o94tutdz.fsf@kamboji.qca.qualcomm.com>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
        <20190403195718.GA74723@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20190403195718.GA74723-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> (Brian Norris's message of
        "Wed, 3 Apr 2019 12:57:20 -0700")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Claire Chang <tientzu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sriram R <srirrama-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pradeep Kumar Chitrapu <pradeepc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:

> + Sriram, Pradeep, Claire
>
> On Sun, Mar 03, 2019 at 06:24:33PM +0100, Rafael J. Wysocki wrote:
>
> Ooh, exactly 1 month ago!
>
>> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> 
>> ath10k_mac_vif_chan() always returns an error for the given vif
>> during system-wide resume which reliably triggers two WARN_ON()s
>> in ath10k_bss_info_changed() and they are not particularly
>> useful in that code path, so drop them.
>> 
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
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

I added these now to the commit log, thanks Brian.

Rafael, could you please provide the hardware and firmware versions you
tested this on? We have so many different firmware branches to support
that I prefer to have that documented in the commit log. Providing
ath10k startup messages in dmesg are enough, I can then add it to the
commit log.

-- 
Kalle Valo
