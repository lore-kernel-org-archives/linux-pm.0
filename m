From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 6/6] freezer: kill unused
	set_freezable_with_signal()
Date: Sun, 4 Sep 2011 20:46:26 +0200
Message-ID: <20110904184626.GA30101__40485.0387400531$1315162239$gmane$org@redhat.com>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-7-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1314988070-12244-7-git-send-email-tj@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On 09/03, Tejun Heo wrote:
>
> This patch removes set_freezable_with_signal() along with
> PF_FREEZER_NOSIG

Great. I never understood PF_FREEZER_NOSIG logic ;)

One question,

> @@ -72,10 +72,6 @@ bool __refrigerator(bool check_kthr_stop)
>  		schedule();
>  	}
>
> -	spin_lock_irq(&current->sighand->siglock);
> -	recalc_sigpending(); /* We sent fake signal, clean it up */
> -	spin_unlock_irq(&current->sighand->siglock);
> -

Why? This recalc_sigpending() makes sense imho. Otherwise the user-space
tasks (almost) always return with TIF_SIGPENDING. May be we can do this
under "if (PF_KTRHREAD)".

For example. Suppose the user-space task does wait_event_freezable()...

Hmm. OTOH, wait_event_freezable() looks wrong anyway... So probably
this doesn't matter. ptrace_stop/get_signal_to_deliver doesn't need
this, probably we do not care about the other callers.

It seems, a lot of get_signal_to_deliver() calles also call
try_to_freeze() for no reason.


So, yes, I am starting to think this change is fine too ;)

Oleg.
