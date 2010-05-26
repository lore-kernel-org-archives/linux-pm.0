From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Opportunistic suspend support.
Date: Thu, 27 May 2010 00:03:58 +0200
Message-ID: <201005270003.58277.rjw__13594.4015616134$1274912737$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005251647530.1634-100000@iolanthe.rowland.org>
	<1274878665.27810.354.camel@twins>
	<20100526132051.GA1834@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100526132051.GA1834@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg KH <gregkh@suse.de>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arve@smtp1.linux-foundation.org, Andi Kleen <ak@linux.intel.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Len Brown <len.brown@intel.com>, James Bottomley <James.Bottomley@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, tytso@mit.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 May 2010, Matthew Garrett wrote:
> On Wed, May 26, 2010 at 02:57:45PM +0200, Peter Zijlstra wrote:
> 
> > I fail to see why. In both cases the woken userspace will contact a
> > central governing task, either the kernel or the userspace suspend
> > manager, and inform it there is work to be done, and please don't
> > suspend now.
> 
> Thinking about this, you're right - we don't have to wait, but that does 
> result in another problem. Imagine we get two wakeup events 
> approximately simultaneously. In the kernel-level universe the kernel 
> knows when both have been handled. In the user-level universe, we may 
> have one task schedule, bump the count, handle the event, drop the count 
> and then we attempt a suspend again because the second event handler 
> hasn't had an opportunity to run yet. We'll then attempt a suspend and 
> immediately bounce back up. That's kind of wasteful, although it'd be 
> somewhat mitigated by checking that right at the top of suspend entry 
> and returning -EAGAIN or similar.

I still think it would cause a loop-alike behavior between the user space
power manager and the kernel PM core to happen, because the power manager
will always have to check the user space counter after a failing suspend
attempt.

Rafael
