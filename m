From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [REPOST PATCH v4 1/2] PM / QoS: Add PM_QOS_MEMORY_BANDWIDTH class
Date: Wed, 24 Sep 2014 15:32:56 +0200
Message-ID: <1960419.9oqpSxvdev@vostro.rjw.lan>
References: <1409759373-22696-1-git-send-email-tomeu.vizoso@collabora.com> <3009588.qOkltIoajF@vostro.rjw.lan> <CAAObsKD1R_s2JkUgS+W+HBZe2hBTs=Co+d6o63YkmDMHXJCf=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKD1R_s2JkUgS+W+HBZe2hBTs=Co+d6o63YkmDMHXJCf=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Terje =?ISO-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, linux-pm@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Mikko Perttunen <mperttunen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, September 24, 2014 10:42:13 AM Tomeu Vizoso wrote:
> On 14 September 2014 19:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, September 12, 2014 11:11:25 AM Tomeu Vizoso wrote:
> >> On 3 September 2014 17:49, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> >> > Also adds a class type PM_QOS_SUM that aggregates the values by summing them.
> >> >
> >> > It can be used by memory controllers to calculate the optimum clock frequency
> >> > based on the bandwidth needs of the different memory clients.
> >> >
> >> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >> > Acked-by: Pavel Machek <pavel@ucw.cz>
> >>
> >> Hi Rafael,
> >>
> >> will you take this one for 3.18?
> >
> > Quite likely, but I'm traveling now, so I'll do that after I'm back home
> > in a few days.  I'll write to you if there are any problems.
> 
> Don't want to be annoying, but thought I might ping you just in case
> this fell through the cracks.

No, it didn't.

I'm wondering about patch [2/2], though.  I'm assuming that you'll push you
later through the Tegra DRM driver, right?

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
