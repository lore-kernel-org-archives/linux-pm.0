From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/5] Hibernation: Clean up userland interface
Date: Sun, 2 Sep 2007 23:15:59 +0200
Message-ID: <200709022315.59652.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches is intended to eliminate some design problems with the
hibernation userland interface.

It contains the following changes:
* allow the user space utilities to get the size of the image via ioctl
* introduce ioctls to be used instead of SNAPSHOT_PMOPS
* introduce new ioctl definitions to replace the ones that depend on (void *)
* mark the SNAPSHOT_SET_SWAP_FILE ioctl as deprecated
* move the definitions of hibernation ioctls to a separate header file located
  in include/linux/suspend.h
The details are in the changelogs.

Comments welcome.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
