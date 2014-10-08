From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 0/2] allow cpufreq drivers to export flags
Date: Wed, 8 Oct 2014 10:11:15 +0200
Message-ID: <20141008101115.1835927a@free-electrons.com>
References: <CAKohpo=7q9bDcHRxLehNLX6A2idGxUy3jEWvQ+EGbKOQG-MH2g@mail.gmail.com>
	<1412754534-14068-1-git-send-email-mturquette@linaro.org>
	<CAKohpo=9XG7XiLxBf=yo7=QCruawYxqPctC6kqB+syERFCoT6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=9XG7XiLxBf=yo7=QCruawYxqPctC6kqB+syERFCoT6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>Tuukka Tikkanen <tu>
List-Id: linux-pm@vger.kernel.org

Dear Viresh Kumar,

On Wed, 8 Oct 2014 13:24:30 +0530, Viresh Kumar wrote:
> On 8 October 2014 13:18, Mike Turquette <mturquette@linaro.org> wrote:
> > This series is partially in response to a discussion around DT bindings
> > for CPUfreq drivers [0], but it is also needed for on-going work to
> > integrate CPUfreq with the scheduler. In particular a scheduler-driven
> > cpu frequency scaling policy would be well served to know if the
> > underlying CPUfreq driver .target callback might sleep or block for a
> > long time.
> >
> > [0] http://lkml.kernel.org/r/<fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>
> 
> Firstly this link is broken and then the last comment I gave in Thomas's
> thread was that he doesn't need this routine anymore. And so your scheduler
> work is the only user of it.. And so probably we should get this included with
> the scheduler patches only, isn't it? Just including them without any user
> wouldn't benefit..
> 
> Or am I missing something ?

Well, when one has to merge a large number of changes, we often
recommend to merge them piece by piece, which is what Mike is trying to
do here. So we cannot at the same time ask developers to merge things
in small pieces that are easy to review and to merge everything
together because the users of a given API are not there yet.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
