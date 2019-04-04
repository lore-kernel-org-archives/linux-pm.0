From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
Date: Thu, 4 Apr 2019 10:28:29 +0200
Message-ID: <CAJZ5v0h=gcurf7msXkxBCmf86D1C1cMP6uL8iadUjMaNd6FPYA@mail.gmail.com>
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan> <20190403195718.GA74723@google.com>
 <1645947.WPhbVaNX0l@aspire.rjw.lan> <CA+ASDXPoB94o0pbY0TQGS7Dtp2RNz=3goH38gpLtBoJ15i7eoQ@mail.gmail.com>
 <87k1gatnvt.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k1gatnvt.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, ath10k-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Todd Brandt <todd.e.brandt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sriram R <srirrama-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pradeep Kumar Chitrapu <pradeepc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Claire Chang <tientzu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 4, 2019 at 6:08 AM Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:
>
> > On Wed, Apr 3, 2019 at 2:47 PM Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> >> I have been wondering whether or not I need to resend this patch or something ...
> >
> > I think the linux-wireless Patchwork instance is the source of truth
> > -- Kalle and Johannes use it for tracking status, IIUC. So this says
> > your patch is still "New":
> >
> > https://patchwork.kernel.org/patch/10837139/
>
> Yeah, that's right:
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#checking_state_of_patches_from_patchwork
>
> So no need to resend, it's in my queue.
>
> I was travelling and then busy with something else so I haven't had a
> chance to process patches, I'll try to catch up now but I'm sure it will
> take a while as there are so many patches. Sorry for the delay.

No worries. :-)
