From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 16:18:06 +0100
Message-ID: <200801081618.07067.oliver__16130.2399276339$1199805536$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0801081006580.2643-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801081006580.2643-100000@iolanthe.rowland.org>
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

Am Dienstag, 8. Januar 2008 16:12:52 schrieb Alan Stern:
> On Tue, 8 Jan 2008, Oliver Neukum wrote:
>=20
> > Am Montag, 7. Januar 2008 20:42:23 schrieb Alan Stern:
> > > =A0/**
> > > + *=A0=A0=A0=A0=A0autoresume - perform dynamic (runtime) host resum=
e
> > > + *=A0=A0=A0=A0=A0@shp: host to resume
> > > + *
> > > + *=A0=A0=A0=A0=A0Resume (return to an operational power level) the=
 specified host.
> > > + *=A0=A0=A0=A0=A0Return 0 if the resume was successful, otherwise =
a negative
> > > + *=A0=A0=A0=A0=A0error code.
> > > + *
> > > + *=A0=A0=A0=A0=A0Locks: struct Scsi_Host::pm_mutex held throughout=
 the call.
> > > + *
> > > + *=A0=A0=A0=A0=A0Calling context: process
> > > + *
> > > + *=A0=A0=A0=A0=A0Notes: If the host is not currently suspended, th=
is method does
> > > + *=A0=A0=A0=A0=A0need to do anything.
> > > + *
> > > + *=A0=A0=A0=A0=A0Optionally defined in: LLD
> > > + **/
> > > + =A0 =A0int autoresume(struct Scsi_Host *shp)
> > > +
> >=20
> > This seems to be a bit misleading. It seems to me that you must cance=
l
> > any outstanding request to autosuspend from other layers.
>=20
> How about something more like this:
>=20
> *	Resume (return to an operational power level) the specified host,
> *	and prevent autosuspends from other software layers until the
> *	template autosuspend method has been called again.
> *	Return 0 if the resume was successful, otherwise a negative
> *	error code.

Much better.

	Regards
		Oliver
