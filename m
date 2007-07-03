From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 14:58:15 +0200
Message-ID: <200707031458.16132.rjw__6964.49262691221$1183467108$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<E1I5fug-0003ZS-00@dorka.pomaz.szeredi.hu>
	<200707031307.41366.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707031307.41366.oliver@neukum.org>
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
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 13:07, Oliver Neukum wrote:
> Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > > So to summarize, the plan that makes things work with fuse is:
> > > >=20
> > > > =C2=A0- For STR, don't do the freezer thing.
> > > >=20
> > > > =C2=A0- For STD, don't sys_sync() after you froze
> > > >=20
> > > > There might be -other- issues, but that should get you through so=
me of
> > >=20
> > > At the risk of repeating myself. Character device drivers are writt=
en
> > > with the assumption that normal io and suspend/resume do not race
> > > with each other due to the freezer.
> > > What do you intend to do about that?
> >=20
> > Oliver, can you please explain your worries in a bit more detail?
> >=20
> > I don't claim to know anything about how STR or hibernate works, but
> > neither seem to have any problem with I/O on the fuse device "racing"
> > with them.
>=20
> The problem is not with fuse. The problem is generic in nature.
>=20
> If you remove the freezer, user space remains active until the last CPU
> goes into suspend. It can do syscalls. Or do you know a clean way to ex=
empt
> only the tasks fuse might use?
>=20
> Now device drivers have a guaranteed temporal sequence:
>=20
> last io -> suspend() -> resume() [or disconnect()] -> new io
>=20
> This is because suspend() is called after the freezer goes into action.=
 If
> you remove the freezer, you need to deal with
>=20
> 1. io to suspended devices
> 2. resume() assuming that the device is in the state suspend() left it
> 3. io changing a device's state while suspend is saving it
>=20
> and you need to fix this for all device drivers, not just those fuse is
> involved with. Removing the freezer means doing a more or less full
> audit of every driver and additional locking in many drivers.

Agreed.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
