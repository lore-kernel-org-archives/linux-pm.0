Return-Path: <SRS0=7C+u=4Q=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A0C3F2D1
	for <linux-pm@archiver.kernel.org>; Fri, 28 Feb 2020 11:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0F9246B3
	for <linux-pm@archiver.kernel.org>; Fri, 28 Feb 2020 11:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582889427;
	bh=tvldJ7pkpz3h6ZO3r3SCgkrkLUwg0Lmc59sviaygSOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s4xrqi9ZgSU49m3sIOW6iWgGyhwz331T2fTLJZgVYIrTZG7Lsv3Pgom8Z7IvS1/C/
	 RCqncjhPeT6FjNJ7LlucAj/nGsq2a2wzd0rz7aH/llo5anoGEKz//3ULr1H19ibGVI
	 7po0PycPO1JoFaBQ2ZMOoSYmmzyYi1jWVkCIj+cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgB1La0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:30:26 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32973 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgB1La0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 06:30:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id c62so1436822edf.0;
        Fri, 28 Feb 2020 03:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jw4VYsVnD4oIU+zIqqTo8B3cO5efxNynpUdYYUZgRos=;
        b=aDMzzDArUzyk8UVhNr3yKg+EXYH0ir8ZF7/CE9YaMf8bcSwN1PpL7ZDmMtrsOc0eBH
         0j6dmFbRSsUp3/HgffEG8snb0U1/2Wq6VofnTyDgc3uZ0+42D8cF/FgtDfbINpZnDEnv
         wVIOxPTCF8g4ZD/LFhlfltz2hwk9huL1xI71opLs4pm+jZCLUYA9rTDE57IU3xVvFCqY
         dFht8XxlcpeZ/kxDpXsDpTUVgmmeD4fcJyk7NHbn2DY1Xoo7BJcaggN3JeALddFUNcub
         FQA1ZujCZgi6pN81mD3PSJ4tpyAmScw7IKy2Cmc+NkrSyHlnnp1B0JXmmrPObPNov0mf
         jLoQ==
X-Gm-Message-State: APjAAAVo0xgITsT8ffeH+FpH8CYgkoGxnpkWiZBTa9q1WX0UZQYZcwVZ
        r0+plWoT6+LIv33nOiLaqGI=
X-Google-Smtp-Source: APXvYqwWA5GxEjXM0/aqlDNV3JKNG7jWzqGoH58k6XWG7pSxEhCV6HKUfA5Wj/DtvjiTt5JTfo8q3w==
X-Received: by 2002:a17:906:6d18:: with SMTP id m24mr3676918ejr.234.1582889423951;
        Fri, 28 Feb 2020 03:30:23 -0800 (PST)
Received: from pi3 ([194.230.155.125])
        by smtp.googlemail.com with ESMTPSA id f25sm520972edt.73.2020.02.28.03.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:30:23 -0800 (PST)
Date:   Fri, 28 Feb 2020 12:30:21 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] thermal: exynos: Silence warning during deferred probe
Message-ID: <20200228113021.GA9458@pi3>
References: <CGME20200228092342eucas1p1ead44fbfd9ab57c02ffa588ca9acb97a@eucas1p1.samsung.com>
 <20200228092331.21548-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228092331.21548-1-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 28, 2020 at 10:23:31AM +0100, Marek Szyprowski wrote:
> Don't confuse user with meaningless warning about the failure of
> registering sensors in case of deferred probe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

