From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
 for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 10:16:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906221007140.3081-100000__16915.1921909817$1245680256$gmane$org@iolanthe.rowland.org>
References: <200906211332.46249.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906211332.46249.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, 21 Jun 2009, Rafael J. Wysocki wrote:

> > Seriously, there _are_ places where drivers get bound to device before
> > those devices are registered.  This happens for example in USB when a
> > bunch of related interfaces are present in the same physical device.  
> > When the first interface is registered, its driver binds itself to all
> > the others even though they haven't been registered yet.
> 
> Well, the suspend functions could be protected against that under the
> assumption that no suspend is possible for resume_counter = 0 (then, the "good
> to go" value would be -1).
> 
> Still, the resume functions start from acquring a spinlock, which is not going
> to work if that spinlock is uninitialized.

The initialization needs to be improved.  Most of the code in
pm_runtime_init() should be called from device_pm_init(), and the rest
should be moved into a separate pm_runtime_add() routine to be called
from device_pm_add().

One of the things pm_runtime_add() could do is change the status from 
RPM_UNREGISTERED to RPM_ACTIVE.

Alan Stern
