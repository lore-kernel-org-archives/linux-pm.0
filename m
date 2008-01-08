From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 14:42:08 +0100
Message-ID: <200801081442.09354.oliver__16166.1604921848$1199799777$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0801072235110.30331-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801072235110.30331-100000@netrider.rowland.org>
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

Am Dienstag, 8. Januar 2008 04:56:03 schrieb Alan Stern:
> > You'll have to add this method whenever a new subsystem is affected
> > by power management.
>=20
> Sorry, I don't understand your point. =A0If you mean that we'll have to
> add autosuspend and autoresume code to every driver that wants to
> support autosuspend, I agree. =A0There doesn't seem to be any way aroun=
d
> it. =A0Note that the code added by the companion usb-storage patch is=20
> pretty small.

OK, you've convinced me.
But I'd be happier if you put the notification into the generic device co=
de.

	Regards
		Oliver
