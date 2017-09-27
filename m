From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] PM / OPP: Move the OPP directory out of power/
Date: Wed, 27 Sep 2017 10:27:05 -0700
Message-ID: <20170927172705.GA12211@ubuntu>
References: <3eaed52523d54bdc7b43b335d5aefda9b4d1b4a8.1506463860.git.viresh.kumar@linaro.org>
 <CAJZ5v0hcg5bYfhUR2cLZo5bB8gL8F3UeD9Wrbp8TLLQU_agx-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hcg5bYfhUR2cLZo5bB8gL8F3UeD9Wrbp8TLLQU_agx-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27-09-17, 19:22, Rafael J. Wysocki wrote:
> On Wed, Sep 27, 2017 at 12:12 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The drivers/base/power/ directory is special and contains code related
> > to power management core like system suspend/resume, hibernation, etc.
> > It was fine to keep the OPP code inside it when we had just one file for
> > it, but it is growing now and already has a directory for itself.
> >
> > Lets move it directly under drivers/ directory, just like cpufreq and
> > cpuidle.
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V1->V2:
> > - Update maintainers and add a Kconfig file in drivers/opp/.
> 
> OK, but I need an ACK from Stephen here.

Sure.

> And while we are at it, you, Stephen and Nishanth Menon are listed as
> maintainers for it and I'm not, but I still apply OPP patches, so
> maybe one of you can set up a git repo for this and send pull requests
> to me instead?

Yeah, I will setup one.

-- 
viresh
