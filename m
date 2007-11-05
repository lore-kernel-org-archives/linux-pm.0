From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/5] Hibernation: Clean up userland interface
	(rev. 2)
Date: Mon, 5 Nov 2007 12:50:21 -0500
Message-ID: <200711051250.21172.lenb@kernel.org>
References: <200710260055.02298.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710260055.02298.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 25 October 2007 18:55, Rafael J. Wysocki wrote:
> Hi,
>=20
> This series of patches is intended to eliminate some design problems wi=
th the
> hibernation userland interface.
>=20
> It makes the following changes:
> * allow the user space utilities to get the size of the image via ioctl
> * introduce ioctls to be used instead of SNAPSHOT_PMOPS
> * mark the SNAPSHOT_SET_SWAP_FILE ioctl as deprecated
> * introduce new ioctl definitions to replace the wrongly defined ones
> * move the definitions of hibernation ioctls to a separate header file =
located
> =A0 in include/linux/ and export them to the user space
> (the details are in the changelogs).
>=20
> Please add to the suspend branch.

done.

thanks for doing this in a way that doesn't break existing user-binaries.

-Len
