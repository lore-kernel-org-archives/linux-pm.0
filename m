From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Fri, 11 Jan 2008 16:56:19 -0800
Message-ID: <20080112005619.GA4665__49684.6684990034$1200099442$gmane$org@suse.de>
References: <200801020032.45529.rjw@sisk.pl>
	<20080111164613.7791bb94.akpm@linux-foundation.org>
	<20080111164904.3ca81602.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080111164904.3ca81602.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, ak@suse.de, linux-acpi@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 11, 2008 at 04:49:04PM -0800, Andrew Morton wrote:
> On Fri, 11 Jan 2008 16:46:13 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > > The first patch in the series introduces such a mechanism.  The remaining three
> > > patches modify the MSR, x86-64 MCE and cpuid drivers in accordance with the
> > > above approach.
> > 
> > These patches are a preresuisite to
> > gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch and its
> > later fixed-up versions.
> > 
> > So what I have now is
> > 
> > revert-gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> > pm-introduce-destroy_suspended_device.patch
> > pm-do-not-destroy-create-devices-while-suspended-in-msrc-rev-2.patch
> > pm-do-not-destroy-create-devices-while-suspended-in-mce_64c.patch
> > pm-do-not-destroy-create-devices-while-suspended-in-cpuidc.patch
> > pm-acquire-device-locks-on-suspend-rev-3.patch
> > pm-acquire-device-locks-on-suspend-rev-3-checkpatch-fixes.patch
> > pm-acquire-device-locks-on-suspend-rev-3-checkpatch-fixes-2.patch
> > 
> > So what needs to happen in Greg's tree is
> > 
> > a) drop the old gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch
> > 
> > b) apply these four patches
> > 
> > c) apply the new pm-acquire-device-locks-on-suspend-rev-3.patch (and its fixups)
> 
> err, no.  pm-introduce-destroy_suspended_device.patch demolishes
> pm-acquire-device-locks-on-suspend-rev-3.patch
> 
> Confused, giving up.

I'm confused too, I have no idea what the proper order of things should
be either.  Anyone want to give me a hint?

thanks,

greg k-h
