From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Thu, 17 Dec 2009 03:01:44 -0800
Message-ID: <20091217030144.186b1b19__18674.0508572713$1261047648$gmane$org@infradead.org>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091214161922.6f252492@infradead.org>
	<4352991a0912141636t35a96c14o5fd4b9e152e6e681@mail.gmail.com>
	<20091214170616.59fc163f@infradead.org>
	<4352991a0912151215o33524766p830e7fcbf9f1fc87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4352991a0912151215o33524766p830e7fcbf9f1fc87@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: linux-pm@lists.linux-foundation.org, Taliver Heath <taliver@google.com>, Michael Rubin <mrubin@google.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Dec 2009 12:15:30 -0800
Salman Qazi <sqazi@google.com> wrote:

> > (having the memory power in a machine suddenly be half or less is a
> > huge step in power, for something, the alignment itself, that does
> > not cost much if any extra performance over randomly distributed
> > idle insertions)
> 
> I think there is a difference in goals here.  Our goal is to free up
> power from one machine, so that it can be used elsewhere.  This means
> that any power that we save has to be predictably saved. 

unless your population of machines is big enough, and you get "close
enough" in terms of predictability.

> We have
> models that map between CPU time and power usage, that have to account
> for the worst case.

the delta between worst case and average/typical even for cpu time <->
power usage is enormous (2x to 3x would not surprise me)... adding
memory to that equation does not change the fundamentals much.



> Having said that, energy savings is a worthy goal by itself.  But, we
> have to make sure to balance it with performance.

I would think the people who pay the power bill at the end of the month
would notice a 10% reduction ;-)


> > as long as the tentative portion of the idle time gets injected at
> > the same time.. I suspect there can be a decent balance here where
> > most of the time we get the full CPU *and* memory savings, while we
> > degrade gracefully for the case where we get increasingly more
> > interactive activity.
> 
> Let me rephrase what you just said to verify that I understand you
> correctly:  we should align the enforcement intervals across CPUs and
> thereby eagerly inject over the same time period across multiple CPUs.

we should at least try hard to do this. it's ok to not always get it, 
but when we can we should.

>  If there is no interactive workload then we would get maximal CPU and
> memory savings.  If there are interactive tasks, then we just let them
> run like we would in the eager injection in original design.

the interactive tasks would indeed run "normal"; but since they are
interactive that is supposedly "only sporadic".
