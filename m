From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] PM: Add PM_RESUME_PREPARE and PM_POST_RESUME
	notifiers
Date: Mon, 29 Oct 2007 23:34:12 +0100
Message-ID: <200710292334.12812.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0710291723280.11831-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0710291723280.11831-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 29 October 2007 22:30, Alan Stern wrote:
> Rafael:
> 
> How does this patch look?  Any reason not to have the resume notifiers?  

Yes.

The userland interface already uses PM_HIBERNATION_PREPARE and
PM_POST_HIBERNATION for restore too, so if anything, we should call these
from software_resume() either.

As a rule of thumb, if you're going to change kernel/power/disk.c, have a look
at kernel/power/user.c and see if analogous changes are needed in there.

> After all, drivers need to know when an image is about to be restored 
> just as much as they need to know when one is about to be created.
> 
> Assuming this is okay, to whom should I submit it?

Well, it isn't, but as far as the patch flow is concerned, please post suspend
patches to linux-pm and I'll forward them to Len Brown.  Next, they will go
through the suspend branch of the ACPI tree.

This doesn't apply to patches that change drivers/base/power and should go to
Greg, but I can forward them to him too.

> There will be a couple of follow-up patches, one adding the icebox and one
> converting the USB threads to use the icebox instead of the freezer.  This
> sort of cross-subsystem stuff is difficult to coordinate unless one person
> handles everything.

The overall idea is to collect patches in the suspend branch of the ACPI tree,
unless that is against some higher priority rules.

Greetings,
Rafael
