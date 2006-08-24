From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 24 Aug 2006 07:16:01 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50745C14B@dlee02.ent.ti.com>
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
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> > To some extent having lots of specific policies in the embedded
space is
> > inevitable.  The hardware is very tightly coupled.  You may have
> =

> Maybe. But you certainly do not have to export that uglyness to
> userspace. =


Some aspects are easier to manage.  If data base like operations and
such are needed it's a more friendly place.

Sysfs exporting every gory detail about PCI or USB doesn't seem so far
from this kind of thing.

> > I have some notion that a policy manager can create a state with
simple
> > & general names like fast, medium, slow (whatever) which is the
> > interface in which applications might speak.  A complex policy
> > manager
> =

> ...which is very bad interface for applications. See my other
> mail. Applications should not have to play with fast/medium/slow,
> explicitely. Instead, on opening /dev/dsp, you should power up the
> sound system (and maybe adjust cpu frequency if
> neccessary). Application should not have to do echo fast > somewhere
> before opening /dev/dsp

How does /dev/dsp know at what level it can run at?  On the SOC I
control the speed of the DSP.  I can adjust its MIPs rate.  =


We do internally have some run time algorithms on the DSP which allow it
to feed statistics back about how well it is doing... like did I drop
any frames, and how close was I to my deadline in decoding a sample.  So
there is some low level things which can be done.  The DSP is currently
has management code in the kernel (bridge driver) and it has a user
space component which can load algorithms and such through the bridge to
do things.

A missing pieces is meaningful coordination between devices.  Each
device is not an island.  Not taking care of all devices on the internal
interconnects may mean you don't get the big power savings.  For the DSP
and the Control processor to work you need each device enabled to a
sufficient performance level.  Setting them to all high means you don't
get the savings.

Doing this kind of coordination which is very specific to your use case
is difficult to achieve in a generalized fashion.  Splitting some of
this work between user and kernel space can help.

Regards,
Richard W.
