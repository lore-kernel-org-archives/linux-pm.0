From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 10:06:53 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801081004400.2643-100000__4200.79717082462$1199804893$gmane$org@iolanthe.rowland.org>
References: <200801081442.09354.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801081442.09354.oliver@neukum.org>
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

> Am Dienstag, 8. Januar 2008 04:56:03 schrieb Alan Stern:
> > > You'll have to add this method whenever a new subsystem is affected
> > > by power management.
> >=20
> > Sorry, I don't understand your point. =A0If you mean that we'll have =
to
> > add autosuspend and autoresume code to every driver that wants to
> > support autosuspend, I agree. =A0There doesn't seem to be any way aro=
und
> > it. =A0Note that the code added by the companion usb-storage patch is=
=20
> > pretty small.
>=20
> OK, you've convinced me.
> But I'd be happier if you put the notification into the generic device =
code.

Eventually parts of the autosuspend mechanism will go there.  But first
I thought we should have a proof-of-concept version working for at
least two different subsystems (such as SCSI and USB), so that we can
understand what should go into the generic layer and what should stay
out.

Alan Stern
