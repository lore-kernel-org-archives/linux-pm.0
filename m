From: Tony Lindgren <tony@atomide.com>
Subject: Re: Toward runtime power management in Linux
Date: Thu, 4 Aug 2005 01:06:49 -0700
Message-ID: <20050804080649.GF22000@atomide.com>
References: <Pine.LNX.4.44L0.0507302219250.13423-100000@netrider.rowland.org>
	<20050801021054.GA30859@best.com>
	<1122896686.2647.32.camel@localhost>
	<20050802024415.C3518DB57B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74010971445137375=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050802024415.C3518DB57B@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david-b@pacbell.net
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============74010971445137375==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* david-b@pacbell.net <david-b@pacbell.net> [050801 19:44]:
> > From: Amit Kucheria <amit.kucheria@nokia.com>
> > Date: Mon, 01 Aug 2005 14:44:46 +0300
> >
> > ...
> > If I tell a bus
> 
> (... or any other device with child nodes, like a USB hub or
> various system bridges ...)
> 
> 
> >	to power down, couldn't the PM framework take care of
> > recursively sending 'power down' message to all children, wait for
> > confirmation, and then power itself down?
> 
> Could, arguably should -- but doesn't, just now.  I don't
> think I'd try to manage all system devices' power through
> sysfs from usermode yet ... :)

There are some cases where the whole bus can be powered down, but
a device on the bus needs to be left on to provide wake-up events.

The wake-up event might take another path, such as GPIO, and the
bus can be powered down with some devices on.

An example that comes to mind is the smc91x Ethernet driver on
OMAP OSK board.

Regards,

Tony

--===============74010971445137375==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============74010971445137375==--
