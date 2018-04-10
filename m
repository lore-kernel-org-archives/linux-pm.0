From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
Date: Tue, 10 Apr 2018 09:55:48 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1804100946060.2058@nanos.tec.linutronix.de>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yuankuiz@codeaurora.org
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, fweisbec@gmail.com, peterz@infradead.org, aulmck@linux.vnet.ibm.com, mingo@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:

> From: John Zhao <yuankuiz@codeaurora.org>
> 
> Variable tick_stopped returned by tick_nohz_tick_stopped
> can have only true / forse values. Since the return type
> of the tick_nohz_tick_stopped is also bool, variable
> tick_stopped nice to have data type as bool in place of int.

The data type is not int. It's part of an integer bitfield and occupies
exactly one bit of storage, while bool has an architecture dependend size
and is at least 1 byte, i.e. 8 bit. So with alignment effects you grew the
size of the data structure and therefore the cache foot print.

This is not about 'nice to have' ....

Thanks,

	tglx
