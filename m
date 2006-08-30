From: Pavel Machek <pavel@suse.cz>
Subject: Re: T60 not coming out of suspend to RAM
Date: Wed, 30 Aug 2006 16:46:46 +0200
Message-ID: <20060830144646.GC1923@elf.ucw.cz>
References: <20060828122535.911e593a.akpm@osdl.org>
	<20060828201934.GA26544@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060828201934.GA26544@mellanox.co.il>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Thomas Glanzmann <sithglan@stud.uni-erlangen.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > > OK, it turns out the problem was with running SATA drive in AHCI =
mode.
> > > > > =

> > > > > After applying the following patch from Forrest Zhao
> > > > > http://lkml.org/lkml/2006/7/20/56
> > > > > both suspend to disk and suspend to ram work fine now.
> > > > > This patch is going into 2.6.18, isn't it?
> > > > =

> > > > Not sure, check latest -rc5, and if it is not there, ask akpm...
> > > > =

> > > =

> > > Andrew, this is going into 2.6.18, isn't it? I don't see it in -rc5.
> > > =

> > =

> > It looks like Forrest's stuff is all queued up in the libata devel tree,
> > although in a significantly different-looking form.
> > =

> > So no, right now it doesn't look good for 2.6.18.
> > =

> =

> Ugh, more's the pity :(
> How about merging this one patch? T60 is only half as useful without it (=
no disk
> after resume), and the rate of changes in libata is high so just using a =
patch
> is gonnu be painful in the long run.

I guess you need to convince SATA maintainer that patch is safe before
it can go in...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
