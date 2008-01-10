From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Thu, 10 Jan 2008 12:04:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801101202470.2727-100000__41872.5872914822$1199984766$gmane$org@iolanthe.rowland.org>
References: <200801101759.10701.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801101759.10701.rjw@sisk.pl>
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

On Thu, 10 Jan 2008, Rafael J. Wysocki wrote:

> > > > > > Also, the kerneldoc for destroy_suspended_device() should contain an 
> > > > > > extra paragraph warning that the routine should never be called except 
> > > > > > within the scope of a system sleep transition.  In practice this means 
> > > > > > it has to be directly or indirectly invoked by a suspend or resume 
> > > > > > method.
> > > > > 
> > > > > Or by a CPU hotplug notifier (that will be the majority of cases, IMO).
> > > > 
> > > > In your patch the call is made in response to a CPU_UP_CANCELED_FROZEN
> > > > notification.  Isn't it true that this notification is issued only as
> > > > part of a system sleep transition?
> > > 
> > > Yes, it is.
> > 
> > So it counts as being indirectly invoked by a resume method.
> 
> Rather, by the resume core.  Technically, it's invoked by
> enable_nonboot_cpus(), which is not a resume method literally.

Okay, then the routine should only be called directly or indirectly 
from a suspend or resume method or from the suspend or resume core.

Alan Stern
