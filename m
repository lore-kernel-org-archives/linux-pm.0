From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
Date: Mon, 29 Apr 2019 10:48:35 +0200
Message-ID: <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan> <20190403195718.GA74723@google.com>
 <87o94tutdz.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87o94tutdz.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Claire Chang <tientzu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sriram R <srirrama-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pradeep Kumar Chitrapu <pradeepc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:NETWORKING DRIVERS (WIRELESS)" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 26, 2019 at 9:18 AM Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:
>
> > + Sriram, Pradeep, Claire
> >
> > On Sun, Mar 03, 2019 at 06:24:33PM +0100, Rafael J. Wysocki wrote:
> >
> > Ooh, exactly 1 month ago!
> >
> >> From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >>
> >> ath10k_mac_vif_chan() always returns an error for the given vif
> >> during system-wide resume which reliably triggers two WARN_ON()s
> >> in ath10k_bss_info_changed() and they are not particularly
> >> useful in that code path, so drop them.
> >>
> >
> > Particularly, when WOWLAN isn't enabled, we get called during resume via
> > ieee80211_reconfig(), where we're not associated and don't have any
> > channel contexts. AFAICT, we shouldn't need to communicate anything in
> > particular to the firmware here, and so failing the 'if' is definitely
> > not worth WARN-ing about.
> >
> > I'd love to see this get applied with:
> >
> > Fixes: cd93b83ad927 ("ath10k: support for multicast rate control")
> > Fixes: f279294e9ee2 ("ath10k: add support for configuring management packet rate")
> >
> > and sent to stable. This has been bugging people since 4.19. Spurious
> > WARN_ON()s can trigger reports to various crash trackers, and on some
> > systems appear as user-visible warnings ("System problem detected").
> >
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >
> > Reviewed-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> > Tested-by: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> I added these now to the commit log, thanks Brian.
>
> Rafael, could you please provide the hardware and firmware versions you
> tested this on? We have so many different firmware branches to support
> that I prefer to have that documented in the commit log. Providing
> ath10k startup messages in dmesg are enough,

There you go:

[    4.695349] ath10k_pci 0000:3a:00.0: enabling device (0000 -> 0002)
[    4.698165] ath10k_pci 0000:3a:00.0: pci irq msi oper_irq_mode 2
irq_mode 0 reset_mode 0
[    4.912240] ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target
0x05030000 chip_id 0x00340aff sub 1a56:1535
[    4.912255] ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0
tracing 0 dfs 0 testmode 0
[    4.912716] ath10k_pci 0000:3a:00.0: firmware ver
WLAN.RM.2.0-00180-QCARMSWPZ-1 api 4 features
wowlan,ignore-otp,no-4addr-pad crc32 75dee6c5
[    4.982563] ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A
crc32 19644295

> I can then add it to the commit log.

Still, I'm quite sure that the WARN_ON()s trigger during system resume
regardless of the hw/fw combination.
