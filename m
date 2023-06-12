Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F109C88CB8
	for <linux-pm@archiver.kernel.org>; Mon, 12 Jun 2023 17:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbjFLR6y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjFLR6x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 13:58:53 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17951E52;
        Mon, 12 Jun 2023 10:58:51 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-974539fd9f0so90926366b.0;
        Mon, 12 Jun 2023 10:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686592729; x=1689184729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3eCuUugtCHCIvJfGUvpouutW/MqpB73NWLtQIoZsdg=;
        b=ABMTXPLeGVnMnJf5hFuW7jME3oGWPTANcDRfpzRsFaNQlM8Qe4ziMVYy5SFdv6NYw/
         LT5ytckvWPXtZCCEY3qDfin62hSjaZTosg4E+PvnKwwAMElQDimai7zf6gqX/opSSfc7
         sM3NEN+g7ml0XbbBsh2v8gYDQ6AZEjzG5zAVFGOXU0pZKqq8MdcrQNa+f2H8wqRhKBRE
         LmmtP44i200gtLBFstNVkjWvxiBom7N1OR2yp+ZQPAZbYJbsu/6k7GhwVlnyuD52jNVC
         S+bI8baKZzwFJatz66ofh8M2DtnTlM/2IQV4hFYlGx4Flc2LhNRyGhjlWZcxi+JNND0e
         pt8g==
X-Gm-Message-State: AC+VfDzbm4J7I+tJBrBoj3FoAtKAPuH/RxPGRpW/aMNknFh1ZssDM2eP
        0JLQBeiLZhy4lm0SvWUxWsYPFIKcRHz5rzqGxCiR0gk2
X-Google-Smtp-Source: ACHHUZ7wTZfe+gmfVbQ8l5SUY8x+JfLN3gDKcmQL4KZgtE2TObrzL1rqflSKY3Pe3gZzuI2GA8PsUQ45F7+1n6Zdhtk=
X-Received: by 2002:a17:906:5185:b0:974:5480:6270 with SMTP id
 y5-20020a170906518500b0097454806270mr8020315ejk.0.1686592729377; Mon, 12 Jun
 2023 10:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073025.22884-1-mario.limonciello@amd.com>
 <20230602073025.22884-2-mario.limonciello@amd.com> <CAJZ5v0jNn1wHtF7c0XYKpM=XzZasdu3OwksUdqRFO3TyZwrPOg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jNn1wHtF7c0XYKpM=XzZasdu3OwksUdqRFO3TyZwrPOg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:58:38 +0200
Message-ID: <CAJZ5v0gdY93OidC=on3LsmO4+eT8e3bT8XJwrim2BrQ5AoG+vg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ACPI: x86: Add pm_debug_messages for LPS0 _DSM
 state tracking
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, hdegoede@redhat.com,
        linus.walleij@linaro.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Jun 4, 2023 at 6:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jun 2, 2023 at 9:32 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Enabling debugging messages for the state requires turning on dynamic
> > debugging for the file. To make it more accessible, use
> > `pm_debug_messages` and clearer strings for what is happening.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> I'm inclined to apply this one and the [1/4] at this point.
>
> I can also apply the 2 remaining patches in this series if I get ACKs
> for them from the respective subsystem maintainers.

The ACKs were provided, so the entire series has been applied as 6.5
material, thanks!
