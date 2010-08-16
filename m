From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when
	interrupts are disabled
Date: Mon, 16 Aug 2010 23:18:03 +0200
Message-ID: <201008162318.03923.rjw__2406.99997307292$1281993598$gmane$org@sisk.pl>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 10, 2010, Kevin Hilman wrote:
> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts will likely be disabled when
> runtime PM for these devices is initiated.
> 
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled.  However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, for
> example:
> 
> pm_runtime_put_sync()

Please don't use that from interrupt context.  There's pm_runtime_put()
exactly for this purpose that puts the _idle() call into a workqueue.

>     __pm_runtime_put()
>         pm_runtime_idle()
>             spin_lock_irq()
>             __pm_runtime_idle()
>                 spin_unlock_irq()   <--- interrupts unconditionally enabled

That's because __pm_runtime_idle() has to be called from process context.

>                 dev->bus->pm->runtime_idle()
>                 spin_lock_irq()
>              spin_unlock_irq()

Thanks,
Rafael
