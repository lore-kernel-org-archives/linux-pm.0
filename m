From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/5] Hibernation: Clean up userland interface
	(rev. 2)
Date: Fri, 26 Oct 2007 00:55:01 +0200
Message-ID: <200710260055.02298.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches is intended to eliminate some design problems with=
 the
hibernation userland interface.

It makes the following changes:
* allow the user space utilities to get the size of the image via ioctl
* introduce ioctls to be used instead of SNAPSHOT_PMOPS
* mark the SNAPSHOT_SET_SWAP_FILE ioctl as deprecated
* introduce new ioctl definitions to replace the wrongly defined ones
* move the definitions of hibernation ioctls to a separate header file lo=
cated
=A0 in include/linux/ and export them to the user space
(the details are in the changelogs).

Please add to the suspend branch.

Greetings,
Rafael
