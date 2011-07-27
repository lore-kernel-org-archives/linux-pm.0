From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2] PM: runtime: add might_sleep to PM
	runtime functions
Date: Tue, 26 Jul 2011 17:26:42 -0700
Message-ID: <871uxcr2kd.fsf__7731.87078671089$1311726544$gmane$org@ti.com>
References: <1311627344-8097-1-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1311627344-8097-1-git-send-email-ccross@android.com> (Colin
	Cross's message of "Mon, 25 Jul 2011 13:55:44 -0700")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Colin Cross <ccross@android.com> writes:

> Some of the entry points to pm runtime are not safe to
> call in atomic context unless pm_runtime_irq_safe() has
> been called.  Inspecting the code, it is not immediately
> obvious that the functions sleep at all, as they run
> inside a spin_lock_irqsave, but under some conditions
> they can drop the lock and turn on irqs.
>
> If a driver incorrectly calls the pm_runtime apis, it can
> cause sleeping and irq processing when it expects to stay
> in atomic context.
>
> Add might_sleep_if to all the __pm_runtime_* entry points
> to enforce correct usage.

Minor: s/all/most of/, or something similar since in v2, it doesn't
annotate all of the functions anymore, just the main ones likely to be
(mis)used by drivers.

Other than that, looks good...

> Add pm_runtime_put_sync_autosuspend to the list of
> functions that can be called in atomic context.
>
> Signed-off-by: Colin Cross <ccross@android.com>

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
