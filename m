From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 11:17:03 -0700
Message-ID: <20100507181702.GI387__32991.4732407362$1273256321$gmane$org@atomide.com>
References: <20100506171453.GC30928@atomide.com>
	<1273167311.20494.13.camel@c-dwalke-linux.qualcomm.com>
	<20100506183605.GF30928@atomide.com>
	<1273173110.20494.19.camel@c-dwalke-linux.qualcomm.com>
	<20100507020057.GG30928@atomide.com>
	<1273252837.3542.30.camel@c-dwalke-linux.qualcomm.com>
	<20100507173621.GA23604@srcf.ucam.org>
	<1273254043.3542.37.camel@c-dwalke-linux.qualcomm.com>
	<20100507175159.GB23952@srcf.ucam.org>
	<1273255255.3542.43.camel@c-dwalke-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1273255255.3542.43.camel@c-dwalke-linux.qualcomm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@fifo99.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

* Daniel Walker <dwalker@fifo99.com> [100507 10:56]:
> On Fri, 2010-05-07 at 18:51 +0100, Matthew Garrett wrote:
> > On Fri, May 07, 2010 at 10:40:43AM -0700, Daniel Walker wrote:
> > > On Fri, 2010-05-07 at 18:36 +0100, Matthew Garrett wrote:
> > > > If your wakeup latencies are sufficiently low and you have fine-grained 
> > > > enough control over your hardware then suspend in idle is a reasonable 
> > > > thing to do - but if you have a userspace app that's spinning then 
> > > > that doesn't solve the issue.
> > > 
> > > If there's a userspace app spinning then you don't go idle (or that's my
> > > assumption anyway). You mean like repeatedly blocking and unblocking
> > > right?
> > 
> > Right, that's the problem. idle-based suspend works fine if your 
> > applications let the system go idle, but if your applications are 
> > anything other than absolutely perfect in this respect then you consume 
> > significant power even if the device is sitting unused in someone's 
> > pocket.
> 
> True .. I'd wonder how an OMAP based devices deal with that issue, since
> they would have that exact problem. According to what Tony is telling
> us. Actually a bogus userspace can do a lot more than just consume power
> you could hang the system too.

There's nothing being done on omaps specifically, up to the device
user space to deal with that. From the kernel point of view the
omaps just run, and if idle enough, the device starts hitting the
retention and off modes in idle. But the system keeps on running
all the time, no need to suspend really. 

I don't think there's a generic solution to the misbehaving apps.
I know a lot of work has been done over past five years or so
to minimize the timer usage in various apps. But if I installed
some app that keeps the system busy, it would drain the battery.

I guess some apps could be just stopped when the screen blanks
unless somehow certified for the timer usage or something similar..

Regards,

Tony
