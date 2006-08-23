From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 23 Aug 2006 14:20:41 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50745BBF5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>, Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > I guess it just defines an appropriate policy. You can call it
> > 'usb_mp3' if you wish ;)
> > I don't think it's too embedded-specific.
> =

> Well, it leads to exponential number of policies -- not nice. Having
> usb_mp3_fileserver_webserver is not nice.

To some extent having lots of specific policies in the embedded space is
inevitable.  The hardware is very tightly coupled.  You may have almost
all the functionality of a PC some 5 years back on a single chip.  In
that kind of environment not taking into account the chip as a whole
means you do power at a 10x or say 100x of optimal.  You don't get the
big interconnect savings unless you link the all the individual device
states with the processor states.  A 400mA@1.3v might sound good to a PC
centric person, but when the design target is 4mA@1.3v it is not good.

I have some notion that a policy manager can create a state with simple
& general names like fast, medium, slow (whatever) which is the
interface in which applications might speak.  A complex policy manager
will associate this name with device and cpu states in great detail.  A
more general purpose one only need map it to some governor and its run
time parameters.

Regards,
Richard W.
