From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch V2 08/10] timer: Implement the hierarchical pull model
Date: Wed, 19 Apr 2017 10:52:58 +0200
Message-ID: <20170419085258.jlfwmhure5anayff@hirez.programming.kicks-ass.net>
References: <20170418111102.490432548@linutronix.de>
 <20170418111401.016420305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170418111401.016420305@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Eric Dumazet <edumazet@google.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Frederic Weisbecker <fweisbec@gmail.com>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 18, 2017 at 01:11:10PM +0200, Thomas Gleixner wrote:
> +		raw_spin_lock_nested(&parent->lock, parent->level);
> +	raw_spin_lock_nested(&group->lock, group->level);
> +	raw_spin_lock_nested(&group->lock, group->level);

An not a comment on the locking order and why this annotation isn't
borken.
