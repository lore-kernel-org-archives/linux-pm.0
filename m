From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [2/6] 2.6.21-rc2: known regressions
Date: Sat, 10 Mar 2007 16:18:04 +0100
Message-ID: <20070310151804.GA10627@elte.hu>
References: <20070305015034.GG3441@stusta.de>
	<20070308123143.GF5149@mellanox.co.il>
	<Pine.LNX.4.64.0703080954220.10832@woody.linux-foundation.org>
	<20070308192554.GA2999@elte.hu> <20070308230705.GA4611@elte.hu>
	<Pine.LNX.4.64.0703081545110.10832@woody.linux-foundation.org>
	<20070309174821.GA31754@linuxtv.org>
	<20070309233508.GB2197@elf.ucw.cz> <20070310090121.GB15647@elte.hu>
	<20070310114301.GA30554@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070310114301.GA30554@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Stefan Seyfried <seife@suse.de>
Cc: Ash Milsted <thatistosayiseenem@gawab.com>, Johannes Stezenbach <js@linuxtv.org>, Arkadiusz Miskiewicz <arekm@maven.pl>, linux-pm@lists.osdl.org, Jens Axboe <jens.axboe@oracle.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, dmitry.torokhov@gmail.com, linux-usb-devel@lists.sourceforge.net, Jeff Chua <jeff.chua.linux@gmail.com>, Meelis Roos <mroos@linux.ee>, Janosch Machowinski <jmachowinski@gmx.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Thomas Meyer <thomas.mey@web.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Stefan Seyfried <seife@suse.de> wrote:

> > btw., the s2ram database seems quite a bit spotty:
> > =

> >  $ ./s2ram -n
> >  Machine is unknown.
> >  This machine can be identified by:
> >      sys_vendor   =3D "System manufacturer"
> >      sys_product  =3D "System Product Name"
> >      sys_version  =3D "System Version"
> >      bios_version =3D "ASUS A8N-E ACPI BIOS Revision 1008"
> > =

> >  $ ./s2ram -n
> >  Machine is unknown.
> >  This machine can be identified by:
> >     sys_vendor   =3D "Hewlett-Packard "
> >     sys_product  =3D "compaq nx9030 (PG630ET#ABD)       "
> >     sys_version  =3D "Rev 1           "
> >     bios_version =3D "F.15    "
> >  See http://en.opensuse.org/S2ram for details.
> > =

> > even at the link above i didnt find any clear algorithm about how to =

> > extend the quirks-list and the white-list - while i expect that most =

> > people experience what i did: that s2ram doesnt know their boxes. =

> > (otherwise they would not visit that URL at all i suspect)
> =

> Ok. To be honest, you are the first reporter that seems to have read =

> the documentation above, but not understood what to do.

thanks for the compliment ;-) _I_ very much know what to do (i mailed =

the right person after all ;), but i dont really count and on the 6 =

systems i tried s2ram said on 5 that it's 'unknown', i assumed it could =

possibly be due to the visible lack of clear instructions on that =

webpage ;-)

> i might consider reworking the documentation if there are more reports =

> about problems with the procedure.

Probably tweaking the webpage doesnt help because people dont get there =

- as the results plainly show it. Maybe some more automation would be =

useful too, a tool that detects failed resume and tries all those =

options that makes sense on that box or something? It's not like that =

people dont _try_ suspend/resume on Linux, it's just that they find it =

doesnt work and there is no clear mortal-usable (end-user-) way of =

fixing it and submitting the result of that fixing.

	Ingo
