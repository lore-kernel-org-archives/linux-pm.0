From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Fri, 18 Apr 2008 22:14:13 +0200
Message-ID: <200804182214.14376.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0804181116590.6252-100000@iolanthe.rowland.org>
	<200804182047.40724.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200804182047.40724.rjw@sisk.pl>
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
To: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>
Cc: linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 18 of April 2008, Rafael J. Wysocki wrote:
> On Friday, 18 of April 2008, Alan Stern wrote:
> > On Thu, 17 Apr 2008, Andrew Morton wrote:
> > 
> > > But this:
> > > 
> > > <cold boot>
> > > <suspend-to-ram>
> > > <resume-from-ram>
> > > <suspend-to-disk>
> > > <resume-from-disk>
> > > 
> > > hangs at the end of resume-from-disk.
> > > 
> > > 
> > > During the suspend-to-disk I saw:
> > > 
> > > ipw2200: Radio Frequency Kill Switch is On:
> > > Kill switch must be turned off for wireless networking to work.
> > > PM: Device usb1 failed to (unknown PM event): error -113
> > > PM: Device usb2 failed to (unknown PM event): error -113
> > > PM: Device usb3 failed to (unknown PM event): error -113
> > > PM: Device usb4 failed to (unknown PM event): error -113
> > 
> > These -113 errors can be ignored.  They are fallout from the recent 
> > conversion of the driver core's suspend/resume API.  Matching changes 
> > have not yet been added to the USB core.
> > 
> > The "(unknown PM event)" strings look like a bug, though.
> 
> Yes, it does.
> 
> I'm trying to figure this out.

This particular problem should be fixed by the appended patch.

Andrew, can you please check if you see "recover" instead of
"(unknown PM event)" in those messages with the patch applied?

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>

If PMSG_RECOVER is passed to it, the pm_verb() function will return
a pointer to "(unknown PM event)", which is wrong.  Fix that.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -259,6 +259,8 @@ static char *pm_verb(int event)
 		return "thaw";
 	case PM_EVENT_RESTORE:
 		return "restore";
+	case PM_EVENT_RECOVER:
+		return "recover";
 	default:
 		return "(unknown PM event)";
 	}
