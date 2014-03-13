From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [RFC] cpufreq-cpu0: allow OPP table supplied by platform
Date: Thu, 13 Mar 2014 19:44:24 +0800
Message-ID: <20140313194424.122ec572@xhacker>
References: <20140313184859.7d6f6512@xhacker>
	<CAKohpokLv0m+Cky7nCUOgP-djTMrA6jyka_EZ07+_exCAexXXg@mail.gmail.com>
	<CAKohpoke1i8xmKProgF+ki7Q=Q+YxbPnewdtbyPqu7857DLLWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpoke1i8xmKProgF+ki7Q=Q+YxbPnewdtbyPqu7857DLLWA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Fixing lakml :)

sorry

On Thu, 13 Mar 2014 03:56:46 -0700
Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Fixing Rafael's id.
> 
> On 13 March 2014 16:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 13 March 2014 16:18, Jisheng Zhang <jszhang@marvell.com> wrote:
> >> Hi all,
> >>
> >> cpufreq-cpu0 is suitable for Marvell Berlin SoC. But there's one issue
> >> to address. The opp is different between chips even on the same step
> >> SoC, BG2Q for example. we can calculate the OPP table from the value of
> >> one OTP register. We have two solutions:
> >>
> >> 1. bootloader reads OTP register and calculate the OPP table then change
> >> dtb danamically
> >>
> >> 2. supply one driver in mach-berlin to initialize the OPP table; and
> >> modify cpufreq-cpu0 to allow platform supply OPP table, fall back to
> >> of_init_opp_table() if there's no OPP table.
> >>
> >> Which solution is better?
> >
> > I think we can go ahead with second option here. We can just check if opp
> > tables are already initialized or not. In case they are, don't probe from
> > dt..
> >
> > But lets see with others have to say here..
> >
> > --
> > viresh

