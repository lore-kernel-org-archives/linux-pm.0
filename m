From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 17:29:50 -0700
Message-ID: <20100802002950.GQ2470__49864.0287238688$1280709045$gmane$org@linux.vnet.ibm.com>
References: <Pine.LNX.4.44L0.1008011810300.22928-100000@netrider.rowland.org>
	<866453.87809.qm@web180313.mail.gq1.yahoo.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <866453.87809.qm@web180313.mail.gq1.yahoo.com>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 01, 2010 at 03:38:34PM -0700, David Brownell wrote:
> > > > I should have made a stronger point:
> > "power-aware" is _not_ a good
> > > > term for these applications.=A0
> =

> Strongly disagree.  The whole point is that they
> ARE VERY MUCH AWARE and interact with a power
> policy to achieve goals.
> =

> Like refusing to power down active subsystems,
> or actively powering down inactive ones.
> Q.E.D. ... "aware".

My initial thoughts was along the same lines as yours, but after thinking
about it, the distinction between an application that controls its own
behavior ("power-aware application") and an application that controls the
system's behavior ("PM-driving application") seemed well worth its weight.

							Thanx, Paul
