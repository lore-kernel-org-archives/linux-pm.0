From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH 00/11] OPP: Don't create multiple OPP tables for devices
 sharing OPP table
Date: Thu, 13 Sep 2018 12:21:13 +0200
Message-ID: <20180913102113.GA25222@centauri.lan>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <20180912135537.GA9985@centauri.ideon.se>
 <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohpomVR_U9cA2yFLWjQ0pLdjp_d8=s2C7cvbauacha0Uv8xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4.18" <stable@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 13, 2018 at 01:18:34PM +0530, Viresh Kumar wrote:
> On 12 September 2018 at 19:25, Niklas Cassel <niklas.cassel@linaro.org> wrote:
> > On Wed, Sep 12, 2018 at 01:58:39PM +0530, Viresh Kumar wrote:
> >> Hello,
> >>
> >> Niklas Cassle recently reported some regressions with his Qcom cpufreq
> >> driver where he was getting some errors while creating the OPPs tables.
> >>
> >> After looking into it I realized that the OPP core incorrectly creates
> >> multiple OPP tables for the devices even if they are sharing the OPP
> >> table in DT. This happens when the request comes using different CPU
> >> devices. For example, dev_pm_opp_set_supported_hw() getting called using
> >> CPU0 and dev_pm_opp_of_add_table() getting called using CPU1.
> >>
> >> This series redesigns the internals of the OPP core to fix that. The
> >> redesign has simplified the core itself though.
> >>
> >> @Niklas: Can you please confirm that this series fixes the issues you
> >> have reported ? I have already tested it on Hikey960.
> >
> > Hello Viresh,
> >
> > This fixes the OPP error messages that I previously reported.
> >
> > However, I also tested to add a duplicate OPP to the opp-table.
> >
> > Before this series, I got the first two error prints.
> > After this series, I get the first two error prints + the use after free splat.
> 
> This looks to be an old bug. Can you please try this branch:

Hello Viresh,

You confused me here, since you did hide the fix for this old bug in the
middle of your new patch series :)

I think that it would have been more obvious to simply paste the fix/diff
in your reply directly, since that is the most common way to post a
potential fix. Or, if you are really confident in your fix, post a V2
directly.

However, your branch works like a charm, so feel free to add:
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
when sending out your branch as a V2.

Kind regards,
Niklas

> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/qcom-fix
> 
> ?
