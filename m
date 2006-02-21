From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/5] [pm] Respect the actual device power
	states in sysfs interface
Date: Tue, 21 Feb 2006 12:25:25 +0100
Message-ID: <20060221112525.GA22068@elf.ucw.cz>
References: <Pine.LNX.4.50.0602171758160.30811-100000@monsoon.he.net>
	<20060218155543.GE5658@openzaurus.ucw.cz>
	<Pine.LNX.4.50.0602191557520.8676-100000@monsoon.he.net>
	<20060220004635.GA22576@kroah.com>
	<Pine.LNX.4.50.0602200955030.12708-100000@monsoon.he.net>
	<20060220220404.GA25746@kroah.com>
	<Pine.LNX.4.50.0602201655580.21145-100000@monsoon.he.net>
	<20060221105711.GK21557@elf.ucw.cz>
	<Pine.LNX.4.50.0602210312020.10683-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60032993434401138=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602210312020.10683-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

--===============60032993434401138==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > However, there are a couple of things to note:
> > >
> > > - These patches don't create a new API; they fix the semantics of an
> > >   existing API by restoring them to its originally designed semantics.
> >
> > They may reintroduce "original" semantics, but they'll break
> > applications needing 2.6.15 semantic (where 2 meant D3hot).
> 
> Like what?

Like:

http://article.gmane.org/gmane.linux.kernel/364195/match=pavel+2+sys+power+state+pcmcia
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

--===============60032993434401138==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60032993434401138==--
