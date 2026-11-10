Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337211;
	b=DhyTOSAD0h1bLIZKd+gZ8VDkEC985aRupGz3ZVMBYroDkWqOSlCX/Hf0HOqOsgYvuyvq
	 /vprDJqUU6tnsbdJJjorQMMdZaAZd1YFhHiaHuB0FYpvzaq/IPBuiwiAPTdWGxlXyylG1
	 4NsTLxxph4aKZGF+yE7Wh8ThSQae/C2Vh5SG4Nex5Dtx1yrAiB5JcQMAaOuDf4k2lwGTK
	 kXrB71IN4QZsTgVTsEjFdHggZKl+jBXpeIJgYveuS4iXw1lP1ofrULQDmpAXpAyZydXmJ
	 SdyYrhnrKK4KEb8W3oNbIoS5XLRtlMi294JIET4PdPKkH8jzjlGl8ycAFsX3r3ke/iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337211;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=K5+erudIzJpf7Ts53ZdTICO8NxYynyJS81EYgDK6NPg=;
	b=nMZJtAi7ITFmAHng/2CyE4LvNl9Dsvd+jNolTO3IlsOSCDN8q/Ra25+bud9tZ+6g6Vcp
	 fJnZrkT1scP+nFzyHZxAD/oCSJqEcvqLGJyMHoR4TQRnruJETmJqt/WOEtd9sOtxZAi2B
	 C4xAd/B/U3IApg+YkwPULkTrT3qy3Iq02GQiYlkPUS9iOrurWrVpXa6MAvc57tRpCjkp1
	 k9eW146ADUMAkHXlMFel+xmkbHQXcz+KtTdx+w9alDg9R+jZLOFsPXeW8/oo6skgtuT/N
	 tZYnrT5oErChCBhh4hcxPOvzdi51AEtqYQieQIcKaqcZwajbSikAmbJC9E8vtoSCkWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPcMKKty;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E5606A31C
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPcMKKty
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4194D1F008A7
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337211;
	bh=K5+erudIzJpf7Ts53ZdTICO8NxYynyJS81EYgDK6NPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lPcMKKty49XABM84dnahkbc/2bG6CA4f4RxuV/VtKT9Nkn3ZZtzWtRbPr0Qx7yqbL
	 zRYh4LawIK+QJ1BWNbRvY4jluiCH5KdTQDHh2HEnWRe+WI/tfoPak+kj/ZwZXUkdfx
	 VMKqalbPHg80aK4HE1/rZONGjgwESHfJeR8NebHPMctOoIN9sikKAY7XGKtrvoqRNy
	 zRq9H/P0DklCXfWKZQcaCtkeFWuCJ5FOCF4vN0bgqZ+J0XbIRfL7HBhOVWa6HWgIMh
	 5tpXOnooODeGahOc/onUFySsPKpLZrjomUyoZPPx2eUASVOPNqqUPMo/uYaqrw3F0o
	 1V+B9KjmgGa8w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3acd239776cso17674911fa.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 11:00:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEUxqP6fpHQYpWmCt66DslCi0bWpZIIyiYD183g28Vb9BqOf8pCDI9jxj/t/WwB/rEburbt58Cwqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8z5iJdOmuwbGWaWLc4ZtQCr2ZiMT3k0MJIrIe6vhSygq229tJq
	KRxhgoFRXGtS9sGLxzrTALomPNvAiTNyp+FE7J+ADyCQkFfF71m7H9GLQ3QoUPuHeo9dgwxn371
	+0ZjNiBiFlnm14MmAPKyTSPtOMtIJirc=
X-Received: by 2002:a05:651c:1612:b0:3a9:f130:6ede with SMTP id
 38308e7fff4ca-3ae096283abmr7108841fa.13.1794337209565; Tue, 10 Nov 2026
 11:00:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-clk-leak-v2-0-d044cf0c3f1d@oss.qualcomm.com> <20261110-clk-leak-v2-1-d044cf0c3f1d@oss.qualcomm.com>
In-Reply-To: <20261110-clk-leak-v2-1-d044cf0c3f1d@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 10 Nov 2026 19:59:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g22FY2wpwu5rE-3011eaF7_1-DLp_SDRPND23E6N8Zgw@mail.gmail.com>
X-Gm-Features: AclHuK_JzRVCkei5gC4BO5KaxRCN5T5sp4BlAtsz7w_7yWe-w_KkWdC2bQ37KIM
Message-ID: <CAJZ5v0g22FY2wpwu5rE-3011eaF7_1-DLp_SDRPND23E6N8Zgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: clk: Derive PM clock locking from the device's
 IRQ safety
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Daniel J Blueman <daniel@quora.org>, 
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So can people sending the assorted clock_ops.c fixes look at the
others' changes and provide feedback?

