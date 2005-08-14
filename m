From: Pavel Machek <pavel@suse.cz>
Subject: Re: Toward runtime power management in Linux
Date: Sun, 14 Aug 2005 21:53:18 +0200
Message-ID: <20050814195317.GE1686@openzaurus.ucw.cz>
References: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
	<20050801021054.GA30859@best.com>
	<1122896686.2647.32.camel@localhost>
	<20050802024415.C3518DB57B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
	<20050804080649.GF22000@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============52731819377603695=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050804080649.GF22000@atomide.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Tony Lindgren <tony@atomide.com>
Cc: david-b@pacbell.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============52731819377603695==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > >	to power down, couldn't the PM framework take care of
> > > recursively sending 'power down' message to all children, wait for
> > > confirmation, and then power itself down?
> > 
> > Could, arguably should -- but doesn't, just now.  I don't
> > think I'd try to manage all system devices' power through
> > sysfs from usermode yet ... :)
> 
> There are some cases where the whole bus can be powered down, but
> a device on the bus needs to be left on to provide wake-up events.

such device can be "off" as far as driver model knows.			Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


--===============52731819377603695==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============52731819377603695==--
