From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] opp: add dev_pm_opp_is_turbo() helper
Date: Wed, 29 Jul 2015 16:26:22 +0530
Message-ID: <20150729105622.GA5100@linux>
References: <cover.1438081962.git.viresh.kumar@linaro.org>
 <e7e8c272f85df846466e9b57d7c9eef74109c081.1438081962.git.viresh.kumar@linaro.org>
 <20150728142713.GB17745@amd>
 <20150729102435.GB9584@linux>
 <20150729105347.GA23865@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150729105347.GA23865@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Tomasz Figa <tomasz.figa@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, Thomas Abraham <thomas.ab@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29-07-15, 12:53, Pavel Machek wrote:
> So any combination of normal OPPs can be sustained for arbitrary time
> within the temperature range?

Maybe not. That's why we user thermal framework to sense such
situations and react accordingly.

> And as soon as any turbo OPP is enabled, we produce more heat than
> TDP?

But yeah, this will cross all limits. Shall generate more heat or may
consume lots of power for very small benefit in performance. And so
very short duration bursts of this are used by very few platforms.

-- 
viresh
