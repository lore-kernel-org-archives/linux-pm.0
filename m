Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D8350D74
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451010; cv=none; b=j2pD/LYrhc0KWRsW4P6rDUNjOIWBX3o3jJXpOOah3wV0J9FD339YizUN2OzQ+R/mh63AJ/yn0EAi/OeNwDiIuO7oaThqHPGKMdd7K316w6XekS7hQlTWK4bdAYojTAN3y8ncnWsSph6OQcOd5bkzvgxL+J7SJIV+YK6hNDVEyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451010; c=relaxed/simple;
	bh=mtmF63GSsxC8ucGrWu4xmNcFiMRqT2xKfGyBPlFaKgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsi4csMCuU1KN6uFduKhA84hp2dBilWgjjsUWXNfXOxfKiXvjUzoLtR0DL6nJsWDTbMdhwxHmuXrwQem5hMCrVGWs6JLtgOif2fBabeohw0Fh2gVvOwdDcMIw76BEMbiT9Yl9Au8nfr+BEWlr39LHIElZS4mzRqTR04qeXocEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso1018093e0c.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 11:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451008; x=1777055808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neHg95D5WYSHShReC6Umh9yusfLHSyJyieBJVR+9t1E=;
        b=b2oTXw3UUNzOxReNhPhXI6VDiFyXYQqO4PvbuPSXpsPjeIJVH00KSmw8WIE9H3EvBf
         jIuHxeXwPV/Yaql3hFxfudFL/xZQhdPCTRIk7ECmxWCo6siBrHWtzTZejMfjQ8P/JoAW
         AVodKBPkp2HeAAwayHQgMrZ4/M1rZjcJU+gJrskivnlaQRl7psHPtm0Z5E5WwdDEHRNc
         ofBL9ryQhi7a4wEPwoA19fa+dR/z956KDB0GSoZCvrlx/cdVVN+M0QC8sRuNlYo+1dkX
         WG9eb6cTd/qhLBcwE/X6NNgjvkfyCiuD/gGIlk1lQI0kTsx2iMU3p82hasRe97Fz1BVM
         05ig==
X-Forwarded-Encrypted: i=1; AFNElJ8iChDcqtYiLVShbGdq8ijFJGVmm8Nq1wptP+cTDUhFB2zdzixVaRLLe9EV1i8v+uW7VNCYxpTnaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYLrKi7PMTpuBc8JEP3mVsUJIs6KQ55oSvKLfhCzdMMxUy9SG
	AL7TT73RW2RF2NlewmZUGDvFjo43e2aeW2ltlmt/xbpVKuKOZiiHj8buCSuC/tw5
X-Gm-Gg: AeBDievCjBxPWGhK6GDYxQ+8SEub8p4lhlQQk1a3VMA/FP7qbsnbafSx7kB7bWw49R3
	IbNFRKD1w3uF0erxidQpTmHCFQcu06Xs4iBN0F4fU5qeWbet1SZE3q9+rS7b+nVz0de+l/jJFBT
	33HnHr3APn/NbpkT3LGkwGeyKd/z0jKNjPxLxgLys9Dof+vzKShSjz4MomkRAG/hZn+VRz7IdYz
	m7KQl4DRAVgALUO216lTSA6/Tz6PgcdFWUTX0sO7eYPs84oraa765ZrPz1+AWHPUJASCAMaBV3a
	TdejsVpinmEEx5sDFnGis44zQGovLh9w3qNTqitkEbuicPoTnjv7nwVuBGtJCzI10NYv/wBmih1
	g95Lm/R5a/3fJ7SBSTG7qnGWBg3Ai3glqlbapp3GPfnYs8FEh33KJxQp2Ta3dzdae0ArkeTgv9f
	Sp/GhzH2UmuigtnwNbca4THssKVdGD//ExPQf6F+idocKom0ubNvPdYPrHZTwyTKUdWEeqqasNO
	VbvV7WUww==
X-Received: by 2002:a05:6122:311a:b0:567:433b:e903 with SMTP id 71dfb90a1353d-56fa589b89emr2432747e0c.6.1776451007493;
        Fri, 17 Apr 2026 11:36:47 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ed4e1sm1539996e0c.6.2026.04.17.11.36.46
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:36:46 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-944168e8c5fso602735241.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 11:36:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+KeT+g5w7V1qN8jHI8V7wW9QwWQu5LPYljgS+oJiM7UYapFgtlmDf5g6e0mUzi2jQCQTF80isW8w==@vger.kernel.org
X-Received: by 2002:a05:6102:604b:b0:605:1070:231d with SMTP id
 ada2fe7eead31-616f69cf882mr1968470137.17.1776451006317; Fri, 17 Apr 2026
 11:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417111331.158190-1-ulf.hansson@linaro.org>
In-Reply-To: <20260417111331.158190-1-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Apr 2026 20:36:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
X-Gm-Features: AQROBzCoxCQjJeAx5n3-CfOUikJfBlFM72Zl3QgzR1bVf-vpU4L_nBvmJuvLGng
Message-ID: <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fix detach procedure for virtual devices
 in genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Fri, 17 Apr 2026 at 13:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
> genpd calls pm_runtime_enable() for the corresponding virtual device that
> it registers. While this avoids boilerplate code in drivers, there is no
> corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().
>
> This means these virtual devices are typically detached from its genpd,
> while runtime PM remains enabled for them, which is not how things are
> designed to work. In worst cases it may lead to critical errors, like a
> NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
> reported. For another case, we may end up keeping an unnecessary vote for a
> performance state for the device.
>
> To fix these problems, let's add this missing call to pm_runtime_disable()
> in genpd_dev_pm_detach().
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

This survived more than 160000 bind/unbind attempts[1] on R-Car M3-W
and M3-N, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3089,6 +3089,7 @@ static const struct bus_type genpd_bus_type = {
>  static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  {
>         struct generic_pm_domain *pd;
> +       bool is_virt_dev;
>         unsigned int i;
>         int ret = 0;
>
> @@ -3098,6 +3099,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
>         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> +       /* Check if the device was created by genpd at attach. */
> +       is_virt_dev = dev->bus == &genpd_bus_type;
> +
> +       /* Disable runtime PM if we enabled it at attach. */
> +       if (is_virt_dev)
> +               pm_runtime_disable(dev);
> +
>         /* Drop the default performance state */
>         if (dev_gpd_data(dev)->default_pstate) {
>                 dev_pm_genpd_set_performance_state(dev, 0);
> @@ -3123,7 +3131,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)

Above, out of context, there is an error return.
Should we call pm_runtime_enable() again, to keep the reference count
balanced? Or can we just ignore this? It's probably futile anyway.

>         genpd_queue_power_off_work(pd);
>
>         /* Unregister the device if it was created by genpd. */
> -       if (dev->bus == &genpd_bus_type)
> +       if (is_virt_dev)
>                 device_unregister(dev);
>  }
>
> --
> 2.43.0
>

[1] https://lore.kernel.org/15510cee649959281d9554965cacd0c06531c1f3.1773308898.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
