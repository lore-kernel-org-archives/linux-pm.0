From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Power Management Policies
Date: Thu, 28 Apr 2005 13:28:57 -0700
Message-ID: <200504281328.57807.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<200504281016.44512.david-b@pacbell.net>
	<20050428185959.GA12495@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============93889494937526319=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050428185959.GA12495@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============93889494937526319==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 28 April 2005 11:59 am, Pavel Machek wrote:
> Hi!
> 
> > > sl-5500 has peripheral controller, but sl-5600 and newer should have a
> > > host controller. [Unfortunately mine is 5500.]
> > 
> > I think you're wrong about all except possibly the very latest ones
> > using pxa27x chips.  The pxa25x based products would need a separate
> > controller chip to get host functionality.  I know for a fact that
> > even the C-860 doesn't have one integrated; folk use that CF/IO card,
> > with an sl811hs driver, if they crave a USB keyboard or flashdisk.
> 
> I searched web a bit, on amazon pages:
> 
> Sharp Zaurus SL-6000L Handheld

That's sort of an exception, designed originally for IBM as I recall
and not originally as a "consumer" product.


> ...
>     * Input/Output: USB 1.1 host connector mini Type-A, IR port, 2.5
>                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Making me wonder what controller chip it uses ... or alternatively,
if that listing is wrong.  (It's been known to happen...)

> Okay, that's strange. Mini conectors are only device-side, right?

It's just a wee bit rare.  There are three kinds of USB "Mini"
sockets, used with "Mini-A" or "Mini-B" connectors on cables:

   - Mini-A, as above ... host only.  The Psion NetBook does this
     too (pxa 255 based, sl811hs host, no USB peripheral).  Used
     normally with an adapter, Mini-A to standard-A/socket, plus a
     more standard A-to-B cable like you'd use with a PC.

   - Mini-B, what you're thinking of ... peripheral only.  I've seen
     this on a variety of USB peripherals by now.   Cables normally
     go Mini-B to standard-A

   - Mini-AB, OTG-only ... you can connect either the Mini-A end
     of a cable into it, or the Mini-B end.  The device acts as
     either host or peripheral, as necessary.

I'd rather see OTG devices, with Mini-AB sockets, than Mini-A; but
OTG takes a while to adopt.


> If c-860 does not have usb, I was probably wrong (or confused by
> something like above...)

Just confused.  Mini-A is indeed not common.  C860 does have USB,
except it's the peripheral support (like most all PDAs I've seen).

- Dave

--===============93889494937526319==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============93889494937526319==--
