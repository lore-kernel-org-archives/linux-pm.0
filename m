From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 18 Aug 2006 20:54:07 +0300
Message-ID: <1155923647.22100.43.camel@Dogbert.NOE.nokia.com>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<1155638115.6736.135.camel@localhost>	<20060815190439.GI7612@redhat.com>
	<1155733089.10017.17.camel@Dogbert.NOE.nokia.com>
	<20060817213903.GD6450@ucw.cz>
	<1155895341.22100.1.camel@Dogbert.NOE.nokia.com>
	<44E5DCDB.1080306@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <44E5DCDB.1080306@linux.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ext Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: linux-pm@lists.osdl.org, ext Pavel Machek <pavel@ucw.cz>, "Kucheria Amit (Nokia-M/Tampere)" <Amit.Kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2006-08-18 at 18:29 +0300, ext Alexey Starikovskiy wrote:
> Igor Stoppa wrote:
> > On Fri, 2006-08-18 at 00:39 +0300, ext Pavel Machek wrote:
> >> Hi!
> >>
> >>>> If there are dependancies inherently linking core1 and core2,
> >> cpufreq
> >>>> should already be programming both parts. For example, the SA1100
> >>>> driver programs both CPU and SDRAM controller.  If there isn't
> any
> >>>> dependancy
> >>>> between them, I don't see the attraction of creating an
> artificial
> >> one
> >>>> in the way suggested for no real purpose.
> >>>>
> >>>> Things like voltage and frequency are closely tied together, so
> >>>> offering
> >>>> any means of controlling them independantly makes no sense
> afaics.
> >>> Yet a certain subsystem (for example an onboard camera, in a
> phone)
> >>> might require a higher voltage when it's active, effectively
> >> loosening
> >>> the tight coupling between freq and voltage that the porcessor is
> >>> enforcing.
> >> So... you expect userland to echo high > state before camera can be
> >> used?
> >>
> >> I'd rather have kernel automagically up the voltage
> when /dev/video0
> >> is opened...
> >
> > Not really, I meant that the CPU is not the only customer of power
> > domains (depend on the HW design), so the relation freq <-> voltage
> is
> > not always true.
> >
> Then you need to introduce power domains and associate your devices
> with them, isn't it?
> So if your camera appears in the same domain with CPU, the voltage of
> that domain will go up either with camera=3Don, or CPU going to higher
> frequency.

I used the expression "power domain" to refer to a generic domain,
either voltage or frequency, to indicate that changing either freq or
voltage in a domain implies changing the domain power level.

Of course it is changing linearly with frequency, while the dependency
from voltage is quadratic.

So in the camera example we might have 2 different cases:

-the one mentioned above, where the camera shares the same voltage
domain with CPU and the correlation is the one you described

-another case where the clock frequency provided to the camera is
related to the resolution being used

camera off =3D> no constraints
low res =3D> low freq, high voltage
high res =3D> high freq, high voltage

in such case the currently active resolution would affect whatever
device shares the camera clock, if any.

But no need to introduce power domains. =


-- =

Cheers,
           Igor

Igor Stoppa (Nokia M - OSSO / Tampere)
