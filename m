From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 3/3] idle: store the idle state index in the struct rq
Date: Thu, 30 Jan 2014 16:31:50 +0100
Message-ID: <20140130153150.GD5002@laptop.programming.kicks-ass.net>
References: <1391090962-15032-1-git-send-email-daniel.lezcano@linaro.org>
 <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1391090962-15032-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: nicolas.pitre@linaro.org, mingo@redhat.com, tglx@linutronix.de, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 30, 2014 at 03:09:22PM +0100, Daniel Lezcano wrote:
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 90aef084..130debf 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -654,6 +654,9 @@ struct rq {
>  #endif
>  
>  	struct sched_avg avg;
> +#ifdef CONFIG_CPU_IDLE
> +	int idle_index;
> +#endif
>  };

So my 'problem' with this is that I've no ff'ing clue what the
idle_index is and what I can do with it.
