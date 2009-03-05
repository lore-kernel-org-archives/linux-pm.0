From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [v2 PATCH 4/4] timers: logic to enable timer
	migration.
Date: Thu, 5 Mar 2009 16:34:36 +0100
Message-ID: <20090305153436.GA3939__33020.2511199333$1236268282$gmane$org@redhat.com>
References: <20090304121249.GA9855@linux.vnet.ibm.com>
	<20090304121937.GE9855@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, mingo@elte.hu, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, tglx@linutronix.de, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On 03/04, Arun R Bharadwaj wrote:
>
> @@ -628,7 +629,7 @@ __mod_timer(struct timer_list *timer, un
>  {
>  	struct tvec_base *base, *new_base;
>  	unsigned long flags;
> -	int ret;
> +	int ret, current_cpu, preferred_cpu;
>  
>  	ret = 0;
>  
> @@ -649,6 +650,16 @@ __mod_timer(struct timer_list *timer, un
>  
>  	new_base = __get_cpu_var(tvec_bases);
>  
> +	current_cpu = smp_processor_id();
> +	preferred_cpu = get_nohz_load_balancer();
> +	if (enable_timer_migration && !tbase_get_pinned(timer->base) &&
> +			idle_cpu(current_cpu) && preferred_cpu != -1) {
> +		new_base = per_cpu(tvec_bases, preferred_cpu);
> +		timer_set_base(timer, new_base);
> +		timer->expires = expires;
> +		internal_add_timer(new_base, timer);
> +		goto out_unlock;

I didn't read the whole series, but this looks very wrong.

We can not do internal_add_timer/etc until we lock new_base, please
look how the current code does this under "if (base != new_base)".

I think you can do something like

	-	new_base = __get_cpu_var(tvec_bases);
	+
	+	new_cpu = smp_processor_id();
	+	if (enable_timer_migration && ....)
	+		new_cpu = preferred_cpu;
	+
	+	new_base = per_cpu(tvec_bases, new_cpu);

		if (base != new_base) {

Oleg.
