Return-Path: <SRS0=Boio=CM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DCC433E9
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D847820775
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmAlHIxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgICKne (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICKnc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 06:43:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63077C061244;
        Thu,  3 Sep 2020 03:43:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n13so2141353edo.10;
        Thu, 03 Sep 2020 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fVf69sgjmQCrEKYoeM+/1FVWXC87ayDjMXhE8nmIQDI=;
        b=CmAlHIxkVGkcogMiRH95dFIDi8MtypkT4KAhVSJXxMvL9CkkOPaW5Edo9JJotPudcN
         G7v1ptqRXr4yiAXhs7VJli2ZSxelJPRJkFhu+bmNiGz0uDo7GLq7iVqHkz80auQh4EyM
         x3clYrpTOEjC0Bx1UDW5KibmT2l/RvmwCmjcGs9QvmU3jQZxsBaJfd8y8HIpb1P2I1a2
         1jpLyXGn5QZj9ClFdKSUfAuiElucNXBnEKl0H1OuqJef+T4Fuqsu+TWn5iHI2aG6aqDo
         CoLFt4btdZAM5SeuHuTyz98kjzqg6oexbkAFefI/Q+bnCwEGwq49JBQ9dYWABiocQ+X/
         XetA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fVf69sgjmQCrEKYoeM+/1FVWXC87ayDjMXhE8nmIQDI=;
        b=IpwUZA53ea9GBkpfEseMDosoMKnGHXPp27CVw1WzTDRBbCmADrfdK49x63iIcY9tKa
         287rBOxzPp3huQoivaQs04+K4ro8BD1RcUVQbdkXDnWB2mZb8f5/aWyiQ+NueiMPOtdx
         oiIAuSo0GaDIuWBkUXErlQQk3JfKnpqaaN4oCB4Dap7+Iyt/7CgzoApb7ui9CIaFgxAH
         EPybj6FXN39dxpgCnTCRqFu2ik8GLln3X+vCYoYkWq0kfD38fdfcpyK9Y274CK+JenGk
         ngWud/rMrvOPqdRMo5W4s3gvciwqMcweLwmegfjl54KMxxuyK5fL3dq1ohBif384A9Kg
         mwPA==
X-Gm-Message-State: AOAM530vPT5H9g2+aXl/hCW2cJxgUwDht/1iwBbSx1m8CnjQZI64wn1Z
        GveuhbFZuQK7bLtxG/JrRcfukYMuqblj5YgUujY=
X-Google-Smtp-Source: ABdhPJyu8Qa+G8WqE5A1ihixIYP1N10xyh0oXqPvS5rhQyYINqD323MbTNZuZq9TzrQXm+MwLfErIORRLYTSFNa2n+Q=
X-Received: by 2002:a05:6402:220d:: with SMTP id cq13mr2326156edb.260.1599129811091;
 Thu, 03 Sep 2020 03:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200831061013.4327-1-avolmat@me.com>
In-Reply-To: <20200831061013.4327-1-avolmat@me.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 3 Sep 2020 16:13:19 +0530
Message-ID: <CAOh2x=ksVwnmqS_9dUukBKPBD26Tv5Yd0G_pXW1C6zhzfv2o1g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Enable CPUFreq for STi stih418 SoC.
To:     Alain Volmat <avolmat@me.com>
Cc:     Patrice Chotard <patrice.chotard@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 31, 2020 at 11:42 AM Alain Volmat <avolmat@me.com> wrote:
>
> This serie enables cpufreq for the STi stih418 SoC.

Please cc the maintainers directly for patches. I almost missed these,
just found during
random screening of the list.

Applied all.

--
viresh
