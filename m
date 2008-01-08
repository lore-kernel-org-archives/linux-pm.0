From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 16:30:48 +0100
Message-ID: <200801081630.49376.oliver__7450.81140562451$1199806313$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0801081013090.2643-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801081013090.2643-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 8. Januar 2008 16:16:43 schrieb Alan Stern:
> > What about the SG_IO ioctl() ? It seems to me that you must not autos=
uspend
> > a device after that ioctl() has been used until the file handle is cl=
osed.
>=20
> That's an open problem. =A0The patch does block autosuspends as long as=
=20
> an sg file handle is open, but that won't help with ioctl requests=20
> through the block device.
>=20
> Can you write an additional patch to fix this?

I'll work on that.

	Regards
		Oliver
