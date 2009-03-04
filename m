From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [v2 PATCH 4/4] timers: logic to enable timer
	migration.
Date: Wed, 04 Mar 2009 08:33:09 -0800
Message-ID: <1236184389.5937.40.camel__15042.4911793836$1236189199$gmane$org@desktop>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121937.GE9855@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090304121937.GE9855@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: arun@linux.vnet.ibm.com
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-03-04 at 17:49 +0530, Arun R Bharadwaj wrote:
> @@ -649,6 +650,16 @@ __mod_timer(struct timer_list *timer, un
>  
>         new_base = __get_cpu_var(tvec_bases);
>  
> +       current_cpu = smp_processor_id();
> +       preferred_cpu = get_nohz_load_balancer();
> +       if (enable_timer_migration && !tbase_get_pinned(timer->base)
> &&
> +                       idle_cpu(current_cpu) && preferred_cpu != -1)
> {
> +               new_base = per_cpu(tvec_bases, preferred_cpu);
> +               timer_set_base(timer, new_base);
> +               timer->expires = expires;
> +               internal_add_timer(new_base, timer);
> +               goto out_unlock;
> +       }

Are you sure this compiles w/ CONFIG_SMP=n ? It looks like
enable_timer_migration wouldn't exist in that case, but the chunks your
adding in the timer code are still using it.

Daniel
