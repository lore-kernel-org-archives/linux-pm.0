From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC Disable suspend on a specific device] This is	a
	little change in linux power scheme
Date: Thu, 9 Apr 2009 15:33:47 +0100
Message-ID: <20090409143347.GA22508@sirena.org.uk>
References: <200904072257.23756.rjw@sisk.pl> <200904081013.25301.rjw@sisk.pl>
	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl>
	<20090408114212.GK20122@sirena.org.uk>
	<1239209041.6228.217.camel@localhost>
	<20090408182330.GA6843@sirena.org.uk>
	<1239220387.6228.233.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1239220387.6228.233.camel@localhost>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 08, 2009 at 10:53:07PM +0300, Igor Stoppa wrote:
> On Wed, 2009-04-08 at 20:23 +0200, ext Mark Brown wrote:

> > Essentially what they are doing is
> > exactly what you suggest, they've identified that suspend is a low power
> > state and make every effort to enter it as often as possible, including
> > when on a call. 

> I'm not suggesting that. Suspend is inadequate for _real_ runtime power
> management. Certainly it is not seamless.
> Of course a smarter approach depends on the HW supporting certain
> features, but if the HW is not there, I'd rather consider the suspend
> based approach a workaround, rather than a real solution.

Oh sure, but in principle it's exactly the same idea and you wouldn't
want to use the Android approach without also trying to drive the system
power down as much as possible while active.  Either way you're trying
to drive the system to the lowest power state automatically.

I'm not saying that it's the most lovely idea ever but there does seem
to be a use case, more in terms of stopping user space than anything
kernel side.

> >  Clearly there are some issues with this approach but
> > the Android guys did feel that entering suspend was worthwhile for them,
> > especially since their users are able to download applications to the
> > phone.

> I don't think this is anyhow different from the Nokia Internet Tablets.

Technically there's no difference.  The differences sound like they are
more on the support side and probably reflect the differences in
distribution chain, support model and expected user base for the
products.

> > Besides, no matter how low the power drain from your CPU when fully
> > gated and at the lowest DVFS setting it's still possible to get a lower

> If you have a proper SoC, it can enter clock stop, lower voltage and

...

> Regulators should have the options to be switched off if they are not
> needed to preserve states, or enter a low power mode when only minimal
> (non functional current) is needed.

Right, the issue is that the system also needs to be able to arrange to
power down the supplies to the SoC for maximum power savings.  Good on
chip power management is much more common than the ability to do that
without entering suspend.  Like I say, the savings from this are going
to be very small anywy so it's probably not worth worrying too much about.
