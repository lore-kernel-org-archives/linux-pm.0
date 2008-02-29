From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Fundamental flaw in system suspend,
	exposed by freezer removal
Date: Fri, 29 Feb 2008 01:01:06 +0100
Message-ID: <200802290101.06650.rjw__16685.0150716074$1204243579$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0802281741030.2180-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802281741030.2180-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 28 of February 2008, Alan Stern wrote:
> Rafael:

Hi,

> Here's my patch.  It doesn't include the timers for deadlock debugging, 
> but it does include all the other stuff we've been talking about.  My 
> base probably isn't quite in sync with yours, so this may not apply 
> cleanly on your system.  But the divergences should be small.

No big deal.  In fact we're working with Alex on a patch that modifies main.c
too, so I'll have to resolve merging conflicts anyway. ;-)

> Incidentally, there seemed to be a bug in your dpm_suspend() -- the 
> dpm_list_mtx needs to be reacquired before the error checking.

Oh, yes.  Will you please send a fix when
http://marc.info/?l=linux-acpi&m=120389632114090&w=4 is merged?

> This patch fixes that.  It also removes pm_sleep_rwsem, which isn't used 
> any more.

Yeah.  I left pm_sleep_rwsem, because I wasn't sure it would be necessary
in the future.

> We should think about device_pm_schedule_removal().  It won't work
> right if a suspend method calls it for the device being suspended, 
> because the device gets moved to the dpm_off list after the method 
> runs.

I think we should remove device_pm_schedule_removal() early in the 2.6.26
cycle.

I'll review the patch more thoroughly tomorrow, since I have some new material
for the regressions list I need to take care of.

Thanks,
Rafael
