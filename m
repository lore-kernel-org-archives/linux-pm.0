From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sat, 5 Jan 2008 15:39:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801051537450.26040-100000__2897.33590693704$1199565678$gmane$org@netrider.rowland.org>
References: <200801052119.48542.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801052119.48542.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 5 Jan 2008, Rafael J. Wysocki wrote:

> > Another thing to watch out for: Just in case somebody ends up calling
> > destroy_suspended_device(dev) from within dev's own resume method, you 
> > should interchange the resume_device() and the list_move_tail() 
> > calls in dpm_resume().
> 
> However, if we unregister them all at once after releasing pm_sleep_rwsem,
> that shouldn't be necessary, right?

It's still necessary, because destroy_suspended_device() still has to
move the device from one list to another.  You don't want it to end up 
on the dpm_locked list.

Alan Stern
