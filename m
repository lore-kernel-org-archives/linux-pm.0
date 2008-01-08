From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 10:16:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801081013090.2643-100000__5976.39927077598$1199805480$gmane$org@iolanthe.rowland.org>
References: <200801081600.52518.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801081600.52518.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, SCSI development list <linux-scsi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 8 Jan 2008, Oliver Neukum wrote:

> Am Montag, 7. Januar 2008 20:42:23 schrieb Alan Stern:
> > This patch applies to 2.6.24-rc6. =A0Comments and suggestions are=20
> > welcome.
>=20
> What about the SG_IO ioctl() ? It seems to me that you must not autosus=
pend
> a device after that ioctl() has been used until the file handle is clos=
ed.

That's an open problem.  The patch does block autosuspends as long as=20
an sg file handle is open, but that won't help with ioctl requests=20
through the block device.

Can you write an additional patch to fix this?

Alan Stern
