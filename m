From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "cpuidle: Replace ktime_get() with local_clock()"
Date: Thu, 20 Apr 2017 15:49:22 +0200
Message-ID: <20170420134922.kultontleite34sg@hirez.programming.kicks-ass.net>
References: <20170420124447.13716-1-ville.syrjala@linux.intel.com>
 <20170420130813.h7dycr5cptbrvdkz@hirez.programming.kicks-ass.net>
 <20170420134345.GD30290@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170420134345.GD30290@intel.com>
Sender: stable-owner@vger.kernel.org
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 20, 2017 at 04:43:45PM +0300, Ville Syrjälä wrote:
> On Thu, Apr 20, 2017 at 03:08:13PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 20, 2017 at 03:44:47PM +0300, ville.syrjala@linux.intel.com wrote:
> > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > 
> > > This reverts commit e93e59ce5b85e6c2b444f09fd1f707274ec066dc.
> > > 
> > > The TSC stops in deeper C states, 
> > 
> > On some old hardware (Core2 era and before) only. You've forgotten to
> > mention what hardware you've observed problems with.
> 
> Yeah, Core2 is what I used when I finally decided to bisect this. I've
> been plagued by the bogus powertop numbers on many machines, most
> likely all of them were of some older vintage.

> Tested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

OK, thanks. I'm currently chasing some other Core2 issue that is
somewhat related. See:

  http://lkml.kernel.org/r/20170413132349.thxkwptdymsfsyxb@hirez.programming.kicks-ass.net

Once I have that sorted I'll post both patches.
