From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Sun, 18 Mar 2007 21:04:26 -0700
Message-ID: <200703182104.27555.david-b@pacbell.net>
References: <44ECFF94.3030506@gmail.com>
	<200703161103.12333.david-b@pacbell.net>
	<45FDA040.4020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <45FDA040.4020502@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sunday 18 March 2007 1:25 pm, Dmitry Krivoschekov wrote:
> =

> For me, there is a point that seems debatable already at the starting sta=
ge:
> =

> > The goal of this parameter framework is to expose the resources in  a  =

> > way that allows other s/w (governors, policy mangers, etc) to control  =

> > the resources while keeping the system operational.  One of the main  =

> > requirements in our thinking is that we want this layer to represent  =

> > the h/w and not include policy or decision making.  Meaning the =

> > software using the parameter framework would be responsible for  =

> > deciding the appropriate value for the parameters.   =

> =

> =

> Sometimes it's quite reasonable to make decisions (or policy)
> at the low level, without exposing events to higher layers,

Of course.  Any layer can incorporate a degree of policy.

It's only when that's badly done -- or the problem is so complex
that multiple policies need to be supported -- that you need to
pull out that old "mechanism not policy" chestnut, and support
some kind of policy switching mechanism (governors, userspace
agents, etc) for different application domains.


> e.g. turning a clock off when reference counter gets zero, this is
> what OMAP's clock framework currently does.

There are no choices to be made in that layer; it's no more "policy"
than following the laws of arithmetic is "policy".  Software clock
gating is what the clock framework is defined as doing; there's
nothing OMAP-specific about that.

The interesting bit for OMAP is that clock gating will often be done
in hardware, not just in software.  There are other low-power SOC
designs that do such things, but the ones I'm most aware of are for
microcontrollers (MSP430, picoAVR, etc) that can't run Linux.

- Dave
