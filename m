Return-Path: <SRS0=HpL5=3C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76023C33CA9
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 23:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C28C214AF
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 23:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ox+WPUIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgAMXkX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jan 2020 18:40:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40195 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbgAMXkW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2020 18:40:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id q8so5630218pfh.7
        for <linux-pm@vger.kernel.org>; Mon, 13 Jan 2020 15:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=sO+iqS5at4kQoqKYaj93x28+XPq7u/VZF7pgBa0PTKw=;
        b=Ox+WPUIgcZKuEnZWTkLLPQgzYp0JAP6+RHmNZarXHOR1VEGRUFuB3vTek415XOepq0
         T1NSsiZB7v7KbLRXYYYv/0yKmrgtGstw2OHUg4uo193MIY3mW8dAuo2BhttsmEdDXsGf
         hQY1jh58eJp6Zex+n1KUCz+YfneiZYP3+vOcHHdcShOZx9YPW6qyBfEKE4Q7I22oj8SX
         Ixg+YB3Zxv98M4zeXiWrXtWbgOXkobDXN5OsDDK11D1EdvzjpcfSb4HbnYYcx9lhXceA
         uZHFuRjkq6c5LEX6Vi3iY9gOP2qzhfbfu16G9H1LoHOT0rLJ6zfFU4XYyn5ed/BPFvX8
         aKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sO+iqS5at4kQoqKYaj93x28+XPq7u/VZF7pgBa0PTKw=;
        b=GDl/PSELtbE1FAXGdHKp+KL9YRW7ncBuN1jg0/DJPjbrq34GA4/xftBxlKoMQfmYbj
         Z6WrpVeXmi2Lx/YnVYqIOKzI85McvcgtJRO+CDHOZ3YcryTQqkSNbeAyVWik/zOrExKO
         NYXTgP94x2GJGCZMiX+Qrjnpew1uE3VK6/iK5T+HICOHciieMx0/WmQsqmfOhWmRpWEH
         IeAIUTWfDi6qKiXNXGZSinB25zZHlgwe45VPmsR3rcOIcyffMzmYAf/GCrKyfKTafh+8
         7D8Fd1JjP2N0wXUqsb8Ru7Nk/izEtxgNBR9ft+Whf+KfChcDEscN79LVHTiAjlxGKJq6
         aIww==
X-Gm-Message-State: APjAAAXMPA/Xdprgm6hR0lKyF/GF8p7AIkIPPpsF/MrTGq99O48BFUHq
        xytD88JTBjQ6z77VEBIHzutrEQ==
X-Google-Smtp-Source: APXvYqxOFnkt4NJld1GAc3enPtDOXFGVXS9iJaH6cGEgh6sJnOSmCeK3VGF0VCf5MdcABcrSc1YLIA==
X-Received: by 2002:a63:114a:: with SMTP id 10mr23486632pgr.250.1578958822095;
        Mon, 13 Jan 2020 15:40:22 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id 144sm16256684pfc.124.2020.01.13.15.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jan 2020 15:40:21 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>
Subject: Re: [PATCH v5 0/4] arm64: meson: add support for A1 Power Domains
In-Reply-To: <1573532930-39505-1-git-send-email-jianxin.pan@amlogic.com>
References: <1573532930-39505-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Mon, 13 Jan 2020 15:40:21 -0800
Message-ID: <7h7e1vdixm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> This patchset introduces a "Secure Power Doamin Controller". In A1/C1, power
> controller registers such as PWRCTRL_FOCRSTN, PWRCTRL_PWR_OFF, PWRCTRL_MEM_PD
> and PWRCTRL_ISO_EN, are in the secure domain, and should be accessed from ATF
> by smc.
>
> Changes since v4 at [3]:                                                         
>  - add SM_A1_ prefix for PWRC_SET/GET
>  - rename variable and update comments

Thanks for those updates

After the bindings issues are worked out, this is ready for merge.

Kevin
