From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [REPOST PATCH v4 1/2] PM / QoS: Add PM_QOS_MEMORY_BANDWIDTH class
Date: Fri, 26 Sep 2014 01:51:14 +0200
Message-ID: <2373913.b8GhYem2Rt@vostro.rjw.lan>
References: <1409759373-22696-1-git-send-email-tomeu.vizoso@collabora.com> <1960419.9oqpSxvdev@vostro.rjw.lan> <CAAObsKC0PcfBTJv8zZYUiys4NxvS=JMd3jjedUam5oZ4tNLwhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAAObsKC0PcfBTJv8zZYUiys4NxvS=JMd3jjedUam5oZ4tNLwhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 24, 2014 03:31:55 PM Tomeu Vizoso wrote:
> On 24 September 2014 15:32, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> > On Wednesday, September 24, 2014 10:42:13 AM Tomeu Vizoso wrote:
> >> On 14 September 2014 19:06, Rafael J. Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org> wrote:
> >> > On Friday, September 12, 2014 11:11:25 AM Tomeu Vizoso wrote:
> >> >> On 3 September 2014 17:49, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org> wrote:
> >> >> > Also adds a class type PM_QOS_SUM that aggregates the values by summing them.
> >> >> >
> >> >> > It can be used by memory controllers to calculate the optimum clock frequency
> >> >> > based on the bandwidth needs of the different memory clients.
> >> >> >
> >> >> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> >> >> > Acked-by: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
> >> >>
> >> >> Hi Rafael,
> >> >>
> >> >> will you take this one for 3.18?
> >> >
> >> > Quite likely, but I'm traveling now, so I'll do that after I'm back home
> >> > in a few days.  I'll write to you if there are any problems.
> >>
> >> Don't want to be annoying, but thought I might ping you just in case
> >> this fell through the cracks.
> >
> > No, it didn't.
> >
> > I'm wondering about patch [2/2], though.  I'm assuming that you'll push you
> > later through the Tegra DRM driver, right?
> 
> Yes, that was Stephen's suggestion:
> 
> https://lkml.org/lkml/2014/8/25/439

OK, patch [1/2] queued up for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
