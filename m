From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC] lp_events: an lternitive to suspend blocker
 user mode and kernel API
Date: Mon, 31 May 2010 15:43:55 -0700
Message-ID: <20100531224355.GD31155__17868.7537125827$1275345880$gmane$org@gvim.org>
References: <20100530200409.GA21632@gvim.org>
	<20100531095753.4c174f2d@notabene.brown>
	<20100531084356.272f3e1a@schatten.dmk.lab>
	<20100531100545.658a35b7@schatten.dmk.lab>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100531100545.658a35b7@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: mark.gross@intel.com, 640e9920@gmail.com, markgross@thegnar.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, May 31, 2010 at 10:05:45AM +0200, Florian Mickler wrote:
> On Mon, 31 May 2010 08:43:56 +0200
> Florian Mickler <florian@mickler.org> wrote:
> 
> > On Mon, 31 May 2010 09:57:53 +1000
> > Neil Brown <neilb@suse.de> wrote:
> > 
> > > 2/ Rather than tracking wake-events from the hardware up through possibly
> > >    several kernel modules, you go directly from hardware to user-space so each
> > >    event is potentially presented to user-space twice: once as a "wake up
> > >    from low power state" event and once following the normal path (maybe a
> > >    key-press event, maybe a serial-port event, maybe a network receive event).
> > >    I can see that this is a very tempting approach.  It allows all those
> > >    intermediate modules to remain unchanged and that is good.
> > >    However it isn't clear to me that this would be easy for user-space to use
> > >    correctly.
> > >    When an lpe event arrived it would need to wait around for the real event
> > >    to arrive and then process that.  I probably wouldn't wait long, but it
> > >    would be an indeterminate wait, and it might not be  trivial to determine
> > >    if all events that would cause a wake-up have been consumed as a direct
> > >    mapping from lpe event to normal event may not always be possible.
> > >    Maybe this is more of a theoretical problem and in practice it would be
> > >    easy to get it right - I don't have enough concrete experience to be sure.
> > > 
> > >    So: I like the idea of leaving the intermediate layers unchanged, but I'm
> > >    not convinced it would work.
> > 
> > To add to this: Is it a correct assumption
> > that all wake-up events that leave a driver trickle eventually up to
> > userspace?
> > 
> > I think splitting the actual driver product (i.e. keypress or whatever)
> > of a wake-up-event and it's corresponding wake-lock is not possible.
> > Because you would have to _somehow_ map the block back to the product
> > when you consume the product. 
> > 
> > If you want to abstract the blocking from the kernel-code you probably
> > have to introduce an abstract "driver-product" entity where you can do
> > all your blocking associated with the product but hidden from the code
> > that uses the product. (Which I don't think is feasible, because it
> > increases overhead)
> > 
> > Or am I on the wrong track here? 
> 
> I just realized, that you can cancel lpe_blocks via delete_lpe_block(),
> so this is not an issue at all.
> They can be used just like suspend blockers. 
> 
> Also the mapping of lpe_block to "wake event" is the same problem as
> with the suspend_blockers... 
> 
> So I don't think this is a bad idea after all. It decouples the
> suspend_blockers from "suspend" quite nicely. 
> Although it still is only "block" or "no block" and not, as was
> suggested some sort of more fine grained requirement definition.

I attempted to add level's of blocking but I honestly don't see a use
for the levels at the moment.  I'm sure there is some better
genralization possible.

--mgross

 
> Cheers,
> Flo
