From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [RFC] Implementation of SCSI dynamic power management
Date: Tue, 8 Jan 2008 15:12:55 +0100
Message-ID: <200801081512.55746.oliver__14927.8196426623$1199801644$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0801071244180.2748-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0801071244180.2748-100000@iolanthe.rowland.org>
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

Am Montag, 7. Januar 2008 20:42:23 schrieb Alan Stern:
> =A0/**
> + *=A0=A0=A0=A0=A0autoresume - perform dynamic (runtime) host resume
> + *=A0=A0=A0=A0=A0@shp: host to resume
> + *
> + *=A0=A0=A0=A0=A0Resume (return to an operational power level) the spe=
cified host.
> + *=A0=A0=A0=A0=A0Return 0 if the resume was successful, otherwise a ne=
gative
> + *=A0=A0=A0=A0=A0error code.
> + *
> + *=A0=A0=A0=A0=A0Locks: struct Scsi_Host::pm_mutex held throughout the=
 call.
> + *
> + *=A0=A0=A0=A0=A0Calling context: process
> + *
> + *=A0=A0=A0=A0=A0Notes: If the host is not currently suspended, this m=
ethod does
> + *=A0=A0=A0=A0=A0need to do anything.
> + *
> + *=A0=A0=A0=A0=A0Optionally defined in: LLD
> + **/
> + =A0 =A0int autoresume(struct Scsi_Host *shp)
> +

This seems to be a bit misleading. It seems to me that you must cancel
any outstanding request to autosuspend from other layers.

	Regards
		Oliver
