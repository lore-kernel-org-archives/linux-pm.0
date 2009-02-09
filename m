From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Mon, 9 Feb 2009 03:11:58 +0100
Message-ID: <200902090311.58728.u.luckas@road.de>
References: <20090208210401.GE6369@elf.ucw.cz>
	<20090208230335.GU6369@elf.ucw.cz> <200902090131.54248.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902090131.54248.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
Cc: swetland@google.com, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Monday 09 February 2009, Rafael J. Wysocki wrote:
> On Monday 09 February 2009, Pavel Machek wrote:
> > On Sun 2009-02-08 15:00:38, Arve Hj?nnev?g wrote:
> > > On Sun, Feb 8, 2009 at 1:40 PM, Alan Stern <stern@rowland.harvard.edu> 
wrote:
> > > > On Sun, 8 Feb 2009, Pavel Machek wrote:
> > > >> Well, it is true that wakelocks could be single atomic_t ... but
> > > >> they would make them undebuggable. Ok, wakelock interface sucks. But
> > > >> I believe something like that is neccessary.
> > > >
> > > > krefs don't have name strings for keeping track of who has been
> > > > incrementing or decrementing their counters.  And it's true that
> > > > krefs are nearly undebuggable.  But somehow we've managed to struggle
> > > > along without adding names to krefs.  Why should wakelocks be any
> > > > different?
> > >
> > > It sounds like you suggesting that we add another nearly undebuggable
> > > interface.
> > >
> > > Using only a single atomic_t would not allow us to use a wakelock a
> > > switch, or to specify a timeout. You could replace the list in the
> > > implementation with a single atomic_t by adding more state to each
> > > wakelock, but I like my current solution better.
> >
> > For the record, I agree here. And... if struct wakelock contains char
> > * or not is a very small detail.
>
> It really isn't, because it means allocating (kernel) memory for each
> wakelock, to store the name.
>
> > If wakelocks can be locked from userspace is _not_ a detail; and if
> > they can we do need the names.
>
> Do we?  What about one lock per process and using process names?
> Or better process IDs or even thread IDs?
>
I like that idea. A process should be able to hold _one_ wake lock (which 
would be released if the process dies). If it turns out, that more then on 
lock is convenient for a process, a library can easily agregate these locks. 
If the last userspace wake lock is released, the library code can relase the 
processes kernel wake lock.

> And why exactly do we want _every_ user space process to be able to prevent
> suspend from happening?
>
I don't understand your question. Which porcesses do you propose can veto 
suspend? Which processes can't?

> Moreover, why do we want user space processes to be able to take multiple
> wakelocks?  What's the purpose of having more than one wakelock per
> process?
>
> Is there a limit on the number of wakelocks a user space process can create
> and if not, then why?
>
Agreed as stated above. We should agree right now to switch to one lock per 
process. Arve?

Uli
