Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA13C4543
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917987; cv=pass; b=syPpe+6vXxbty0vXJNUnCVcjlPtL5/TBA3Npc7NiZM8H+Z9452B3F8iX+CJ68oQy7UVSk/Ck/M0GpX9N8qrKPOuPiJFidAySOkpmlRWOzsk2nfDrJ+b79jKTTnedIR4BAb85r5GQUWRvZCeQrHDpo2G/OR+Nq7HGEKurLuyG19s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917987; c=relaxed/simple;
	bh=LYkX7yIc3qkXZ1DNgIalBTqE/6TcOOSxtDj8d/K9Fuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S00oJTvk1gz06LT2ktARJSfkYHUZWwGtIB7mFQNJMh7guv/W6MqNNGLp8ocjuKSVdRRhwP6qmBeaYfg5fBM/k3POZmGla2IKblcwvNJkqSEdM1gxkPA7geYpNfhtXWFmOm30xZcR+ZBY/9TnMGVds965LtHvpmd0psenaLyObbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rJ/7Yc+j; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJ/7Yc+j"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a4234f91dso7867411fa.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 03:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773917984; cv=none;
        d=google.com; s=arc-20240605;
        b=ilcVF0TGr5WOwHbkBn6PlGS/fopWphvm82vmEAI1386NmAOKkAgFf6S60bFo+9nVMD
         SIn4mm7C7s0B3mBy5NPXf6zxz+QZGfVLvytO2EY72ga6RQ7XShGdDQV+1E5WLy/Z9w7c
         t0Jz0+jwZviVXogZLdgVRuJqGdnPVoQmF8ZfPNGdB0MfbuCvM9noXwJjzuYZSURtOQJb
         ltdfYB1+ogd1l4UzUO6OTfLp0vR8Wt25RtB1CRJekmNE7QqoWv05EucRPPVIFgrtgEyU
         NBUMRQ4Zh4xf3wxLCyiHwfC4la/4hHMGFXGeJPKY9B6OGcmM/8qyGkuywb/X8fVGByRc
         io2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rl3I9OvJh75whVEZYI8dBSOHvXZGKmK/F9F+q0xIXPg=;
        fh=RfmplT452j+sJBotDYrG+IKGVmQrPIbswfCWy0TFHq0=;
        b=DIa3eyQIGSppj2q96MulzhHOnBXxpz/5qQjFHAYOZ34QVDtQt0Enbk7pkL719RpENH
         96l7jhTMG0yZ2xUfJ7bCMAb10qGieexsz/677lDEj0Y7uts+MCUBEeyS8cFKKXL35bkm
         tHXTc9568vrk2P5FrNSNu8gIAziKcG13CFeYT/IupZmj7ee/GIXxNOVwzBvFVrmMX/t8
         U7i060K4Ta7JvNeFAdBQjBfFs/XEFv3I8Da5++aEimh147FoANyI8T5cs0bJmeeOC5f9
         AXq/r4x6ObthVLUtTta5Uvt6G65u6AAfIXraymLIxnMMnDcwVrOod7OsjffA+dMNla5V
         0gDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773917984; x=1774522784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rl3I9OvJh75whVEZYI8dBSOHvXZGKmK/F9F+q0xIXPg=;
        b=rJ/7Yc+jKnwELQuACTfT91PHVUvTMTX0JTb5X89TbZg6fD5JUn4WduVnUEmwfh88v3
         W1v3p3jrHRC0ZKd8mdGoRMrt1p4uI+PhfY3/NovXthn1F8SDDSeqfx1YkmALLWfotsFU
         7p1WP//D6TpjNgg0daC7CkyIGAlnTbnEDedtgDcwHyKE/SQt3Y+NVHXPtNB9UaDatEtO
         qwAzvWBNERCpSMOqBSrOsX/SXvs4HwyubMd2FsPIFr5dhwD8qAllu0XHHPwr1A1pys4E
         fCoelqf7u25nVJKR0nqngTQYLUWoIMkagDMp+5GoQNoYRB2oelZLZNa1R9311IM7nJ7u
         xO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917984; x=1774522784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl3I9OvJh75whVEZYI8dBSOHvXZGKmK/F9F+q0xIXPg=;
        b=Crkzx6Qhuae34K1rsq4b6NEcWTmF0lMUPn+iStEwgiJ8JeIjMDwWcVRFxI04zCiu2o
         Ia2mjckQtw0OxzVKru5mSG+kJe0PLbYm/f7CTn3dAlqRNrKDpxjfRZT+QJmfVxXbhGVT
         OAdGlx3UYL3XPEigvz81D1h7KAL/3vaaLQNJLVzEa6AtSekINyj9va7zkzCp6PLcUIiQ
         E076dZ5TMm+bLOa05NvnUZ3iioYXZRaa/Xrfja0O4CKJgMfZIEDHmha7Py2FWn2FuWj/
         KXs5Fcm2damKVrPPV4brydcopXSSZeO2WjTezABn76vfNguaeRxp1raIP90g3Lxj3V3U
         aJSA==
