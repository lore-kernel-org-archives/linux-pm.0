From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 18:11:48 -0700
Message-ID: <20100802011148.GT2470__40915.063073817$1280711559$gmane$org@linux.vnet.ibm.com>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<1280704593.25620.48.camel@mulgrave.site>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1280704593.25620.48.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Aug 01, 2010 at 06:16:33PM -0500, James Bottomley wrote:
> On Sat, 2010-07-31 at 22:48 -0700, Paul E. McKenney wrote:
> > On Sat, Jul 31, 2010 at 09:52:14PM -0700, Arjan van de Ven wrote:
> > > On Sat, 31 Jul 2010 10:58:42 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > o	"Power-aware application" are applications that are permitted
> > > > 	to acquire suspend blockers on Android.  Verion 8 of the
> > > > 	suspend-blocker patch seems to use group permissions to
> > > > determine which applications are classified as power aware.
> > > > 
> > > > 	More generally, power-aware applications seem to be those that
> > > > 	have permission to exert some control over the system's
> > > > 	power state.
> > > 
> > > I don't like the term "Power aware application". An application is well
> > > behaved or it isn't. "aware" has nothing to do with it.
> > 
> > Applications are often complex enough to be aware of some things, naive
> > about others, well behaved in some ways, and ill-behaved in others.
> > This has been the case for some decades now, so it should not come as
> > a surprise.
> > 
> > I am of course open to suggestions for alternatives to the term "power
> > aware application", but most definitely not to obfuscating the difference
> > between power awareness (or whatever name one wishes to call it) and
> > the overall quality of the application, whatever "quality" might mean
> > in a given context.
> 
> So the reason everyone's having trouble with this definition is that it
> actually conflates two separate axes of power management.
> 
> There are good and bad applications in the power sense ... burns less vs
> burns more.
> 
> And there are user mandated vs user optional processes ...
> necessary/wanted vs unnecessary/unwanted.
> 
> What android actually does is reward well written applications because
> they "just work" and they don't have to be power aware at all ...
> they're usually event driven and split into the android
> provider/consumer model.
> 
> Badly written applications that are not suspend block aware get shut
> down (by system suspend) when the screen turns off, so they're also
> power/suspend unaware.
> 
> Applications that want to present the user with a choice in android are
> power/suspend aware because the only way they get to present the choice
> is via suspend blockers.
> 
> The "power problem" always devolves to resolving a set of choices around
> a given set of control axes.  The problem is that the set of control
> axes isn't unique and doesn't have a well agreed upon selection.  This
> makes it hard to make definitive terminology because you have to pick
> the set of axes (implicitly or explicitly) before defining terms ...

That does seem to be about the size of it...  :-/

							Thanx, Paul
