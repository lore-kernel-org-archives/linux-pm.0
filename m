Return-Path: <SRS0=v0US=X3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA37C352AA
	for <linux-pm@archiver.kernel.org>; Wed,  2 Oct 2019 15:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB74621A4C
	for <linux-pm@archiver.kernel.org>; Wed,  2 Oct 2019 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570031094;
	bh=h97wpChBL+4LGh/qzMAkPQSbxEV96F97EHARQGp65cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SCev8S833W9OQxe9rNprA9Q7v98JAc5SWQsRYtK3aqqiKfCFmuN0sFhBs0MCTPaBa
	 mReWo8TCJlISCRiGqpLP7soIi/2FUaPOWUCwxpCBtkAY321LO6Vbo+O+9vXby4R5Ti
	 Nz1/ndm743PGtIcqr1dHRb8pi0F2Q/7BdYdE5ciY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfJBPoy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:44:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38126 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfJBPoy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Oct 2019 11:44:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id 3so7518321wmi.3;
        Wed, 02 Oct 2019 08:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P0EZ/+e8qucG/cQYiHJqjOhVj0ZUu3vDLKFzG8b8i9s=;
        b=Mr6eAMzCqmWntCY4AjWk1EuITkkw9kHOPhzvpsb0o67amEqr4ZSH1A0B8DAhcOeIUt
         kJTTMJzAtIsBGZjVDeSgOj/8up3OIfLiF92N/F7w+vjyz+nM/IPPi8bGHO4mq/2FWMml
         QIYFzYmYEW0vnyG6JMT6jPAyk+W2Psb5tkFNDY9etIFgm2le4BCinOowUX9GWAdXo6VR
         vna/CYT4Te1rxPEqutWlE2+e9xj1I3xL+8qR3kYwYoHh/EvZQm9O9N5Y1dHQuYxSC679
         OKj2rtyFrNCRVUS0mHHJqpuD0o1suqHqsk+qXir8hV4SlSzELfkRQ+rJNS+DPD5qD9Xs
         Yd6A==
X-Gm-Message-State: APjAAAWtjjZfVQgbinmHzYnMQ6kiF+kJbR5zNNqtuFZBsa/RzpW2J9JL
        M8Em0vwutaPFtcmB7oDsDHCIGSpHnE4=
X-Google-Smtp-Source: APXvYqwb5maeTNZ54okVFennzadNPAKBnKZfrg1xA+6SFQtS7oKo7yiFyyqi8xS+MXyKqTMuCwNHqg==
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr3582106wmg.143.1570031091409;
        Wed, 02 Oct 2019 08:44:51 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id 90sm3976343wrr.1.2019.10.02.08.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 08:44:50 -0700 (PDT)
Date:   Wed, 2 Oct 2019 17:44:48 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     vireshk@kernel.org, robh+dt@kernel.org, kgene@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v4 6/6] ARM: dts: Add samsung,asv-bin property for
 odroidxu3-lite
Message-ID: <20191002154448.GC3469@kozik-lap>
References: <20190910123618.27985-1-s.nawrocki@samsung.com>
 <CGME20190910123647eucas1p176bc817bbdae813e5aa9ab4745f9c285@eucas1p1.samsung.com>
 <20190910123618.27985-7-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190910123618.27985-7-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Sep 10, 2019 at 02:36:18PM +0200, Sylwester Nawrocki wrote:
> The Exynos5422 SoC used on Odroid XU3 Lite boards belongs to
> a special ASV bin but this information cannot be read from the
> CHIPID block registers. Add samsung,asv-bin property for XU3
> Lite to ensure the ASV bin is properly determined.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v2:
>  - none
> 
> Changes since v1 (RFC):
>  - new patch
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts | 4 ++++

Thanks, applied.

Best regards,
Krzysztof

