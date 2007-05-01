From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Hibernation and suspend patchset
Date: Tue, 1 May 2007 15:58:10 +0200
Message-ID: <200705011558.11170.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

I've put together a quilt patchset that contains some hibernation and suspend
patches from Johannes, Pekka, me and some other people that either have
already been merged with the mainline, but are not present in 2.6.21, or are
included in the -mm tree, or have been sent for a review to this list.

The patches are available at:

http://www.sisk.pl/kernel/hibernation_and_suspend/

where the '2.6.21' directory contains the patchset against the 2.6.21 kernel,
and will contain daily snapshots of the patchset.  Later on I'll add analogous
directories for subsequent -rc and 'vanilla' kernels.

The most recent patchset agains the latest 'vanilla' or -rc kernel (whichever
is more recent) will always be available at

http://www.sisk.pl/kernel/hibernation_and_suspend/current/patches/

or, as a tarball, at:

http://www.sisk.pl/kernel/hibernation_and_suspend/current_snapshot.tgz

The present patchset against 2.6.21, tested a bit on x86_64, contains some
'glue' patches that I have added to be able to apply the other patches cleany
on top of 2.6.21.  When 2.6.21-rc1 is out, I'll rediff the entire patchset
against it and then, hopefully, no such 'glue' patches will be necessary.

I'm going to track and include in the patchset all patches that affect:
- any files under kernel/power
- any files under Documentation/power
- include/linux/freezer.h
- include/linux/pm.h
- include/linux/suspend.h
- kernel/freezer.c
and some architecture-dependent files related to hibernation/suspend (patches
that don't affect these files may be included too, if they are related to
hibernation/suspend) and that have been posted for a review either to this list
or to the LKML and have not received negative comments.

If you know of a patch that in your opinion should be included but currently is
not, please let me know.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
