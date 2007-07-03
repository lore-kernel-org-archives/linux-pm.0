From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 13:50:00 +0200
Message-ID: <200707031350.01111.oliver@neukum.org>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031327.56577.oliver@neukum.org>
	<1183463113.10386.114.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183463113.10386.114.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mjg59@srcf.ucam.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 3. Juli 2007 schrieb Benjamin Herrenschmidt:
> On Tue, 2007-07-03 at 13:27 +0200, Oliver Neukum wrote:
> > > You are talking about hibernate, right? =C2=A0Suspending (to ram) i=
s
> > > instantaneous, in that _after_ suspend no CPU is active obviously.
> >=20
> > If that is so, why do you care? If it is really atomic, fuse has no
> > chance
> > to call out to its component in user space either. Removing the
> > freezer
> > cannot make a difference.
>=20
> It's not atomic. You will get called after suspend() in drivers. The
> thing is ... you just have to deal with it :-)

So you are volunteering to go through all drivers >:-> ?

	Regards
		Oliver
