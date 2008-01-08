From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 10:12:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801081006580.2643-100000__23839.8458147005$1199805268$gmane$org@iolanthe.rowland.org>
References: <200801081512.55746.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801081512.55746.oliver@neukum.org>
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
> > =A0/**
> > + *=A0=A0=A0=A0=A0autoresume - perform dynamic (runtime) host resume
> > + *=A0=A0=A0=A0=A0@shp: host to resume
> > + *
> > + *=A0=A0=A0=A0=A0Resume (return to an operational power level) the s=
pecified host.
> > + *=A0=A0=A0=A0=A0Return 0 if the resume was successful, otherwise a =
negative
> > + *=A0=A0=A0=A0=A0error code.
> > + *
> > + *=A0=A0=A0=A0=A0Locks: struct Scsi_Host::pm_mutex held throughout t=
he call.
> > + *
> > + *=A0=A0=A0=A0=A0Calling context: process
> > + *
> > + *=A0=A0=A0=A0=A0Notes: If the host is not currently suspended, this=
 method does
> > + *=A0=A0=A0=A0=A0need to do anything.
> > + *
> > + *=A0=A0=A0=A0=A0Optionally defined in: LLD
> > + **/
> > + =A0 =A0int autoresume(struct Scsi_Host *shp)
> > +
>=20
> This seems to be a bit misleading. It seems to me that you must cancel
> any outstanding request to autosuspend from other layers.

How about something more like this:

*	Resume (return to an operational power level) the specified host,
*	and prevent autosuspends from other software layers until the
*	template autosuspend method has been called again.
*	Return 0 if the resume was successful, otherwise a negative
*	error code.

Alan Stern
