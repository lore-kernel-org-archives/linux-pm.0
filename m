From: "Amit Kucheria" <kucheria.amit@gmail.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 16:26:00 +0200
Message-ID: <52d486620703200726i6fab332eoa843eb689cd4cf21@mail.gmail.com>
References: <200703191412.l2JECLsP021909@olwen.urbana.css.mot.com>
	<200703200057.00110.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703200057.00110.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On 3/20/07, David Brownell <david-b@pacbell.net> wrote:
> On Monday 19 March 2007 7:12 am, Scott E. Preece wrote:
> >
> > Could you guys present a clear definition of exactly what you mean by
> > "clock domain" and "power domain"? I can think of several different ways
> > to interpret the phrases, and I'd like to end up with the same meaning
> > that you are arguing from...
>
> A set of devices that use the same power supply or clock are
> in the same "power domain" or "clock domain" (respectively).
>
> The domains will often be hierarchical, e.g. a base clock
> rooting other clocks, derived from it by dividers, PLL,
> or clock gates.
>
> Sometimes domains overlap ... e.g. a controller that needs
> to use one logic level for on-chip logic and another for the
> external interface; or similarly, different clock rates.
>
> Simple chips may not have many domains.  Nowadays I think
> most SOCs have at least a decent selection of clock domains,
> to eliminate the power drain involved in driving transistors
> through clock ticks.  I understand it's more complicated to
> have multiple power domains, but the incentive to shrink the
> leakage current is strong.  (So adding on-chip power domains
> involves tricks to constrain leakage, and not just an ability
> to operate without a given power rail.)

For the sake of completeness, there is also the Voltage domain. A
groups of modules supplied by the same regulator would belong to a
single Voltage domain. Multiple voltage domains allow independent
scaling of voltages to different domains.
--
Amit Kucheria, Nokia
