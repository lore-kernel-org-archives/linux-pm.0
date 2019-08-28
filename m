Return-Path: <SRS0=dKCo=WY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6565C3A5A1
	for <linux-pm@archiver.kernel.org>; Wed, 28 Aug 2019 12:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A9B12341C
	for <linux-pm@archiver.kernel.org>; Wed, 28 Aug 2019 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSr68dv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfH1MU0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:20:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43977 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfH1MU0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2019 08:20:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id h15so2334660ljg.10
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2019 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mw0KqBUQtBBiQejRP+l+Plin1MUkMHfXdVhO99uxnT8=;
        b=LSr68dv+MrrBGKW7HdrxDAPV0MLgTbf5M6QTwFD6p6ffELEfCHd4P65B2CENpHOXDg
         oGitpvFm55vR1ZCFMqdpsAAjZwb2+C0uJLZYyM13UA+EGtk4gYjm0hh0Y4yfvyvdY8JX
         0yhRBCL1qEZFVR15KxqAq1wf7blk6ogJTTDzYSqEnTReVFwdF6Rfk+fz16a7vB8rzovf
         yHwIjit07DlTdqMT2VRjBcDOeTeyI205OvgD2XTnKi6U746LLiJT4J3x9dYtGC8kR9oN
         pcZu1Y3riJomGQ8wb/+zsj874/owayfgUgohyBvcK6zWLwx1HZ+7MVwkVNUFc3AIVr7N
         ic2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mw0KqBUQtBBiQejRP+l+Plin1MUkMHfXdVhO99uxnT8=;
        b=FoIXGRhZb3vg1tZ/Bn27HGSFsi1ckD1cwZiedNqjg03r08CICCoWR8OkgUE3CF2qSP
         YykNdl0o7JgiYWdmrsRvTocV9BFbnSv2R/nqwrXfY5FO9HsPuVycDGXs/UNi6cuJ5/GD
         d9U1W2FZw7QkmdTwptk1zfYSbpMu99R3DjZiaNgsLwLO5Ah+o0qYMGuO4K9aDgKR0IGE
         cbJUXJVedYyKCBFE5kARF0OHEMpZBTw9/43sulqvYxMSzwD+2Ga/UTKAgmhy0KOfB217
         0R5QOlw0AccbFAYq5FCAFok7oN3lA6Qvj0wpkNzTEz+hTJmSvyOvP5wX8Z3luhpqkRY2
         B/Dw==
X-Gm-Message-State: APjAAAVrez/zN3MKRvvXedtHIL3ZcRmsQtFrWvIhpvxwm2nAaAiVmI+Y
        oFQDPli8b+Ql8lFO5VW9TWZxIvxRnX+hnu3QrHk7DdCO/WU=
X-Google-Smtp-Source: APXvYqyCHNeQHkPwSVEWq7kksAbupwAWMW2EQE4MGBKLB3lSeYqZD10kx3Eonyc9UcqJmAUzXG02MYgU2wGQuR6vUg0=
X-Received: by 2002:a2e:b174:: with SMTP id a20mr1935021ljm.108.1566994824536;
 Wed, 28 Aug 2019 05:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190717063222.5902-1-linus.walleij@linaro.org>
 <47cb523f-60ad-750e-4374-6563f8230593@linaro.org> <CACRpkdYO7zzrUg=7=4D7XMUwoa6XQggm0jB1PtPhKK=3EV9AyQ@mail.gmail.com>
 <f683466b-a554-87c4-0bfd-4d56bd1142fe@linaro.org> <CACRpkdZ6rnV8isO4SF86jiY2E2pbR9f2OBKYQBbML53A90WCig@mail.gmail.com>
 <d80f7c5f-2242-2216-9c98-02344f483781@linaro.org>
In-Reply-To: <d80f7c5f-2242-2216-9c98-02344f483781@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Aug 2019 14:20:12 +0200
Message-ID: <CACRpkdZMr5hudHbz62QvkHuZMPDPwoG5KxkOrs-UntR-A-rKdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: db8500: Finalize device tree conversion
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 28, 2019 at 11:04 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

> The THSENS_TEMP register gives invalid values because of the firmware?

There is a range of registers we can try to experiment with, but
I don't know if any of them really work as intended.

My long-term plan is to break out the mailbox mechanism so
that sub drivers can talk directly to the PRCMU and then we
can start to be more elaborate in how we use it, including
checking if these registers make sense, I just want to drive
home this cleanup first.

Yours,
Linus Walleij
