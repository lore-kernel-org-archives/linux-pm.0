From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] cpufreq: pxa: convert to clock API
Date: Wed, 12 Oct 2016 12:02:47 +0530
Message-ID: <20161012063247.GH19385@vireshk-i7>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
 <1476130149-31834-7-git-send-email-robert.jarzmik@free.fr>
 <20161012023601.GC19385@vireshk-i7>
 <87mvia6q8p.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87mvia6q8p.fsf@belgarion.home>
Sender: linux-clk-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12-10-16, 08:22, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 10-10-16, 22:09, Robert Jarzmik wrote:
> >> As the clock settings have been introduced into the clock pxa drivers,
> >> which are now available to change the CPU clock by themselves, remove
> >> the clock handling from this driver, and rely on pxa clock drivers.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
> >>  1 file changed, 39 insertions(+), 152 deletions(-)
> >
> > As you mentioned in the previous patch, why can't you use cpufreq-dt
> > driver now and delete this one ?
> 
> PXA architecture have both legacy platform_data based configurations and new
> devicetree based ones.

I don't see any platform data specific code in this driver. What am I
missing ?

-- 
viresh
