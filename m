From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Mon, 2 Aug 2010 15:52:20 +0200
Message-ID: <201008021552.20505.rjw__12439.2183417969$1280758313$gmane$org@sisk.pl>
References: <20100731175841.GA9367@linux.vnet.ibm.com>
	<20100801154708.19817b75@infradead.org>
	<20100802011006.GS2470@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100802011006.GS2470@linux.vnet.ibm.com>
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
Cc: peterz@infradead.org, swetland@google.com, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday, August 02, 2010, Paul E. McKenney wrote:
> On Sun, Aug 01, 2010 at 03:47:08PM -0700, Arjan van de Ven wrote:
> > On Sun, 1 Aug 2010 12:12:28 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
...
> > Another one: freezing whole cgroups..... we have that today. it
> > actually works quite well.... of course the hard part is the decision
> > what to put in which cgroup, and at what frequency and duration you let
> > cgroups run.
> 
> Indeed, the Android guys seemed to be quite excited by cgroup freezing
> until they thought about the application-classification problem.
> Seems like it should be easy for some types of applications, but I do
> admit that apps can have non-trivial and non-obvious dependencies.

This isn't more difficult than deciding which applications will be allowed to
use wakelocks (in the wakelocks world).  It actually seems to be pretty much
equivalent to me. :-)

> > on the suspend blockers for drivers; the linux device runtime PM is
> > effectively doing the same things; it allows drivers to suspend/resume
> > individually (with a very nice API/programming model I should say) based
> > on usage. And it works on a tree level, so that it's relatively easy
> > to do things like "I want to go to <this magic deep idle state>, but
> > only if <this set of devices is suspended already>". This is obviously
> > an important functionality for all low power devices, ARM or x86. 
> > Suspend blockers had this functionality as part of what it did (they do
> > more obviously) but I'd wager that the current Linux infrastructure is
> > outright nicer. 
> 
> This is what Rafael has been working on?

If you mean the runtime PM framework, then yes, I've been working on it.

> Of course, the Android guys also want to pay attention to which apps
> are running as well as to the state of devices on the system.

In fact the runtime PM framework is also important to Android, because it
can be used in there, for example, to implement the "early suspend" thing
I referred to in one of my previous messages in this thread.

Thanks,
Rafael
