From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 7 May 2010 11:01:52 -0700
Message-ID: <20100507180152.GH387__20143.963470082$1273255407$gmane$org@atomide.com>
References: <20100506171453.GC30928@atomide.com>
	<20100506172201.GA28578@srcf.ucam.org>
	<20100506173807.GD30928@atomide.com>
	<20100506174331.GA29103@srcf.ucam.org>
	<20100506183335.GE30928@atomide.com>
	<20100506184418.GA30669@srcf.ucam.org>
	<20100507020541.GH30928@atomide.com>
	<20100507171218.GA23142@srcf.ucam.org>
	<20100507173549.GF387@atomide.com>
	<20100507175025.GA23952@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100507175025.GA23952@srcf.ucam.org>
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

* Matthew Garrett <mjg@redhat.com> [100507 10:46]:
> On Fri, May 07, 2010 at 10:35:49AM -0700, Tony Lindgren wrote:
> > * Matthew Garrett <mjg@redhat.com> [100507 10:08]:
> > > The situation is this. You've frozen most of your userspace because you 
> > > don't trust the applications. One of those applications has an open 
> > > network socket, and policy indicates that receiving a network packet 
> > > should generate a wakeup, allow the userspace application to handle the 
> > > packet and then return to sleep. What mechanism do you use to do that?
> > 
> > I think the ideal way of doing this would be to have the system running
> > and hitting some deeper idle states using cpuidle. Then fix the apps
> > so timers don't wake up the system too often. Then everything would
> > just run in a normal way.
> 
> Effective power management in the face of real-world applications is a 
> reasonable usecase.

Sure there's no easy solution to misbehaving apps.

> > For the misbehaving stopped apps, maybe they could be woken
> > to deal with the incoming network data with sysfs_notify?
> 
> How would that work? Have the kernel send a sysfs_notify on every netwrk 
> packet and have a monitor app listen for it and unfreeze the rest of 
> userspace if it's frozen? That sounds expensive.

Yeah maybe there are better ways of dealing with this.

Maybe deferred timers would help some so all the apps could
be allowed to run until some power management policy decides
to suspend the whole device.

Regards,

Tony
