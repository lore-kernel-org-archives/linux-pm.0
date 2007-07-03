From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 13:27:55 +0200
Message-ID: <200707031327.56577.oliver__46053.2630947002$1183462361$gmane$org@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031307.41366.oliver@neukum.org>
	<E1I5gSu-0003f4-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I5gSu-0003f4-00@dorka.pomaz.szeredi.hu>
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
> > > > > So to summarize, the plan that makes things work with fuse is:
> > > > >=20
> > > > > =C2=A0- For STR, don't do the freezer thing.
> > > > >=20
> > > > > =C2=A0- For STD, don't sys_sync() after you froze
> > > > >=20
> > > > > There might be -other- issues, but that should get you through =
some of
> > > >=20
> > > > At the risk of repeating myself. Character device drivers are wri=
tten
> > > > with the assumption that normal io and suspend/resume do not race
> > > > with each other due to the freezer.
> > > > What do you intend to do about that?
> > >=20
> > > Oliver, can you please explain your worries in a bit more detail?
> > >=20
> > > I don't claim to know anything about how STR or hibernate works, bu=
t
> > > neither seem to have any problem with I/O on the fuse device "racin=
g"
> > > with them.
> >=20
> > The problem is not with fuse. The problem is generic in nature.
> >=20
> > If you remove the freezer, user space remains active until the last C=
PU
> > goes into suspend. It can do syscalls. Or do you know a clean way to =
exempt
> > only the tasks fuse might use?
>=20
> You are talking about hibernate, right? =C2=A0Suspending (to ram) is
> instantaneous, in that _after_ suspend no CPU is active obviously.

If that is so, why do you care? If it is really atomic, fuse has no chanc=
e
to call out to its component in user space either. Removing the freezer
cannot make a difference.

Something is fishy here.

	Regards
		Oliver
