From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 0/3] Runtime PM support for named power states
Date: Wed, 5 Oct 2005 16:24:39 -0700
Message-ID: <200510051624.40033.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0509301536560.4470-100000@iolanthe.rowland.org>
	<20051005060435.628B0EA5EC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
	<20051005074445.GB3306@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48770062252884772=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051005074445.GB3306@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============48770062252884772==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 05 October 2005 12:44 am, Adam Belay wrote:
> On Tue, Oct 04, 2005 at 11:04:35PM -0700, David Brownell wrote: 
> > 
> > The PM core should just tell drivers to become compatible with some
> > new constraint (like ACPI S3, generally implying devices in PCI D2
> > or D3; while S1 doesn't) ... and not worry about whether that involves
> > a state change or not.
> > 
> > Maybe they're already _in_ that state for example.
> 
> Yeah, the thought occurred to me.  One way of approaching the problem is to
> have the PM core use logical states such as the following:
> 
> 1.) ON
> 2.) FREEZE
> 3.) SUSPEND
> 
> others?
> 
> This is similar to our current implementation.

Which is a problem, as I've described before.  The logical states
must be system-specific.  Some systems have more states than just
those three ... and in particular, the states have ** SOLID **
and ** PRECISE ** definitions.  Unlike those three.

At the risk of sounding like a broken record, I'll give the
same example I've given before:  some states may not support
particular clocks, like the 48 MHz USB clock.  So the driver
needs to know which ** PRECISE ** system-specific state is
being entered ... so it can turn off the clock if need be.

- Dave

--===============48770062252884772==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48770062252884772==--
