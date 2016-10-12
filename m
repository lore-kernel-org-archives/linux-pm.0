From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/6] cpufreq: pxa: convert to clock API
Date: Wed, 12 Oct 2016 14:10:44 +0530
Message-ID: <20161012084044.GK19385@vireshk-i7>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
 <1476130149-31834-7-git-send-email-robert.jarzmik@free.fr>
 <20161012023601.GC19385@vireshk-i7>
 <87mvia6q8p.fsf@belgarion.home>
 <20161012063247.GH19385@vireshk-i7>
 <87insy6kdq.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87insy6kdq.fsf@belgarion.home>
Sender: linux-clk-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12-10-16, 10:29, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 12-10-16, 08:22, Robert Jarzmik wrote:
> >> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >> 
> >> > On 10-10-16, 22:09, Robert Jarzmik wrote:
> >> >> As the clock settings have been introduced into the clock pxa drivers,
> >> >> which are now available to change the CPU clock by themselves, remove
> >> >> the clock handling from this driver, and rely on pxa clock drivers.
> >> >> 
> >> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> >> ---
> >> >>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
> >> >>  1 file changed, 39 insertions(+), 152 deletions(-)
> >> >
> >> > As you mentioned in the previous patch, why can't you use cpufreq-dt
> >> > driver now and delete this one ?
> >> 
> >> PXA architecture have both legacy platform_data based configurations and new
> >> devicetree based ones.
> >
> > I don't see any platform data specific code in this driver. What am I
> > missing ?
> 
> In a legacy platform, ie. without devicetree, we have CONFIG_OF=n.
> How would cpufreq-dt be usable in this case ?
> 
> You can see such a platform in arch/arm/configs/mainstone_defconfig and
> arch/arm/mach-pxa/mainstone.c as an example.

Okay, so its not about platform_data as you said earlier. Rather it is
about the CONFIG_OF option.

In that case, what about making this driver depends_on !CONFIG_OF ? So
that the DT users don't use it anymore.

-- 
viresh
