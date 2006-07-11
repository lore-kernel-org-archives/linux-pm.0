From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Tue, 11 Jul 2006 09:38:37 -0700
Message-ID: <200607110938.37776.david-b@pacbell.net>
References: <200607101525.43507.david-b@pacbell.net>
	<20060710225631.f520bca5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060710225631.f520bca5.akpm@osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > Two Models for Device Power Management
> =

> Is useful, thanks.  Later on it'd be good to include some pointers to
> drivers which do everything right, and which are well-maintained, for peo=
ple
> to crib from.  (Not "skeleton" drivers, IMO - they tend to go out-of-date=
).

We should have more drivers like that, yes!  I'm not sure I'd want
links to them in that text file though ... it's hard enough to keep
writeups current.


> It's all very suspend-the-whole-machine centric. =


Which reflects the current state of the APIs, and also the fact that
for the "driver doesn't needlessly waste power" cases there don't
need much interaction with other PM code.

We do have clk_disable() for hardware that needs it, and there's some
discussion of a similar power supply API for switching supplies on/off.
Those APIs would also be used in suspend-the-whole-thing cases.


> We don't presently help =

> that NIC driver to put itself into a low-power state if there's been no n=
et
> activity for 100 milliseconds.  I guess that comes later.

Maybe WLAN firmware can do that stuff, but most Ethernet hardware I've
had occasion to look at can't do that.  It needs e.g. the 50 MHz clock
for the PHY so there's no point in a clk_disable(), and DMA active, etc.

Ther's some notion that the kernel could help with autosuspending though,
and some work to make it happen for USB.

- Dave
