From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 0/5] Hibernation: Clean up userland interface
	(rev. 2)
Date: Sun, 9 Sep 2007 22:57:15 +0200
Message-ID: <200709092257.16085.rjw__15999.7744056911$1189405369$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
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
Cc: Johannes Berg <johannes@sipsolutions.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches is intended to eliminate some design problems with=
 the
hibernation userland interface.

It contains the following changes:
* allow the user space utilities to get the size of the image via ioctl
* introduce ioctls to be used instead of SNAPSHOT_PMOPS
* mark the SNAPSHOT_SET_SWAP_FILE ioctl as deprecated
* introduce new ioctl definitions to replace the wrongly defined ones
* move the definitions of hibernation ioctls to a separate header file lo=
cated
=A0 in include/linux/ and export them to the user space
The details are in the changelogs.

Comments welcome.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