On Tue, Nov 10, 2026 at 1:01=E2=80=AFPM Loic Poulain
<loic.poulain@oss.qualcomm.com> wrote:
>
> pm_clk_suspend() and pm_clk_resume() take the pm_subsys_data spinlock
> when every clock in the list can be gated atomically and the mutex
> otherwise. That is tracked by a clock_op_might_sleep count.
>
> Whether the operations may sleep is a property of the device rather
> than of the clocks though, runtime PM only invokes the callbacks with
> interrupts disabled for an IRQ-safe device.
>
> Use pm_runtime_is_irq_safe() and drop the count, the retry loop and
> the caller name argument. Devices that are not IRQ-safe now always
> take the mutex, which is legal as they only suspend in process context.
>
> The count also rejected an IRQ-safe device holding a clock that is
> enabled when prepared, with -EPERM. __pm_clk_enable() now does that
> instead.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/base/power/clock_ops.c | 135 +++++++++++++++++++----------------=
------
>  include/linux/pm.h             |   1 -
>  2 files changed, 62 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_op=
s.c
> index 3b8ba27802a800bac29abd8e21756ccdb0f2a716..6f66e11a12428fb718abca197=
f5519b1ee21ff90 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -40,14 +40,13 @@ struct pm_clock_entry {
>   * pm_clk_list_lock - ensure exclusive access for modifying the PM clock
>   *                   entry list.
>   * @psd: pm_subsys_data instance corresponding to the PM clock entry lis=
t
> - *      and clk_op_might_sleep count to be modified.
> + *      to be modified.
>   *
> - * Get exclusive access before modifying the PM clock entry list and the
> - * clock_op_might_sleep count to guard against concurrent modifications.
> - * This also protects against a concurrent clock_op_might_sleep and PM c=
lock
> - * entry list usage in pm_clk_suspend()/pm_clk_resume() that may or may =
not
> - * happen in atomic context, hence both the mutex and the spinlock must =
be
> - * taken here.
> + * Get exclusive access before modifying the PM clock entry list to guar=
d
> + * against concurrent modifications. This also protects against a concur=
rent
> + * PM clock entry list usage in pm_clk_suspend()/pm_clk_resume() that ma=
y or
> + * may not happen in atomic context, hence both the mutex and the spinlo=
ck
> + * must be taken here.
>   */
>  static void pm_clk_list_lock(struct pm_subsys_data *psd)
>         __acquires(&psd->lock)
> @@ -70,72 +69,51 @@ static void pm_clk_list_unlock(struct pm_subsys_data =
*psd)
>
>  /**
>   * pm_clk_op_lock - ensure exclusive access for performing clock operati=
ons.
> + * @dev: device the clock operations are performed for.
>   * @psd: pm_subsys_data instance corresponding to the PM clock entry lis=
t
> - *      and clk_op_might_sleep count being used.
> + *      being used.
>   * @flags: stored irq flags.
> - * @fn: string for the caller function's name.
>   *
> - * This is used by pm_clk_suspend() and pm_clk_resume() to guard
> - * against concurrent modifications to the clock entry list and the
> - * clock_op_might_sleep count. If clock_op_might_sleep is !=3D 0 then
> - * only the mutex can be locked and those functions can only be used in
> - * non atomic context. If clock_op_might_sleep =3D=3D 0 then these funct=
ions
> - * may be used in any context and only the spinlock can be locked.
> - * Returns -EINVAL if called in atomic context when clock ops might slee=
p.
> + * This is used by pm_clk_suspend() and pm_clk_resume() to guard against
> + * concurrent modifications to the clock entry list.
> + *
> + * An IRQ-safe device may runtime suspend and resume with interrupts
> + * disabled, so for such a device only the spinlock can be taken and the
> + * clock operations are restricted to the atomic clk_enable()/clk_disabl=
e().
> + * Any other device is suspended and resumed in process context only, so
> + * the mutex is taken instead and the clock operations are allowed to
> + * sleep.
>   */
> -static int pm_clk_op_lock(struct pm_subsys_data *psd, unsigned long *fla=
gs,
> -                         const char *fn)
> +static void pm_clk_op_lock(struct device *dev, struct pm_subsys_data *ps=
d,
> +                          unsigned long *flags)
>         /* sparse annotations don't work here as exit state isn't static =
*/
>  {
> -       bool atomic_context =3D in_atomic() || irqs_disabled();
> -
> -try_again:
> -       spin_lock_irqsave(&psd->lock, *flags);
> -       if (!psd->clock_op_might_sleep) {
> +       if (pm_runtime_is_irq_safe(dev)) {
> +               spin_lock_irqsave(&psd->lock, *flags);
>                 /* the __release is there to work around sparse limitatio=
ns */
>                 __release(&psd->lock);
> -               return 0;
> -       }
> -
> -       /* bail out if in atomic context */
> -       if (atomic_context) {
> -               pr_err("%s: atomic context with clock_ops_might_sleep =3D=
 %d",
> -                      fn, psd->clock_op_might_sleep);
> -               spin_unlock_irqrestore(&psd->lock, *flags);
> -               might_sleep();
> -               return -EPERM;
> +       } else {
> +               mutex_lock(&psd->clock_mutex);
>         }
> -
> -       /* we must switch to the mutex */
> -       spin_unlock_irqrestore(&psd->lock, *flags);
> -       mutex_lock(&psd->clock_mutex);
> -
> -       /*
> -        * There was a possibility for psd->clock_op_might_sleep
> -        * to become 0 above. Keep the mutex only if not the case.
> -        */
> -       if (likely(psd->clock_op_might_sleep))
> -               return 0;
> -
> -       mutex_unlock(&psd->clock_mutex);
> -       goto try_again;
>  }
>
>  /**
>   * pm_clk_op_unlock - counterpart to pm_clk_op_lock().
> + * @dev: the same device previously passed to pm_clk_op_lock().
>   * @psd: the same pm_subsys_data instance previously passed to
>   *      pm_clk_op_lock().
>   * @flags: irq flags provided by pm_clk_op_lock().
>   */
> -static void pm_clk_op_unlock(struct pm_subsys_data *psd, unsigned long *=
flags)
> +static void pm_clk_op_unlock(struct device *dev, struct pm_subsys_data *=
psd,
> +                            unsigned long *flags)
>         /* sparse annotations don't work here as entry state isn't static=
 */
>  {
> -       if (psd->clock_op_might_sleep) {
> -               mutex_unlock(&psd->clock_mutex);
> -       } else {
> +       if (pm_runtime_is_irq_safe(dev)) {
>                 /* the __acquire is there to work around sparse limitatio=
ns */
>                 __acquire(&psd->lock);
>                 spin_unlock_irqrestore(&psd->lock, *flags);
> +       } else {
> +               mutex_unlock(&psd->clock_mutex);
>         }
>  }
>
> @@ -143,26 +121,44 @@ static void pm_clk_op_unlock(struct pm_subsys_data =
*psd, unsigned long *flags)
>   * __pm_clk_enable - Enable a clock, reporting any errors
>   * @dev: The device for the given clock
>   * @ce: PM clock entry corresponding to the clock.
> + * @sleepable: Whether the clock operations are allowed to sleep.
> + *
> + * Returns -EPERM if the clock can only be started by preparing it while=
 that
> + * is not allowed here.
>   */
> -static inline void __pm_clk_enable(struct device *dev, struct pm_clock_e=
ntry *ce)
> +static inline int __pm_clk_enable(struct device *dev, struct pm_clock_en=
try *ce,
> +                                 bool sleepable)
>  {
>         int ret;
>
>         switch (ce->status) {
>         case PCE_STATUS_ACQUIRED:
> +               if (!sleepable) {
> +                       /*
> +                        * An entry left unprepared is an entry whose clo=
ck is
> +                        * enabled when prepared, so it cannot be started
> +                        * without sleeping and the device must not be
> +                        * IRQ-safe.
> +                        */
> +                       dev_err(dev, "clk %pC cannot be enabled atomicall=
y\n",
> +                               ce->clk);
> +                       return -EPERM;
> +               }
>                 ret =3D clk_prepare_enable(ce->clk);
>                 break;
>         case PCE_STATUS_PREPARED:
>                 ret =3D clk_enable(ce->clk);
>                 break;
>         default:
> -               return;
> +               return 0;
>         }
>         if (!ret)
>                 ce->status =3D PCE_STATUS_ENABLED;
>         else
>                 dev_err(dev, "%s: failed to enable clk %p, error %d\n",
>                         __func__, ce->clk, ret);
> +
> +       return 0;
>  }
>
>  /**
> @@ -223,8 +219,6 @@ static int __pm_clk_add(struct device *dev, const cha=
r *con_id,
>
>         pm_clk_list_lock(psd);
>         list_add_tail(&ce->node, &psd->clock_list);
> -       if (ce->enabled_when_prepared)
> -               psd->clock_op_might_sleep++;
>         pm_clk_list_unlock(psd);
>         return 0;
>  }
> @@ -371,8 +365,6 @@ void pm_clk_remove_clk(struct device *dev, struct clk=
 *clk)
>
>   remove:
>         list_del(&ce->node);
> -       if (ce->enabled_when_prepared)
> -               psd->clock_op_might_sleep--;
>         pm_clk_list_unlock(psd);
>
>         __pm_clk_remove(ce);
> @@ -384,7 +376,7 @@ EXPORT_SYMBOL_GPL(pm_clk_remove_clk);
>   * @dev: Device to initialize the list of PM clocks for.
>   *
>   * Initialize the lock and clock_list members of the device's pm_subsys_=
data
> - * object, set the count of clocks that might sleep to 0.
> + * object.
>   */
>  void pm_clk_init(struct device *dev)
>  {
> @@ -392,7 +384,6 @@ void pm_clk_init(struct device *dev)
>         if (psd) {
>                 INIT_LIST_HEAD(&psd->clock_list);
>                 mutex_init(&psd->clock_mutex);
> -               psd->clock_op_might_sleep =3D 0;
>         }
>  }
>  EXPORT_SYMBOL_GPL(pm_clk_init);
> @@ -433,7 +424,6 @@ void pm_clk_destroy(struct device *dev)
>
>         list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
>                 list_move(&ce->node, &list);
> -       psd->clock_op_might_sleep =3D 0;
>
>         pm_clk_list_unlock(psd);
>
> @@ -472,16 +462,13 @@ int pm_clk_suspend(struct device *dev)
>         struct pm_subsys_data *psd =3D dev_to_psd(dev);
>         struct pm_clock_entry *ce;
>         unsigned long flags;
> -       int ret;
>
>         dev_dbg(dev, "%s()\n", __func__);
>
>         if (!psd)
>                 return 0;
>
> -       ret =3D pm_clk_op_lock(psd, &flags, __func__);
> -       if (ret)
> -               return ret;
> +       pm_clk_op_lock(dev, psd, &flags);
>
>         list_for_each_entry_reverse(ce, &psd->clock_list, node) {
>                 if (ce->status =3D=3D PCE_STATUS_ENABLED) {
> @@ -495,7 +482,7 @@ int pm_clk_suspend(struct device *dev)
>                 }
>         }
>
> -       pm_clk_op_unlock(psd, &flags);
> +       pm_clk_op_unlock(dev, psd, &flags);
>
>         return 0;
>  }
> @@ -508,25 +495,27 @@ EXPORT_SYMBOL_GPL(pm_clk_suspend);
>  int pm_clk_resume(struct device *dev)
>  {
>         struct pm_subsys_data *psd =3D dev_to_psd(dev);
> +       bool sleepable =3D !pm_runtime_is_irq_safe(dev);
>         struct pm_clock_entry *ce;
>         unsigned long flags;
> -       int ret;
> +       int ret =3D 0;
>
>         dev_dbg(dev, "%s()\n", __func__);
>
>         if (!psd)
>                 return 0;
>
> -       ret =3D pm_clk_op_lock(psd, &flags, __func__);
> -       if (ret)
> -               return ret;
> +       pm_clk_op_lock(dev, psd, &flags);
>
> -       list_for_each_entry(ce, &psd->clock_list, node)
> -               __pm_clk_enable(dev, ce);
> +       list_for_each_entry(ce, &psd->clock_list, node) {
> +               ret =3D __pm_clk_enable(dev, ce, sleepable);
> +               if (ret)
> +                       break;
> +       }
>
> -       pm_clk_op_unlock(psd, &flags);
> +       pm_clk_op_unlock(dev, psd, &flags);
>
> -       return 0;
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(pm_clk_resume);
>
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index ef3f1310e749c34d4aff75a2fd7e95b9f2ef3a10..c38c59b8a52831ea44ba3ce89=
217c99a616adda9 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -636,7 +636,6 @@ struct pm_subsys_data {
>         spinlock_t lock;
>         unsigned int refcount;
>  #ifdef CONFIG_PM_CLK
> -       unsigned int clock_op_might_sleep;
>         struct mutex clock_mutex;
>         struct list_head clock_list;
>  #endif
>
> --
> 2.34.1
>
>
