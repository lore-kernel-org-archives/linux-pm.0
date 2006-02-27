From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Mon, 27 Feb 2006 11:06:21 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602271105100.28882-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220004635.GA22576@kroah.com>
	<Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
	<20060220220404.GA25746@kroah.com>
	<Pine.LNX.4.50.0602201655580.21145-100000@monsoon.he.net>
	<20060221105711.GK21557@elf.ucw.cz>
	<Pine.LNX.4.50.0602210312020.10683-100000@monsoon.he.net>
	<20060221112525.GA22068@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61000592639373585=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060221112525.GA22068@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============61000592639373585==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 21 Feb 2006, Pavel Machek wrote:

> Hi!
>
> > > > However, there are a couple of things to note:
> > > >
> > > > - These patches don't create a new API; they fix the semantics of an
> > > >   existing API by restoring them to its originally designed semantics.
> > >
> > > They may reintroduce "original" semantics, but they'll break
> > > applications needing 2.6.15 semantic (where 2 meant D3hot).
> >
> > Like what?
>
> Like:
>
> http://article.gmane.org/gmane.linux.kernel/364195/match=pavel+2+sys+power+state+pcmcia

Thanks, but recall that that is PCMCIA. The point of the patch was to pass
the value to the bus drivers, so that they could decide what were valid
values. In the case of PCMCIA, they had adapted to "2", so they could
still receive "2", if the user process wrote that..

Thanks,


	Patrick


--===============61000592639373585==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61000592639373585==--
