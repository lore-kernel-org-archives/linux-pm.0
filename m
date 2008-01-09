From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Wed, 9 Jan 2008 16:01:48 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801091543300.2856-100000__39497.3808005036$1199912677$gmane$org@iolanthe.rowland.org>
References: <200801080125.38080.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801080125.38080.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Jan 2008, Rafael J. Wysocki wrote:

> Appended is what I managed to put together today.
> 
> It probably still has some problems, but I'm not seeing them right now (too
> tired).  At least, it doesn't break my system. ;-)
> 
> Please review.

Okay, this seems to be better.  I like the way the complicated tests 
are all localized in power/main.c.

In dpm_resume() you shouldn't need to use dpm_list_mtx at all, because
the list_move_tail() comes before the resume_device().  It's the same
as in dpm_power_up().

The same is true for dpm_suspend().  Once all the device have been 
locked, there shouldn't be any other tasks accessing the dpm lists.  
Hence there should be no need to protect the list.

Which reminds me, the kerneldoc for device_pm_schedule_removal() is 
inaccurate.  The routine always just moves the device to dpm_destroy 
list for later processing.

Also, the kerneldoc for destroy_suspended_device() should contain an 
extra paragraph warning that the routine should never be called except 
within the scope of a system sleep transition.  In practice this means 
it has to be directly or indirectly invoked by a suspend or resume 
method.

It looks good.

Alan Stern
