From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 26 May 2014 13:47:44 +0200
Message-ID: <9956935.0oj56vcaUh@vostro.rjw.lan>
References: <20140521073457.GD31687@pengutronix.de> <9956925.Qsz2bH3rDg@vostro.rjw.lan> <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Mike Turquette <mturquette@linaro.org>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, May 26, 2014 04:37:13 PM Viresh Kumar wrote:
> On 26 May 2014 16:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > I agree as far as the 64-bit thing goes, but is switching to Hz really
> > necessary?
> 
> Don't really know that.. It seems that there will always be problems with
> close enough frequencies whenever rounding is done.

Well, rounding errors are a problem, but question is if that is enough of
a problem to justify expanding the storage size twice.  Also, that'd be
a performance hit on 32-bit systems.

> More can be elaborated by Soren.

OK

Rafael

