From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] PM: runtime PM + idle: allow usage when
	interrupts are disabled
Date: Sat, 14 Aug 2010 11:38:10 +0800
Message-ID: <AANLkTi=wzuGw6=Sg31F1h1=fyYAObboFUp6vr0c1-+1c__35997.9106499397$1281757147$gmane$org@mail.gmail.com>
References: <1281459261-30829-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

2010/8/11 Kevin Hilman <khilman@deeprootsystems.com>:
> When using runtime PM in combination with CPUidle, the runtime PM
> transtions of some devices may be triggered during the idle path.
> Late in the idle sequence, interrupts will likely be disabled when
> runtime PM for these devices is initiated.
>
> Currently, the runtime PM core assumes methods are called with
> interrupts enabled. =A0However, if it is called with interrupts
> disabled, the internal locking unconditionally enables interrupts, for
> example:
>
> pm_runtime_put_sync()

It is always called from process context,  why do you have to disable irq
before calling pm_runtime_put_sync?

> =A0 =A0__pm_runtime_put()
> =A0 =A0 =A0 =A0pm_runtime_idle()
> =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq()
> =A0 =A0 =A0 =A0 =A0 =A0__pm_runtime_idle()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq() =A0 <--- interrupts unco=
nditionally enabled
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->bus->pm->runtime_idle()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq()
> =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq()
>
> Unconditionally enabling interrupts late in the idle sequence is not
> desired behavior. =A0To fix, use the save/restore versions of the
> spinlock API.
>
> Reported-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> RFC: I'm not crazy about having the 'flags' in struct dev_pm_info, but
> since the locks are taken and released in separate functions, this
> seems better than changing the function APIs to pass around the flags.
>

thanks,

-- =

Lei Ming
