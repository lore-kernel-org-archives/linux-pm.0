From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 17 Aug 2006 21:39:03 +0000
Message-ID: <20060817213903.GD6450@ucw.cz>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155733089.10017.17.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1155733089.10017.17.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-pm@lists.osdl.org, "Kucheria Amit (Nokia-M/Tampere)" <Amit.Kucheria@nokia.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > If there are dependancies inherently linking core1 and core2, cpufreq
> > should already be programming both parts. For example, the SA1100
> > driver programs both CPU and SDRAM controller.  If there isn't any
> > dependancy
> > between them, I don't see the attraction of creating an artificial one
> > in the way suggested for no real purpose.
> > =

> > Things like voltage and frequency are closely tied together, so
> > offering
> > any means of controlling them independantly makes no sense afaics.

> Yet a certain subsystem (for example an onboard camera, in a phone)
> might require a higher voltage when it's active, effectively loosening
> the tight coupling between freq and voltage that the porcessor is
> enforcing.

So... you expect userland to echo high > state before camera can be
used?

I'd rather have kernel automagically up the voltage when /dev/video0
is opened...
							Pavel

-- =

Thanks for all the (sleeping) penguins.
