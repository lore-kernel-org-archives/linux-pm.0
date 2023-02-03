Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266AC636CC
	for <linux-pm@archiver.kernel.org>; Fri,  3 Feb 2023 18:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBCSrB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 Feb 2023 13:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCSrB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Feb 2023 13:47:01 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60C9A829;
        Fri,  3 Feb 2023 10:46:57 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hx15so17787484ejc.11;
        Fri, 03 Feb 2023 10:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDlALgOuUECbRLsqFlsPz8DNfzzHDbnBNKgZUf/whcs=;
        b=yMA+BZmgIu9x8OoVoXdGhz58n/x+0eG2HuTSBw6RnH4hlMJLFR9wpM23jDHpUtY9hx
         2nP6rMWuVyLhCqV0QcPLCHs8niBh5afzGceTS2B8MCYvBpgHYo8IHAWAS/4zTSiluY+x
         Lr56vyv3aCbwzV5V50hIkezRO+hFJmEuroawVlprutQD98KEYE0mexDUCgVNNjCfxmo3
         6nDv4+iS4mHgrV00kCPjXJ1/r3GW1Y7qLKaPl0DMIPBmUZKYAJCGjDgJ5WabdCzWbZSd
         /3DKt5+s/Ivc9P8initdo7HOrNkRCwhMdggADvygza+tHZDxPUlcXuJy9uqluIH6tiCw
         q3kw==
X-Gm-Message-State: AO0yUKUccT8KumAw4MsVebugcrYkrn2+Q9plbZuqytiX6+etB2VMKC0k
        6A7DkLmpTDDxuscjQP/P4GVcM1OSAtT9VPKgiCW5MXVa
X-Google-Smtp-Source: AK7set9G8nmMviZDC6W/jqjh8Cd/AB8pngx/b4KwrfgnZYHQJxECEixgcgo/pbtUow02LGsbTzdnMqlKkg4r2MEaAYM=
X-Received: by 2002:a17:906:2f88:b0:844:44e0:1c4e with SMTP id
 w8-20020a1709062f8800b0084444e01c4emr3556302eji.291.1675450016123; Fri, 03
 Feb 2023 10:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
In-Reply-To: <20230203173331.3322089-1-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Feb 2023 19:46:44 +0100
Message-ID: <CAJZ5v0gkOfbWZWzsTKLBD9C8TaAp0qmTv0L0X7E3fBSLyMUEcQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Generic trip points for ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 3, 2023 at 6:34 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> This series introduces the generic trip points usage in the thermal ACPI
> driver. It provides a step by step changes to move the current code the
> generic trip points.
>
> I don't have an ACPI platform, the code is not tested.

What's the purpose of sending this now, then?  Should it be an RFC?
I'm certainly going to treat it this way.

Thanks!
