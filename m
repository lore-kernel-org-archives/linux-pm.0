From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 10:04:25 -0700
Message-ID: <200703201004.26183.david-b@pacbell.net>
References: <200703191412.l2JECLsP021909@olwen.urbana.css.mot.com>
	<52d486620703200726i6fab332eoa843eb689cd4cf21@mail.gmail.com>
	<45FFF8D6.5050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <45FFF8D6.5050507@gmail.com>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 March 2007 8:08 am, Dmitry Krivoschekov wrote:
> Amit Kucheria wrote:
> > On 3/20/07, David Brownell <david-b@pacbell.net> wrote:
> >> On Monday 19 March 2007 7:12 am, Scott E. Preece wrote:
> >>> Could you guys present a clear definition of exactly what you mean by
> >>> "clock domain" and "power domain"? I can think of several different w=
ays
> >>> to interpret the phrases, and I'd like to end up with the same meaning
> >>> that you are arguing from...
> >> A set of devices that use the same power supply or clock are
> >> in the same "power domain" or "clock domain" (respectively).

Dmitry, would you please stop removing all the blank lines
separating different peoples' replies?  That removal makes
it extremely difficult to follow what's going on in any
thread to which you contribute ... because quoting what you
wrote significantly reduces the readability of the text.


> > For the sake of completeness, there is also the Voltage domain. A
> > groups of modules supplied by the same regulator would belong to a
> > single Voltage domain. Multiple voltage domains allow independent
> > scaling of voltages to different domains.

That's a kind of power domain.  They can be hierarchical in the
same way as clock domains.  A regulator would be analagous to a
PLL, a switch would be analagous to a clock gate, etc.

Example:  a 5V supply derived by charge pump from a 3.3V supply;
a 1.8V supply derived from that same 3.3V supply.  Without 3.3V
neither of the other two voltages exist.  But maybe the 3.3V and
1.8V are separately gated.  Depending on the issue at hand, it can
be important to talk about a one or all of those as the "domain"
of interest.


> If you forget ability of scaling voltage for the domain, does the domain
> become a power domain, IOW is a power domain  the  simplest case of
> voltage domain

Voltage domains are **types of** power domains...

- Dave
