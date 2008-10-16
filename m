From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/4] timers: new framework for
 identifying cpu-pinned timers
Date: Thu, 16 Oct 2008 16:03:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0810161601410.6848__39720.3180277303$1224166104$gmane$org@apollo>
References: <20081016114830.GC7641@linux.vnet.ibm.com>
	<1224157982.28131.49.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1224157982.28131.49.camel@twins>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, 16 Oct 2008, Peter Zijlstra wrote:
> On Thu, 2008-10-16 at 17:18 +0530, Arun R Bharadwaj wrote:
> > This patch creates the necessary framework for identifying cpu-pinned
> > regular timers and hrtimers.
> > 
> > For regular timers a new flag called TBASE_PINNED_FLAG is created.
> > Since the last 3 bits of the tvec_base is guaranteed to be 0, and
> > since the last bit is being used to indicate deferrable timers, I'm
> > using the second last bit to indicate cpu-pinned regular timers.
> > The implementation of functions to manage the TBASE_PINNED_FLAG is
> > similar to those which manage the TBASE_DEFERRABLE_FLAG.
> > 
> > For hrtimers, there is no clear interface to queue a hrtimer as a
> > per-cpu hrtimer. But there are instances where, if an hrtimer is queued
> > on a particular cpu, it expects to run on the same cpu.
> > The hrtimer hrtick_timer is one such example.
> > 
> > So, in this regard, I've created a new interface called
> > hrtimer_start_pinned which can be used to queue cpu-pinned hrtimer.
> > In the hrtimer structure, there is a variable called *state* which
> > is used to indicate the state of a hrtimer - inactive, enqueued,
> > callback function running and callback pending. Currently, since only
> > 5 bits are being used in the state variable, I've used the 6th bit
> > to represent the cpu-pinned state of the hrtimer
> > 
> > 
> > Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
> 
> Thomas recently created HRTIMER_CB_IRQSAFE_PERCPU which serves this
> purpose to close some cpu-hotplug timer races.
> 
> > @@ -97,6 +96,7 @@ enum hrtimer_cb_mode {
> >  #define HRTIMER_STATE_CALLBACK	0x02
> >  #define HRTIMER_STATE_PENDING	0x04
> >  #define HRTIMER_STATE_MIGRATE	0x08
> > +#define HRTIMER_CPU_PINNED	0X16
> 
> Hehe, may I suggest 0x10 :-)

Well, either way. Adding this to the state is horrible. The state
tracking is complex enough already, we do not need some extra non
state information for this.

Thanks,

	tglx
