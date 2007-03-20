From: David Brownell <david-b@pacbell.net>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 00:56:59 -0700
Message-ID: <200703200057.00110.david-b@pacbell.net>
References: <200703191412.l2JECLsP021909@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703191412.l2JECLsP021909@olwen.urbana.css.mot.com>
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
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz, linux@dominikbrodowski.net
List-Id: linux-pm@vger.kernel.org

On Monday 19 March 2007 7:12 am, Scott E. Preece wrote:
> =

> Could you guys present a clear definition of exactly what you mean by
> "clock domain" and "power domain"? I can think of several different ways
> to interpret the phrases, and I'd like to end up with the same meaning
> that you are arguing from...

A set of devices that use the same power supply or clock are
in the same "power domain" or "clock domain" (respectively).

The domains will often be hierarchical, e.g. a base clock
rooting other clocks, derived from it by dividers, PLL,
or clock gates.

Sometimes domains overlap ... e.g. a controller that needs
to use one logic level for on-chip logic and another for the
external interface; or similarly, different clock rates.

Simple chips may not have many domains.  Nowadays I think
most SOCs have at least a decent selection of clock domains,
to eliminate the power drain involved in driving transistors
through clock ticks.  I understand it's more complicated to
have multiple power domains, but the incentive to shrink the
leakage current is strong.  (So adding on-chip power domains
involves tricks to constrain leakage, and not just an ability
to operate without a given power rail.)

I think that captures the basics... from a software perspective.
I'm sure a hardware guy could provide a more advanced course.

- Dave
