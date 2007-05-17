From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] swsusp: Fix hibernation/restore code
	ordering
Date: Fri, 18 May 2007 00:19:34 +0200
Message-ID: <200705180019.35548.rjw__18275.8233546794$1179440730$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi,

In the face of this change:

http://marc.info/?l=linux-acpi&m=117938245931603&w=2

I think we should also modify the code ordering in swsusp so that
hibernation_ops->prepare() is executed after device_suspend().

However, for this purpose it seems reasonable to eliminate the code duplication
between kernel/power/disk.c and kernel/power/user.c first.  By eliminating it
we can reduce the size of user.c quite substantially and remove the
maintenance difficulty with making essentially the same changes in two
different places.

Moreover, we should also remove the calls to "platform" functions from the
restore code path, since it doesn't carry out any power transition of the
system, but we generally need to disable the GPEs before the restore if the
'platform' hibernation mode has been used.  To do this, we can introduce
two new hibernation_ops to be used in the restore code.

Comments welcome.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
