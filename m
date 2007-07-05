From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 21:38:56 +0200
Message-ID: <200707052138.56920.oliver__25904.3418257081$1183664382$gmane$org@neukum.org>
References: <18059.10554.955290.148535@cargo.ozlabs.ibm.com>
	<20070705115400.GF3984@ucw.cz>
	<E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6Q73-0000Xi-00@dorka.pomaz.szeredi.hu>
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
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 5. Juli 2007 schrieb Miklos Szeredi:
> > > Actually fuse allows SIGKILL, because it's always fatal, and the
> > > syscall may not be restarted.
> >=20
> > I think you want to stick try_to_freeze() at the same places where yo=
u
> > do SIGKILL handling. That should solve the 'syslogd is unfreezeable'
> > problem.
>=20
> I could, but it would not solve the general problem. =C2=A0Namely, that=
 the
> presence of fuse imposes a certain ordering in which userspace tasks
> have to be frozen. =C2=A0And it is not possible to know this ordering.

Actually, why do you need this? There is no absolute need that you
finish the request. You must either finish the request or let yourself
be frozen.

A quick look through fuse reveals principally request_wait_answer()
And maybe a few other places. Is there some hidden reason you cannot
handle being frozen here?

	Regards
		Oliver
