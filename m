From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 15:45:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1008011542100.20420-100000__34240.6377116733$1280692035$gmane$org@netrider.rowland.org>
References: <20100801054816.GI2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100801054816.GI2470@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 31 Jul 2010, Paul E. McKenney wrote:

> > > o	"Power-aware application" are applications that are permitted
> > > 	to acquire suspend blockers on Android.  Verion 8 of the
> > > 	suspend-blocker patch seems to use group permissions to
> > > determine which applications are classified as power aware.
> > > 
> > > 	More generally, power-aware applications seem to be those that
> > > 	have permission to exert some control over the system's
> > > 	power state.
> > 
> > I don't like the term "Power aware application". An application is well
> > behaved or it isn't. "aware" has nothing to do with it.
> 
> Applications are often complex enough to be aware of some things, naive
> about others, well behaved in some ways, and ill-behaved in others.
> This has been the case for some decades now, so it should not come as
> a surprise.
> 
> I am of course open to suggestions for alternatives to the term "power
> aware application", but most definitely not to obfuscating the difference
> between power awareness (or whatever name one wishes to call it) and
> the overall quality of the application, whatever "quality" might mean
> in a given context.

This is a false dichotomy.  The two of you have fallen into a logical 
trap.  I forget the word used to describe an argument based on a 
fundamental misunderstanding, but it applies here.

The term "power-aware" has _nothing_ to do with how well behaved an
application is, or its quality (in any sense).  Go back and re-read the
definition; you'll see what I mean.

Alan Stern
