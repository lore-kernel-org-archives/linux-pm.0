From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] avoid using smp_processor_id() in
 preemptible code (nr_iowait_cpu)
Date: Tue, 15 Jun 2010 23:05:41 -0700
Message-ID: <20100615230541.5db5078e__30700.4908369438$1276668321$gmane$org@infradead.org>
References: <20100614140941.GA3581@swordfish.minsk.epam.com>
	<20100614073853.6fa2f91f@infradead.org>
	<20100614145439.GA3448@swordfish.minsk.epam.com>
	<20100614080154.7d6a71fc@infradead.org>
	<20100614151735.GB3448@swordfish.minsk.epam.com>
	<20100614204021.52c50cdc@infradead.org>
	<20100615061927.GA3312@swordfish>
	<20100615072435.5a47d850@infradead.org>
	<20100615145029.GB3967@swordfish.minsk.epam.com>
	<20100615080808.6286448b@infradead.org>
	<20100615161303.GA4102@swordfish.minsk.epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100615161303.GA4102@swordfish.minsk.epam.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Jun 2010 19:13:03 +0300
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> 
> I've changed struct tick_sched to match passed *ts and cpu. Also
> changed "&per_cpu(tick_cpu_sched, cpu)" call to "struct tick_sched
> *tick_get_tick_sched(int cpu)" which we already have.
> 
> But I don't really like this part:
> struct tick_sched *tick_get_tick_sched(int cpu)
> {
> 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
> 	ts->cpu = cpu;
> 	^^^^^^^^^^^^^
> 	return ts;
> }
> 
> Please kindly review.


can we do this bit once, when the ts structure gets initialized?
it's not like the cpu value will ever change...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