X-Forwarded-Encrypted: i=1; AJvYcCVFUm/H5EzmURHAuto2b6cALtWraaV+BNIEL8GK+RqfJxOqbAyN/+3/9NnoMdwRmWW6wY5gheaiIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lBRi6Q6ES1jEz8aac02YHWc7kMnkLrPnQbSuCh5/j50PLplE
	Y+zytmcAdU/PMh010EaiT9O4dBFMeXN9FsREoqFiiPCU0Jvkqx1CmFuCLe8guCUyy6ZMea7EnuR
	kNELm6i/KPeBak0zm2mLcx4rFhizfit/WTXjw6Y6FBg==
X-Gm-Gg: ATEYQzwb8mFeQEAoTcBG3163jY6H63vCIVnQbLZ3lKJs7FsQjb0Mvjwk22HqzDEOQXO
	XxTecBR0iuK4/0qaTckkukXt1VC+7aVbVyxDdAvhiktAoEizuBKVGilYwkmkoBjP4DW6pb2xLLm
	Z0zxWDRzYRuHWP8nB5YR2hZ9dn3GhmMHLHul1OoaF1RAiyfvlWDK5zclZ8pIgZEAz1FA8jGq2DP
	N4BrmYPBkXBHo4RgoPT83l0OFGQt9Z+169p7P3JdRW2TXW+pzO59AM7O5Ohn9J/124zt/FCgRql
	gWvBbUn6
X-Received: by 2002:a19:c214:0:b0:5a1:4514:86f3 with SMTP id
 2adb3069b0e04-5a2796cb012mr1974330e87.30.1773917983554; Thu, 19 Mar 2026
 03:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <15510cee649959281d9554965cacd0c06531c1f3.1773308898.git.geert+renesas@glider.be>
In-Reply-To: <15510cee649959281d9554965cacd0c06531c1f3.1773308898.git.geert+renesas@glider.be>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Mar 2026 11:59:07 +0100
X-Gm-Features: AaiRm50jHCmmusaxMmoxOha3HeyhbyouaVDUb4mihPQ4wIat4a2fgnrmj9y9QUA
Message-ID: <CAPDyKFrMtsp5tRSAOx=ytfQ0xSONtRbC24gq2v4QdSh2wWSw1A@mail.gmail.com>
Subject: Re: [PATCH/RFC] PM: domains: Call pm_runtime_barrier() before dev_pm_domain_{attach*,detach}()
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 10:54, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> If a device has multiple PM Domains, dev_pm_domain_detach() is called
> multiple times on unbind or probe failure.  If the PM Domain is also a
> Clock Domain, and thus calls pm_clk_destroy() from its .detach()
> callback, dev_pm_put_subsys_data() will set dev->power.subsys_data to
> NULL when psd->refcount reaches zero.
>
> Later/in parallel, default_suspend_ok() calls dev_gpd_data():
>
>     static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
>     {
>             return to_gpd_data(dev->power.subsys_data->domain_data);
>     }
>
> which may trigger a NULL pointer dereference.
>
> All dev_pm_domain_{at,de}tach*() functions document that callers must
> ensure proper synchronization of these functions with power management
> callbacks.  Unfortunately no callers seem to actually do so.  This
> includes dev_pm_domain_attach_list() and dev_pm_domain_detach_list():
> they call dev_pm_domain_{attach*,detach}() internally, which means they
> should take care of this synchronization themselves.
>
> Add synchronization to dev_pm_domain_{at,de}tach_list() by calling
> pm_runtime_barrier() before dev_pm_domain_{attach*,detach}(), and drop
> the now obsolete comments.

My apologies for not being able to respond earlier to your
suggestions/questions. I have started looking into this now, and I
will follow up with more replies and perhaps a patch shortly.

Anyway, the principle is that callers of dev_pm_domain_detach() must
manage the runtime PM enabling/disabling for its device. If runtime PM
was enabled, it must typically be disabled before calling
dev_pm_domain_detach().

What makes this a bit more complicated is that we have two different
scenarious to consider.

