From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 15:05:40 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A5074D04AB@dlee02.ent.ti.com>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > > For notebooks, devices *are* islands. powerop tries to push
> > > everything-depends-on-everything model that may be good for some
SoC,
> > > but sucks for notebooks. We need some middle ground.
> >
> > USB being enabled and causing your laptop battery to dry up is a
case
> > where laptop device dependency has been shown.  There are likely
many
> > more cases.  I would expect BIOS/chip set developers are all too
aware
> > of these in their sub-domains.
> =

> No, it is because USB enabled prevents cpu from sleeping; it is
> actually well known.

I vaguely recall hearing the why.  It has some DMAs which are going on
and I suppose the processor must service the completions.

Now, if you coordinated with the USB device some how, you could try and
place the USB bus into suspend mode, and only wake up on USB remote wake
up or data to be sent, they you could likely spend a lot more time in a
lower P state.

How are you to know when it is ok to shut off the USB bus?  Is that
something which could be coordinated with the processor and the active
use case.  If I don't need high performance I could go in and out of
suspend to save power.  Knowing high, or low performance helps in this
case :)

Regards,
Richard W.
