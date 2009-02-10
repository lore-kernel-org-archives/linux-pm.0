From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Tue, 10 Feb 2009 15:18:28 +0100
Message-ID: <200902101518.29690.rjw@sisk.pl>
References: <20090208210401.GE6369@elf.ucw.cz> <200902100117.37019.rjw@sisk.pl>
	<20090210091314.GA18835@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090210091314.GA18835@atrey.karlin.mff.cuni.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 10 February 2009, Pavel Machek wrote:
> > On Monday 09 February 2009, Pavel Machek wrote:
> > > > On Monday 09 February 2009, Pavel Machek wrote:
> > > > > On Sun 2009-02-08 15:00:38, Arve Hj?nnev?g wrote:
> > > > > > On Sun, Feb 8, 2009 at 1:40 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > > > > > On Sun, 8 Feb 2009, Pavel Machek wrote:
> > > > > > >
> > > > > > >> Well, it is true that wakelocks could be single atomic_t ... but they
> > > > > > >> would make them undebuggable. Ok, wakelock interface sucks. But I
> > > > > > >> believe something like that is neccessary.
> > > > > > >
> > > > > > > krefs don't have name strings for keeping track of who has been
> > > > > > > incrementing or decrementing their counters.  And it's true that krefs
> > > > > > > are nearly undebuggable.  But somehow we've managed to struggle along
> > > > > > > without adding names to krefs.  Why should wakelocks be any different?
> > > > > > 
> > > > > > It sounds like you suggesting that we add another nearly undebuggable interface.
> > > > > > 
> > > > > > Using only a single atomic_t would not allow us to use a wakelock a
> > > > > > switch, or to specify a timeout. You could replace the list in the
> > > > > > implementation with a single atomic_t by adding more state to each
> > > > > > wakelock, but I like my current solution better.
> > > > > 
> > > > > For the record, I agree here. And... if struct wakelock contains char
> > > > > * or not is a very small detail.
> > > > 
> > > > It really isn't, because it means allocating (kernel) memory for each wakelock,
> > > > to store the name.
> > > 
> > > If it can be #ifdef DEBUG or something, I don't see a problem. And it
> > > does not need to allocate anything, most wakelocks will be just
> > > static. So we are talking about 10bytes per wakelock of overhead --
> > > not too bad.
> > 
> > No, we are talking of allocating kernel memory on behalf of user space
> > processes with no apparent limitations.
> 
> Ok, I see now. Yes, letting each process allocated unlimited number of
> wakelocks is indeed bad.
> 
> (But the names for in-kernel users should be ok, right?)

Yes, in principle, but what exactly the benefit would be?

In the kernel we can use rwlock for blocking suspend, for example,
that will be taken for reading by the code paths wanting to prevent suspend
from happening and for writing by the suspend code.

> "Wakelock is a filedescriptor" would solve that...

Sort of.

Still, I don't think there's much point in having more than one "wakelock"
per process.

Moreover, I _guess_ it would be sufficient to have only one such thing for
the entire user space and single daemon and a (user land) library to manage it.

Assume there is a deamon that owns the "wakelock" (I'd prefer to call it
"suspend stop valve" or something like this) and each process wanting the
"lock" to be active has to ask the deamon to hold the lock on its behalf (it
also will have to authenticate itself before the deamon etc.).

That would move the whole thing out of the kernel, I think.

Thanks,
Rafael
