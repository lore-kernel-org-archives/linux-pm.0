From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Wakeup settings for USB hubs?
Date: Thu, 5 Jul 2007 21:18:59 +0200
Message-ID: <200707052118.59885.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0707051054040.3728-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707051054040.3728-100000@iolanthe.rowland.org>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Alan Stern:
> Allow me to rephrase. =A0You seem to be saying that /sys/.../power/wake=
up=20
> should be able to hold four different values:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A01. always disabled
> =A0=A0=A0=A0=A0=A0=A0=A02. always enabled
> =A0=A0=A0=A0=A0=A0=A0=A03. enabled at runtime but not during system sle=
ep
> =A0=A0=A0=A0=A0=A0=A0=A04. enabled during system sleep but not at runti=
me
>=20
> Right? =A0With the default being 3 (except for a few things like the=20
> power button).
>=20
> Or maybe there should be two attribute files: wakeup (used during
> system sleep) and wakeup_runtime (used for runtime suspend).
>=20
> Comments from anybody else?

I am not sure we ever want to do runtime suspend without remote wakeup.
If we want that then it is orthogonal to its value during system sleep.
That would call for two attributes.

	Regards
		Oliver
