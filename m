From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 12:55:48 -0700
Message-ID: <20100507195548.GN387__4842.86346841163$1273262311$gmane$org@atomide.com>
References: <20100507171218.GA23142@srcf.ucam.org>
	<20100507173549.GF387@atomide.com>
	<20100507175025.GA23952@srcf.ucam.org>
	<20100507180152.GH387@atomide.com>
	<20100507182824.GA25198@srcf.ucam.org>
	<20100507184333.GL387@atomide.com>
	<20100507184621.GA25978@srcf.ucam.org>
	<1273259186.3542.93.camel@c-dwalke-linux.qualcomm.com>
	<20100507192837.GM387@atomide.com>
	<20100507193353.GA27175@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507193353.GA27175@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Len Brown <len.brown@intel.com>, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-doc@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

* Matthew Garrett <mjg@redhat.com> [100507 12:29]:
> On Fri, May 07, 2010 at 12:28:37PM -0700, Tony Lindgren wrote:
> > * Daniel Walker <dwalker@fifo99.com> [100507 12:01]:
> > > On Fri, 2010-05-07 at 19:46 +0100, Matthew Garrett wrote:
> > > > Freezer cgroups would work better, but it doesn't really change the 
> > > > point - if that application has an open network socket, how do you know 
> > > > to resume that application when a packet comes in?
> > 
> > No idea, but that still sounds a better situation to me than
> > trying to deal with that for a suspended system! :)
> 
> Suspend blocks deal with that problem. Nobody has yet demonstrated a 
> workable alternative solution.

Well there are obviously two paths to take, I think both of
them should work. The alternative to suspend blockers is:

- Implement a decent kernel idle function for the hardware and
  use cpuidle to change the c states. The dyntick stuff should
  already work for most hardware.

- Fix the core userspace apps to minimize timers.

- Deal with broken apps whichever way you want in the userspace.

- Optionally, do echo mem > /sys/power/state based on some
  product specific logic in the userspace.

The advantage of this is that no kernel changes are needed,
except for implementing the custom idle function for the
hardware. And this kind of setup has been in use for about
five years.

And, you can keep the system running constantly if you have
hardware that supports good idle modes, then you don't even
need to suspend at all.

The core problems I see with suspend blockers are following,
please correct me if I'm wrong:

- It is caching the value of echo mem > /sys/power/state and
  misusing it for runtime power management as the system still
  keeps running after trying to suspend. Instead, the kernel
  idle function and cpuidle should be used if the kernel keeps
  running.

- They require patching all over the drivers and userspace.

- Once the system is suspended, it does not run. And the apps
  don't behave in a standard way because the system does not
  wake to timer interrupts.

I agree that we need to be able to echo mem > /sys/power/state
in an atomic way. So if there are problems with that, those
issues should be fixed.

Cheers,

Tony
