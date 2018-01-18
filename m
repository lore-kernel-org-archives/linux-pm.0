From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/7] PM /Domain/OPP: Add support to get performance state from DT
Date: Thu, 18 Jan 2018 20:24:58 +0100
Message-ID: <1708603.ZsSVZozH3j@aspire.rjw.lan>
References: <cover.1513926033.git.viresh.kumar@linaro.org> <20180118063404.GD3012@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118063404.GD3012@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, January 18, 2018 7:34:04 AM CET Viresh Kumar wrote:
> On 22-12-17, 12:56, Viresh Kumar wrote:
> > Hi,
> > 
> > Now that the DT bindings [1] are already Reviewed/Acked by respective
> > maintainers, here is the code to start using them.
> > 
> > The first two patches provide helpers in the OPP core, [3-5]/7 update
> > the PM domain core to start supporting domain OPP tables, etc, 6/7
> > updates the OPP core to use the new callback provided by the PM domains
> > to get performance state and the last one removes the unused helpers
> > now.
> > 
> > This is tested on Hikey620 and works just fine.
> 
> Ping !

Well, whom are you pinging exactly and why?

Thanks,
Rafael
