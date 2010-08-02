From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Sun, 1 Aug 2010 21:05:48 -0700
Message-ID: <20100801210548.23f77ff6__43588.540927931$1280722017$gmane$org@infradead.org>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100731215214.2543c07e@infradead.org>
	<20100801054816.GI2470@linux.vnet.ibm.com>
	<20100731230101.7cc1d8c7@infradead.org>
	<20100801191228.GL2470@linux.vnet.ibm.com>
	<20100801204026.GH31324@thunk.org>
	<20100802030304.GU2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802030304.GU2470@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk
List-Id: linux-pm@vger.kernel.org

On Sun, 1 Aug 2010 20:03:04 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > on application programmers to do the right thing.  That's not to
> > say that we shouldn't give up on trying to influence application
> > programmers --- but relying on that as the only strategy seems to
> > depart from the path of wisdom.
> 
> Unless someone can reliably automate whacking the moles, history is
> not on the side of the mole-whackers.  I won't say that such
> automation is impossible, but only because of all the "impossible"
> things in my lifetime that have turned out to be possible.

we have a few things going for us here though

1) It's easy to programatically detect the problems
  1a) so programmers can detect issues before they ship software,
  unlike the fsync() thing Ted mentions. History is showing this is at
  least relatively successful in open source, but not with Adobe's
  proprietary software such as Flash
2) Users can be made aware of what the bad guys are
3) The business models of many of the mobile apps gives programmers a
   strong incentive to ship well behaving. The moment your first and
   second review of your app read "this app was identified as reducing
   battery life a lot"... your revenues will not go beyond the $1.98..
   ... assuming these first two guys didn't refund their app.

Since we can detect who the bad guys are, we can also automatically
quarantine them for the common cases..... which is good news.


I'm a little worried that this whole "I need to block suspend" is
temporary. Yes today there is silicon from ARM and Intel where suspend
is a heavy operation, yet at the same time it's not all THAT heavy
anymore.... at least on the Intel side it's good enough to use pretty
much all the time (when the screen is off for now, but that's a memory
controller issue more than anything else). I'm pretty sure the ARM guys
will not be far behind.