1) The legacy case, attachment via dev_pm_domain_attach() for the
single PM domain case. Runtime PM should be enabled/disabled for the
device, from its corresponding driver/bus. I assume this isn't the
problem you are facing, right?

2) Attachment via dev_pm_domain_attach_by_id|name() (which is called
for the *attach_list() case too), for the single/multi PM domain
cases. In these cases, runtime PM is enabled in
genpd_dev_pm_attach_by_id().

For 2), I am inclined to think that the proper action is to call
pm_runtime_disable() in genpd_dev_pm_detach() before it calls
genpd_remove_device(). Although, I need to check more closely how
suitable that would be.

Kind regards
Uffe

>
> Suggested-by: Marek Vasut <marek.vasut@mailbox.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This issue was reported first in "drm/imagination:
> genpd_runtime_suspend() crash"[1] and "Re: [PATCH 2/5] arm64: dts:
> renesas: r8a77960-salvator-x: Enable GPU support"[2].
> Unfortunately this patch does not fix the issue for good, it just
> becomes much harder to trigger (like needing tens of thousands of
> tries).
>
> How to trigger:
>
>   1. Check out drm-next[3]
>
>   2. Enable the gpu node in one of the following DTS files, depending on
>      your board (Salvator-X(S), ULCB, or Falcon):
>
>          arch/arm64/boot/dts/renesas/r8a77960.dtsi
>          arch/arm64/boot/dts/renesas/r8a77961.dtsi
>          arch/arm64/boot/dts/renesas/r8a77965.dtsi
>          arch/arm64/boot/dts/renesas/r8a779a0.dtsi
>
>      These nodes are not yet enabled in any board DTS because of this
>      crash.
>
>   3. Build and boot a kernel using renesas_defconfig[4]
>
>   4. The PowerVR driver will fail to probe (since [5], which is IMHO a
>      regression):
>
>          powervr fd000000.gpu: [drm] *ERROR* Unknown GPU! Set 'exp_hw_support' to bypass this check.
>
>   5. Try to bind the driver again:
>
>       $ for i in $(seq 1000000); do echo $i; echo fd000000.gpu > /sys/bus/platform/drivers/powervr/bind; done
>
>      Eventually, the kernel will crash:
>
>          [...]
>          powervr fd000000.gpu: [drm] *ERROR* Unknown GPU! Set 'exp_hw_support' to bypass this check.
>          Unable to handle kernel NULL pointer dereference at virtual address 0000000000000040
>          Mem abort info:
>            ESR = 0x0000000096000004
>            EC = 0x25: DABT (current EL), IL = 32 bits
>            SET = 0, FnV = 0
>            EA = 0, S1PTW = 0
>            FSC = 0x04: level 0 translation fault
>          Data abort info:
>            ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>            CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>            GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>          user pgtable: 4k pages, 48-bit VAs, pgdp=0000000049993000
>          [0000000000000040] pgd=0000000000000000, p4d=0000000000000000
>          Internal error: Oops: 0000000096000004 [#1]  SMP
>          CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 7.0.0-rc2-arm64-renesas-00540-g5f0a63f81a02-dirty #3502 PREEMPT
>          Hardware name: Renesas Salvator-X 2nd version board based on r8a77965 (DT)
>          Workqueue: pm pm_runtime_work
>          pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>          pc : genpd_runtime_suspend+0x134/0x28c
>          lr : genpd_runtime_suspend+0x124/0x28c
>          sp : ffff80008174bc50
>          x29: ffff80008174bc50 x28: 0000000000000000 x27: 0000000000000000
>          x26: 0000003ca1f7104b x25: ffff0000090ba580 x24: ffff00000e7d92a0
>          x23: ffff0000081612f8 x22: 0000000000000001 x21: ffff000008161000
>          x20: 0000000000000000 x19: ffff00000b6ef400 x18: 0000000000000000
>          x17: 0000000000000000 x16: 0000000000000000 x15: ffff000008065600
>          x14: 0000000000000058 x13: ffff0000080254e0 x12: 0000000000000000
>          x11: ffff000008065608 x10: 00000000001343d0 x9 : ffff0000080656c0
>          x8 : ffff000008161800 x7 : 000001f3fffffc18 x6 : 0000000000000000
>          x5 : ffff000008161c10 x4 : 0000000000000000 x3 : 0000000000000000
>          x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>          Call trace:
>           genpd_runtime_suspend+0x134/0x28c (P)
>           __rpm_callback+0x44/0x1cc
>           rpm_callback+0x6c/0x78
>           rpm_suspend+0x108/0x564
>           pm_runtime_work+0xb8/0xbc
>           process_one_work+0x144/0x280
>           worker_thread+0x180/0x2f8
>           kthread+0x114/0x120
>           ret_from_fork+0x10/0x20
>          Code: d503201f f940fe60 52800002 f9410e61 (f9402003)
>          ---[ end trace 0000000000000000 ]---
>
> The issue is easier to trigger, and may prevent the kernel from booting
> at all, by adding extra debug prints like:
>
>     diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
>     index 52ea84e548ff6d27..2fe666c2170194ab 100644
>     --- a/drivers/pmdomain/core.c
>     +++ b/drivers/pmdomain/core.c
>     @@ -256,12 +256,14 @@ struct device *dev_to_genpd_dev(struct device *dev)
>      static int genpd_stop_dev(const struct generic_pm_domain *genpd,
>                               struct device *dev)
>      {
>     +pr_info("==== %s/%s: stop\n", genpd->name, dev_name(dev));
>             return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
>      }
>
>      static int genpd_start_dev(const struct generic_pm_domain *genpd,
>                                struct device *dev)
>      {
>     +pr_info("==== %s/%s: start\n", genpd->name, dev_name(dev));
>             return GENPD_DEV_CALLBACK(genpd, int, start, dev);
>      }
>
> Thanks for your comments and suggestions!
>
> [1] https://lore.kernel.org/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com
> [2] https://lore.kernel.org/CAMuHMdWyKeQq31GEK+-y4BoaZFcCxJNac63S7NoocMj1cYKniw@mail.gmail.com/
> [3] commit 5f0a63f81a027bec ("Merge tag 'drm-misc-next-2026-03-05' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next")
> [4] https://web.git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git/tree/arch/arm64/configs/renesas_defconfig?h=topic/renesas-defconfig
> [5] commit 1c21f240fbc1e47b ("drm/imagination: Warn or error on unsupported hardware") in v7.0-rc1
> ---
>  drivers/base/power/common.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 9bef9248a70529bf..af690ce38ac3a086 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -12,6 +12,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_opp.h>
> +#include <linux/pm_runtime.h>
>
>  #include "power.h"
>
> @@ -183,9 +184,6 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_name);
>   * may also provide an empty list, in case the attach should be done for all of
>   * the available PM domains.
>   *
> - * Callers must ensure proper synchronization of this function with power
> - * management callbacks.
> - *
>   * Returns the number of attached PM domains or a negative error code in case of
>   * a failure. Note that, to detach the list of PM domains, the driver shall call
>   * dev_pm_domain_detach_list(), typically during the remove phase.
> @@ -240,6 +238,7 @@ int dev_pm_domain_attach_list(struct device *dev,
>                 link_flags |= DL_FLAG_RPM_ACTIVE;
>
>         for (i = 0; i < num_pds; i++) {
> +               pm_runtime_barrier(dev);
>                 if (by_id)
>                         pd_dev = dev_pm_domain_attach_by_id(dev, i);
>                 else
> @@ -284,12 +283,14 @@ int dev_pm_domain_attach_list(struct device *dev,
>
>  err_link:
>         dev_pm_opp_clear_config(pds->opp_tokens[i]);
> +       pm_runtime_barrier(pd_dev);
>         dev_pm_domain_detach(pd_dev, true);
>  err_attach:
>         while (--i >= 0) {
>                 dev_pm_opp_clear_config(pds->opp_tokens[i]);
>                 if (pds->pd_links[i])
>                         device_link_del(pds->pd_links[i]);
> +               pm_runtime_barrier(pds->pd_devs[i]);
>                 dev_pm_domain_detach(pds->pd_devs[i], true);
>         }
>         kfree(pds->pd_devs);
> @@ -370,9 +371,6 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_detach);
>   *
>   * This function reverse the actions from dev_pm_domain_attach_list().
>   * Typically it should be invoked during the remove phase from drivers.
> - *
> - * Callers must ensure proper synchronization of this function with power
> - * management callbacks.
>   */
>  void dev_pm_domain_detach_list(struct dev_pm_domain_list *list)
>  {
> @@ -385,6 +383,7 @@ void dev_pm_domain_detach_list(struct dev_pm_domain_list *list)
>                 dev_pm_opp_clear_config(list->opp_tokens[i]);
>                 if (list->pd_links[i])
>                         device_link_del(list->pd_links[i]);
> +               pm_runtime_barrier(list->pd_devs[i]);
>                 dev_pm_domain_detach(list->pd_devs[i], true);
>         }
>
> --
> 2.43.0
>
