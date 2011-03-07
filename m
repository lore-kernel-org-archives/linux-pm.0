From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [ANNOUNCE] suspend-utils 1.0 has been released
Date: Mon, 7 Mar 2011 22:37:31 +0100
Message-ID: <201103072237.32194.rjw__47062.7191164114$1299534106$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Alon Bar-Lev <alon.barlev@gmail.com>, Luca Tettamanti <kronos.it@gmail.com>, LKML <linux-kernel@vger.kernel.org>, suspend-devel@lists.sourceforge.net, Rodolfo Garcia <kix@kix.es>, Stefan Seyfried <stefan.seyfried@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Yesterday I released version 1.0 of the suspend-utils package including
s2disk/resume, s2ram, s2both and several supporting programs.  It contains
the final official s2ram whitelist and should work with all of the Linux
kernels supporting the user space hibernation interface released to date.

The suspend-utils-1.0 package is available for download from:
http://sourceforge.net/projects/suspend/files/suspend/suspend-1.0/suspend-utils-1.0.tar.bz2/download

For details about the release please refer to the ReleaseNotes file within
the package.  For the full list of changes, please refer to the ChangeLog
file.

The development of s2ram is not going to be continued after this release
and I'm not going to add any new entries to the whitelist.  Consequently,
please do not report new machines that work with s2ram and are not listed.
Still, bugs reported against s2ram will be handled and possibly fixed, so
please report if you find one.  The hibernation-related utilities are still
going to be worked on in the future.

Using the opportunity I'd like to thank all of the people who contributed
to the suspend-utils project and made this release possible, especially
Pavel Machek who inspired the development of s2disk/resume and created the
first version of s2ram, Stefan Seyfried who helped to integrate the
utilities with SUSE and openSUSE power management facilities and added a ton
of machines to the s2ram whitelist, Luca Tettamanti who's been working on
the project's web page, among other things, Alon Bar-Lev who added the
configuration and build scripts, and our last s2ram whitelist maintainer
Rodolfo Garcia.  Your work helped many Linux users to benefit from working
suspend-to-RAM, so thanks a lot!

There's one important administrative change related to the release.  Namely,
the suspend-devel mailing list, that recently has been mostly used for
reporting new machines to be added to the s2ram whitelist, is going to be
closed.  Please send bug reports and other messages related to the
suspend-utils package to linux-pm@lists.linux-foundation.org instead.

Thanks and enjoy,
Rafael
