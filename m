From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH 1/2] PM / sleep: Return RPM_SUSPENDED to keep devices in
 runtime-suspended
Date: Wed, 28 Sep 2016 22:58:57 +0800
Message-ID: <20160928145856.GA2826@sharon>
References: <cover.1475032126.git.yu.c.chen@intel.com>
 <8202fa7e7900749087d3484abbabd9c274a97318.1475032126.git.yu.c.chen@intel.com>
 <CAJZ5v0jFyWOOsjbqKkmFCQDixMRmr+ik+Td6+BqbGxsEF6iCoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFyWOOsjbqKkmFCQDixMRmr+ik+Td6+BqbGxsEF6iCoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,
On Wed, Sep 28, 2016 at 01:46:10PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 28, 2016 at 5:26 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> > Currently if the ->prepare() callback of a device returns a positive number,
> > the PM core will regard that as an indication that it may leave the
> > device runtime-suspended. However it would be more convenient to define
> > this positive number then makes it more maintainable. Consider there might be
> > already some device drivers using different positive values, this patch
> > prints a warning if the positive value is other than RPM_SUSPENDED, and hoping
> > driver developers would adjust their return values to RPM_SUSPENDED, then
> > at last we can modify the code to only enable this feature for values return
> > of RPM_SUSPENDED rather than arbitrary positive value.
> >
> > Suggested-by: Lee Jones <lee.jones@linaro.org>
> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  }
> 
> No.
> 
> (1) RPM_SUSPENDED has a specific meaning to the runtime PM framework,
> so please don't overload it.
> 
> (2) Define a new symbol (e.g. DPM_DIRECT_COMPLETE), but allow drivers
> to return positive numbers different from that.
> 
OK.
> That may be useful if someone wants to do "return a > b" or "return
> count", where "direct complete" is to be used for all values of count
> different from 0.
> 
> The issue here is that "1" in your previous patch looked arbitrary, so
> you're addressing this by defining a symbol to use instead.
> 
OK.
> And BTW, there are places that return "1" already from their
> ->prepare(), so this patch would have generated a bunch of
> false-positives.
> 
OK, will send a new version. Thanks!
> Thanks,
> Rafael
Yu
