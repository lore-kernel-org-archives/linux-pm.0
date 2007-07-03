From: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 03 Jul 2007 12:47:18 +0200
Message-ID: <E1I5fug-0003ZS-00__21392.3115436502$1183459937$gmane$org@dorka.pomaz.szeredi.hu>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
	<200707030944.18702.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200707030944.18702.oliver@neukum.org> (message from Oliver
	Neukum on Tue, 3 Jul 2007 09:44:18 +0200)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: oliver@neukum.org
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg59@srcf.ucam.org
List-Id: linux-pm@vger.kernel.org

> > So to summarize, the plan that makes things work with fuse is:
> >=20
> > =C2=A0- For STR, don't do the freezer thing.
> >=20
> > =C2=A0- For STD, don't sys_sync() after you froze
> >=20
> > There might be -other- issues, but that should get you through some o=
f
>=20
> At the risk of repeating myself. Character device drivers are written
> with the assumption that normal io and suspend/resume do not race
> with each other due to the freezer.
> What do you intend to do about that?

Oliver, can you please explain your worries in a bit more detail?

I don't claim to know anything about how STR or hibernate works, but
neither seem to have any problem with I/O on the fuse device "racing"
with them.

And conceptually I can't see anything that would cause trouble either.
The fuse kernel module just provides a specialized IPC mechanism,
where one userspace process communicates with another using file
operations and a char dev.

Miklos
