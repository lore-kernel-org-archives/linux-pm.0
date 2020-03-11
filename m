Return-Path: <SRS0=+pCq=44=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFE7C2BAEE
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 21:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5786120755
	for <linux-pm@archiver.kernel.org>; Wed, 11 Mar 2020 21:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EICxn6Fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbgCKVps (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:45:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42759 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgCKVps (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 17:45:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so4670064wrm.9
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2020 14:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=n7HvHKiTnPOuqemknJ105xUPY/fhPykhkmE2tki5wUw=;
        b=EICxn6Fn7AFSWWWApb9dqMF1HA9elGbNGMudsmJElLrVolmjUJKkpJAEkSDaK3gkoy
         dgJTsiVARL15UIMk+HsgvC/dtdB9NQ9x5loTMa6PnUplCqBUc8gLUd0i0FrjzjG7a/Np
         lHJJZYOUEEH8afSng01BNAy/u+zq5ZYjuSmrGKyHMovqwUD+B/aadjqBSbWvbOZe44ut
         kDSaei0FjnGc1PjMfWhCPIwFbRzdcI7C7x/wbo41nWMzHlIWqGc/x4oieFEbnAQ0NN/X
         o6ed44eOo8ngzEtNUF9miYkor1nZIGitcJqPbsS4x89oMdx1NGJlhY1nhJmfXyCS+UWG
         LmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n7HvHKiTnPOuqemknJ105xUPY/fhPykhkmE2tki5wUw=;
        b=cPR0Zc2bQr9ZHKq/5RXDH/+yzkPDN/PjR7LD7IKn9AI4OtUQvkTCEgq5AqnLQzAgCs
         RCYOOWmQR+XwU5Y3dgDzKHQEBIMRE9eDqlofWTKY3Ev/fjiHZhqpl1rrI+T5DspTaiHe
         YZ4mZRLrZ4RPwGqYmL4dEJdpIQppbw5t9HEhL7Q0+zUPuTokF/Vt4uL3uyEmc6f4rOty
         Kw2ZBOdDCYdZSPb75Vm9fC8EViorit5+vPlEXg0EA92HH1/Cs9e33a0NSSHNoEqI6vV+
         wQPHfgg78S0qwNaoFif3CGESS402Dha8UYhPVrlEhfwIyXYDLqGELHX3YZaGe1ip/FRC
         aFaw==
X-Gm-Message-State: ANhLgQ1+0u1BRaH1h+Lqt/cG195WDQO/sE+amt8lKOy1kSOmmOPGvqN0
        TA2VqV8P9nYiEpu4qEnWd0Nsi7/9nps=
X-Google-Smtp-Source: ADFU+vvaCB3U3dIhxKX4tIuvn9wPcxA11wZ/JEilVShuY982q31z6n5RZ4IMJftU0QVsHPTsWtxWpg==
X-Received: by 2002:adf:f584:: with SMTP id f4mr6798624wro.77.1583963145223;
        Wed, 11 Mar 2020 14:45:45 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w9sm34772517wrn.35.2020.03.11.14.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Mar 2020 14:45:44 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Heiko Stuebner <heiko@sntech.de>, khilman@kernel.org, nm@ti.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: Re: [PATCH] PM / AVS: rockchip-io: fix the supply naming for the emmc supply on px30
In-Reply-To: <20200121222859.4069263-1-heiko@sntech.de>
References: <20200121222859.4069263-1-heiko@sntech.de>
Date:   Wed, 11 Mar 2020 14:45:41 -0700
Message-ID: <7hwo7qr2ey.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Heiko Stuebner <heiko@sntech.de> writes:

> From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
>
> The supply going to the emmc/flash is named vccio6, not vccio0 and while
> the code does this correctly already, the comments and error output do not.
>
> So just change these values to the correct ones.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Raafael, feel free to apply directly.

Thanks,

Kevin
