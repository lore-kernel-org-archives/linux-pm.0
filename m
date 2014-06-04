From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] idle, thermal, acpi: Remove home grown idle
 implementations
Date: Wed, 4 Jun 2014 15:59:20 -0700
Message-ID: <20140604155920.3fd4e94d@ultegra>
References: <20140604085418.GA11096@twins.programming.kicks-ass.net>
	<20140604015812.140a00d1@jacob-desktop>
	<1509308.hu7EZQqxxC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509308.hu7EZQqxxC@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lenb@kernel.org, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, arjan@linux.intel.com, rui.zhang@intel.com, luto@amacapital.net
List-Id: linux-pm@vger.kernel.org

On Wed, 04 Jun 2014 23:34:51 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Wednesday, June 04, 2014 01:58:12 AM Jacob Pan wrote:
> > On Wed, 4 Jun 2014 10:54:18 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > 
> > > I'm still sitting on this patch. Jacub you were going to make it
> > > play nice with QoS?
> > > 
> > I had a patchset to work through system PM QOS and still maintain
> > the idle injection efficiency. When I saw you did not merge the
> > patch below, I thought you have abandoned it :)
> > 
> > The only issue as per our last discussion is the lack of
> > notification when PM QOS cannot be met. But that is intrinsic to PM
> > QOS itself.
> > 
> > I also consulted with Arjan and looked at directly intercept with
> > intel_idle since both intel_powerclamp and intel_idle are arch
> > specific drivers. But I think that is hard to do at per idle period
> > basis, since we should still allow "natural" idle during the forced
> > idle time.
> > 
> > So, I think we can take a two stepped approach,
> > 1. integrate your patch with a
> > updated version of https://lkml.org/lkml/2013/11/26/534 such that
> > there is no performance/efficiency regression.
> > 2. add notification mechanism to system qos when constraints cannot
> > be met.
> 
> And then there's a question about how the notification would be
> supposed to work.  So I guess we can proceed with 1. and really leave
> 2. for some time in the future ATM.
Sounds good. Let me test/integrate Peter's patch with PM QoS change,
powerclamp and acpipad then come up with a patchset.

Thanks,

Jacob
