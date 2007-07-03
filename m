From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 13:07:39 +0200
Message-ID: <200707031307.41366.oliver__49112.0467930616$1183461235$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707030944.18702.oliver@neukum.org>
	<E1I5fug-0003ZS-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I5fug-0003ZS-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > So to summarize, the plan that makes things work with fuse is:
> > >=20
> > > =C2=A0- For STR, don't do the freezer thing.
> > >=20
> > > =C2=A0- For STD, don't sys_sync() after you froze
> > >=20
> > > There might be -other- issues, but that should get you through some=
 of
> >=20
> > At the risk of repeating myself. Character device drivers are written
> > with the assumption that normal io and suspend/resume do not race
> > with each other due to the freezer.
> > What do you intend to do about that?
>=20
> Oliver, can you please explain your worries in a bit more detail?
>=20
> I don't claim to know anything about how STR or hibernate works, but
> neither seem to have any problem with I/O on the fuse device "racing"
> with them.

The problem is not with fuse. The problem is generic in nature.

If you remove the freezer, user space remains active until the last CPU
goes into suspend. It can do syscalls. Or do you know a clean way to exem=
pt
only the tasks fuse might use?

Now device drivers have a guaranteed temporal sequence:

last io -> suspend() -> resume() [or disconnect()] -> new io

This is because suspend() is called after the freezer goes into action. I=
f
you remove the freezer, you need to deal with

1. io to suspended devices
2. resume() assuming that the device is in the state suspend() left it
3. io changing a device's state while suspend is saving it

and you need to fix this for all device drivers, not just those fuse is
involved with. Removing the freezer means doing a more or less full
audit of every driver and additional locking in many drivers.

	Regards
		Oliver
