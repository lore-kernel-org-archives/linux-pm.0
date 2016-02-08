From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] cpufreq: governor: Simplify cpufreq_governor_limits()
Date: Mon, 08 Feb 2016 01:59:23 +0100
Message-ID: <10187078.AMqBgvu9OI@vostro.rjw.lan>
References: <3705929.bslqXH980s@vostro.rjw.lan> <1465939.LaiBibfCQO@vostro.rjw.lan> <20160207154024.GF3808@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160207154024.GF3808@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, February 07, 2016 09:10:24 PM Viresh Kumar wrote:
> On 07-02-16, 16:23, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Use the observation that cpufreq_governor_limits() doesn't have to
> > get to the policy object it wants to manipulate by walking the
> > reference chain cdbs->policy_dbs->policy, as the final pointer is
> > actually equal to its argument, and make it access the policy
> > object directy via its argument.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c |   17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> Why the hell did we write it that way earlier ? :)

Honestly, I have no idea.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
