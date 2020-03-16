Return-Path: <SRS0=xg7F=5B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6ECC18E5B
	for <linux-pm@archiver.kernel.org>; Mon, 16 Mar 2020 16:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E5520724
	for <linux-pm@archiver.kernel.org>; Mon, 16 Mar 2020 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuH75nUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgCPQOM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:14:12 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39802 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732033AbgCPQOM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 12:14:12 -0400
Received: by mail-vs1-f65.google.com with SMTP id p7so9446221vso.6
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2020 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBDCtFmVlmwok8vUzi26MlGBbPcfcb7XMIsVTqNi9do=;
        b=FuH75nUp8oKLA+mUqWbx6oFCErjjg+2KD+mAVoj6DUeH1D9WGGPmT6ionb0S+43XxJ
         8LPzfjMNU2tfB5CGcGqQ/iIbHV2+E2dFFIMjY7vOdzX4a4jWs6XlEErT1+tFM4dndAZB
         tPBDur11ZisT8rmfI3RWzJHnq64KiuPD24AOyKz0v+b0aQoEigUVcsdp6nQHB0AT9yf3
         r950MhLEK/ySxhdgpuohVDmsw2+MoIn7kaQsAUTpJnXAu+nIGhPfTKFh5RxLAV7QTlmr
         9WqNrAsGpOItTVL4PoMpuFCUUe3KBo2Yo295TFO8Vm6OsMFyHRL7YOymzG54+mcVzrpv
         ppTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBDCtFmVlmwok8vUzi26MlGBbPcfcb7XMIsVTqNi9do=;
        b=GDkOe7nlDHJB90ZwID3E0FYGH7doAtmVaPwGMjolaqfLpq2Ne9HM5BJ8ldobqlXOLq
         NwdRCpww7NmFQiqSfXoVtWqdhnccgXVGrdvKW2kuECUnWwv3pSypP1a1yjCQozZf+N1F
         /yVJXLi1PanWM78qknBLoX7szExILUYjO/sYdBcjruxSCrzOygVeEkIL9XA9ocmjhooJ
         hl0EaTR0zFxkz2nkMIuWVmjS8rnnn7iuKngmCBn3xd1oDQxZ/1FZXvOMlo2NQUi0tejn
         wj/s72DymyrK3ROrRsOh6kFryNBRNna1iEWBnV2bIxlX+Pf7FwAKO93qbLKy6KCwp8v3
         kpdA==
X-Gm-Message-State: ANhLgQ1VAlBfiyjqOlzZgGVBlJ1Y5ba1Q+fFAV6N5bmujbsxySl4F06F
        rDU2yKs2DhBjhMuj/v6lkvZ6xMPh1yiXFzeavjlxuQ==
X-Google-Smtp-Source: ADFU+vs3pLJTKaxFy4PgAmzkqT70xCVmTVF1ScAx8CX+A67toAj+a60XNOs30Hvy0izYq7eq1MsBLm7uLvTkG1O+5jA=
X-Received: by 2002:a05:6102:104b:: with SMTP id h11mr369017vsq.182.1584375249809;
 Mon, 16 Mar 2020 09:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200309045411.21859-1-andy.tang@nxp.com> <18c58e1b-583c-2308-ee60-a8923c2027ee@linaro.org>
In-Reply-To: <18c58e1b-583c-2308-ee60-a8923c2027ee@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 16 Mar 2020 21:43:58 +0530
Message-ID: <CAHLCerPBxe=Az=EexxYQkgvhRO40JT0qEhnAwqnGbeesiU-bnQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: make cooling-maps property optional
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Yuantian Tang <andy.tang@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 16, 2020 at 8:22 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 09/03/2020 05:54, andy.tang@nxp.com wrote:
> > From: Yuantian Tang <andy.tang@nxp.com>
> >
> > Cooling-maps doesn't have to be a required property because there may
> > be no cooling device on system, or there are no enough cooling devices for
> > each thermal zone in multiple thermal zone cases since cooling devices
> > can't be shared.
> > So make this property optional to remove such limitations.
> >
> > For thermal zones with no cooling-maps, there could be critic trips
> > that can trigger CPU reset or shutdown. So they still can take actions.
> >
> > Signed-off-by: Yuantian Tang <andy.tang@nxp.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

>
> Amit, I'm about to pick this patch, it will collide with the yaml
> conversion changes.

Thanks for the headsup. I can fixup v3 when I respin.

However, I've always interpreted this binding as follows:
- cooling-maps should be mandatory for active and passive trip types
otherwise there will be no cooling
- cooling-maps make no sense for critical trip type since we're
invoking system shutdown
- cooling-maps are optional for hot trip types.

Is this your understanding too?

We should be able to enforce this in YAML.

Regards,
Amit
