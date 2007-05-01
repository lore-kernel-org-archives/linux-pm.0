From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Wed, 2 May 2007 00:02:54 +0200
Message-ID: <200705020002.55331.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz>
	<1177945191.5102.93.camel@johannes.berg>
	<200705011605.16993.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705011605.16993.rjw@sisk.pl>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 May 2007 16:05, Rafael J. Wysocki wrote:
> On Monday, 30 April 2007 16:59, Johannes Berg wrote:
> > On Mon, 2007-04-30 at 16:51 +0200, Rafael J. Wysocki wrote:
> > 
> > > > That comment doesn't seem right. This is in ->enter so afaict the image
> > > > hasn't been loaded yet at this point. I don't know if you just moved
> > > > code but if you did then I don't think it was correct before.
> > > 
> > > It was in your patch, so I kept it, but I don't think it's correct too.
> > 
> > If it was in my patch then it must be there in the original code, iirc I
> > just shuffled it a bit :)
> > 
> > > Moreover, it seems that acpi_save_state_mem() and acpi_restore_state_mem() are
> > > only needed by s2ram, so we can safely remove them from the hibernation code
> > > path.  Pavel, is that correct?
> > 
> > This I don't know. They seemed to be done on hibernate too.
> 
> The previous version of the patch was missing the changes in suspend.h.
> 
> Apart from this I've cleaned up some changes in disk.c and main.c to make
> the sysfs interface work again and dropped some ACPI code that I think was
> not necessary.
> 
> Patch appended (tested on x86_64, but not extensively), comments welcome. :-)

Well, having a look on the ACPI spec I'm thinking that what we're trying to do
with this patch is actually wrong.

Instead, we should rip off all of the invocations of pm_ops->whatever() from
the hibernation code paths (with the below exceptions) and *if* the platform
method is to be used, call pm_ops to make the system go down, in the following
way:
1) call pm_ops->prepare(PM_SUSPEND_DISK)
2) suspend devices (ie. call device_suspend() etc.)
3) call pm_ops->enter(PM_SUSPEND_DISK)
and if that *fails* (ie. pm_ops->enter() returns):
4) call pm_ops->finish(PM_SUSPEND_DISK)
5) halt the system

Formally, after restoring the image, *if* the platform method was used (ie. the
above was executed as the last hibernation step), we should call
pm_ops->finish(PM_SUSPEND_DISK) before resuming devices, but
since we get the control from the "old kernel" rather than from the BIOS,
this doesn't seem to be the right thing to do.

I'll try to create a patch along these lines and see if it breaks anything on
my boxes.

Greetings,
Rafael
