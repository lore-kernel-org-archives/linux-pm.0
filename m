From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async suspend-resume patch w/ rwsems)
Date: Thu, 10 Dec 2009 20:40:10 +0100
Message-ID: <200912102040.11063.rjw__32173.7874568955$1260474060$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912100018.19723.rjw@sisk.pl>
	<alpine.LFD.2.00.0912091835280.3560@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0912091835280.3560@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 10 December 2009, Linus Torvalds wrote:
> 
> On Thu, 10 Dec 2009, Rafael J. Wysocki wrote:
> > 
> > Completions it is, then.
> 
> What was so hard with the "Try the simple one first" to understand? You 
> had a simpler working patch, why are you making this more complex one 
> without ever having had any problems with the simpler one?

OK, why don't you just say you won't merge anything that doesn't use rwsems
(although you said before that completions would be fine with you)?  That would
make things clear, but also it would mean we gave up handling the off-tree
dependencies in general.

> Btw, your 'atomic_set()' with errors is pure voodoo programming. That's 
> not how atomics work. They do SMP-atomic addition etc, the 'atomic_set()' 
> and 'atomic_read()' things are not in any way more atomic than any other 
> access.
>
> They are meant for racy reads (atomic_read()) and for initializations 
> (atomic_set()), and the way you use them that 'atomic' part is entirely 
> pointless, because it really isn't anything different from an 'int', 
> except that it may be very very expensive on some architectures due to 
> hashed spinlocks etc.
> 
> So stop this overdesign thing. Start simple. If you _ever_ see real 
> problems, that's when you add stuff. As it is, any time you add 
> complexity, you just add bugs.

OK, so that need not be atomic.
 
> > +/**
> > + * dpm_synchronize - Wait for PM callbacks of all devices to complete.
> > + */
> > +static void dpm_synchronize(void)
> > +{
> > +	struct device *dev;
> > +
> > +	async_synchronize_full();
> > +
> > +	mutex_lock(&dpm_list_mtx);
> > +	list_for_each_entry(dev, &dpm_list, power.entry)
> > +		INIT_COMPLETION(dev->power.completion);
> > +	mutex_unlock(&dpm_list_mtx);
> > +}
> 
> And this, for example, is pretty disgusting. Not only is that 
> INIT_COMPLETION purely brought on by the whole problem with completions 
> (they are fundamentally one-shot, but you want to use them over and over

Actually, twice.  However, since I don't want to do any async handling in the
_noirq phases any more, I can get rid of this whole function.  Thanks for
pointing that out to me.

Rafael
