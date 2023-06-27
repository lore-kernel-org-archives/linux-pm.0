Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD0EB64D9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Jun 2023 18:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjF0SPh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF0SPR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jun 2023 14:15:17 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2CF10D5
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 11:14:53 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b6993ef4f2so9562831fa.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Jun 2023 11:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687889627; x=1690481627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9IDgxwXk+SfIcE8XS75jEMX3wIcTvs3+H4f5NkpWr0=;
        b=WOyNnQ2qdWaLKyOvotgXSDJy8m84Sxd8pY3PZrD5mBzvcUhc53SKygG0AJQ3/tLZQ8
         sKo6w/rRr67g+mmEPonhOZU1qCwzZBHrDrzeoIehpISEs9cpfExemIjnHdMZtIK7ezRi
         taVw4pUVPVBxj9hsOyIj8UuDPf5kdtaIOnDzP7cAzQXHXioLBrgT9TMF0Q2HfU61Z2eY
         I6Ueb5dIM8X23dRRM1TWAdDrzfu289BH9nG9ATSVGhv++BVoVxwk6hjXCvcSezgB3guj
         ExIvfAvNhD5iLmDB6ktYhtLHjFrCbWK5r4VXP903FiOcPPpIOoUZjpD/gxILJRNJ0WrU
         PJVA==
X-Gm-Message-State: AC+VfDxmUV7G427HXGhpKDTGuv2hz/5V9oclZXl/F8YPxu18VB0lj68o
        76c4qRnSeCg3I164nW4pZcnE6Ki0yojkqCqzTrE=
X-Google-Smtp-Source: ACHHUZ47ZqbyuXhQTRd6VgXtizbakUvqBG0OB8WL+bLy57PgLWBlyc9967kwFwHgMlYEADssNdN0zecdDRHGkidmX74=
X-Received: by 2002:a2e:8e3c:0:b0:2b6:9b02:cf1c with SMTP id
 r28-20020a2e8e3c000000b002b69b02cf1cmr4062625ljk.2.1687889626927; Tue, 27 Jun
 2023 11:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230627023015.gltrc6xxmjdkhkqa@vireshk-i7>
In-Reply-To: <20230627023015.gltrc6xxmjdkhkqa@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 27 Jun 2023 20:13:35 +0200
Message-ID: <CAJZ5v0h0mAfNRSBxrbRo+yrvbahvPwGzHFU=B6j32riJyZ9+Sg@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm updates for 6.5
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Tue, Jun 27, 2023 at 4:30 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
>
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-6.5
>
> for you to fetch changes up to 5ee64250286e8c5162808667a9a8668488d9f577:
>
>   cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to get icc paths (2023-06-26 12:09:47 +0530)
>
> ----------------------------------------------------------------
> ARM cpufreq updates for 6.5
>
> - Add support to build cpufreq-dt-platdev as module (Zhipeng Wang).
>
> - Don't allocate Sparc's cpufreq_driver dynamically (Viresh Kumar).
>
> - Add support for TI's AM62A7 platform (Vibhore Vardhan).
>
> - Add support for Armada's ap807 platform (Russell King (Oracle)).
>
> - Add support for StarFive JH7110 SoC (Mason Huo).
>
> - Fix voltage selection for Mediatek Socs (Daniel Golle).
>
> - Fix error handling in Tegra's cpufreq driver (Christophe JAILLET).
>
> - Document Qualcomm's IPQ8074 in DT bindings (Robert Marko).
>
> - Don't warn for disabling a non-existing frequency for imx6q cpufreq
>   driver (Christoph Niedermaier).
>
> - Use dev_err_probe() in Qualcomm's cpufreq driver (Andrew Halaney).
>
> ----------------------------------------------------------------
> Andrew Halaney (1):
>       cpufreq: qcom-cpufreq-hw: Use dev_err_probe() when failing to get icc paths
>
> Christoph Niedermaier (1):
>       cpufreq: imx6q: don't warn for disabling a non-existing frequency
>
> Christophe JAILLET (1):
>       cpufreq: tegra194: Fix an error handling path in tegra194_cpufreq_probe()
>
> Daniel Golle (1):
>       cpufreq: mediatek: correct voltages for MT7622 and MT7623
>
> Mason Huo (1):
>       cpufreq: dt-platdev: Add JH7110 SOC to the allowlist
>
> Robert Marko (1):
>       dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ8074
>
> Russell King (Oracle) (1):
>       cpufreq: armada-8k: add ap807 support
>
> Vibhore Vardhan (2):
>       cpufreq: ti-cpufreq: Add support for AM62A7
>       cpufreq: dt-platdev: Blacklist ti,am62a7 SoC
>
> Viresh Kumar (1):
>       cpufreq: sparc: Don't allocate cpufreq_driver dynamically
>
> Zhipeng Wang (1):
>       cpufreq: dt-platdev: Support building as module

Pulled and added to the linux-next branch of linux-pm.git, thanks!
