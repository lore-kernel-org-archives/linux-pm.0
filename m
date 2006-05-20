From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend and hibernate nomenclature
Date: Sat, 20 May 2006 22:55:50 +0200
Message-ID: <20060520205550.GA8490@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0605201520140.29313-100000@netrider.rowland.org>
	<200605201347.27957.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============60604146819646498=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200605201347.27957.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, richard@hughsie.com
List-Id: linux-pm@vger.kernel.org

--===============60604146819646498==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > > ?? WOL is for different functionality, I'm afraid. Or do you know
> > > > > ethernet hub that automagically wakes machines when data come?
> > > > 
> > > > No, that's exactly what WOL is designed for.  A typical scenarios has
> > > > the adapter waking up when the incoming packet is unicast to the MAC
> > > > address of that host.  The hub/switch would act normally.
> > > 
> > > I do not think WOL wakes that way. IIRC it needs magic ethernet
> > > packet.
> > 
> > That's right.  I don't remember what the contents need to be, but WOL 
> > doesn't work with any old ethernet packet.
> 
> You're both wrong.  Notice what "man ethtool" reports:

Ok, you are right and I was wrong....

>        wol p|u|m|b|a|g|s|d...
>               Set Wake-on-LAN options.  Not all devices support this.  The argument to this
>               option is a string of characters specifying which options to enable.
> 
>               p  Wake on phy activity
>               u  Wake on unicast messages
>               m  Wake on multicast messages
>               b  Wake on broadcast messages
>               a  Wake on ARP
>               g  Wake on MagicPacket(tm)
>               s  Enable SecureOn(tm) password for MagicPacket(tm)
>               d  Disable (wake on nothing).  This option clears all
>        previous options.

...I only knew about magicpacket-like stuff.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

--===============60604146819646498==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============60604146819646498==--
