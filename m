Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CC6C433DB
	for <linux-pm@archiver.kernel.org>; Sun,  3 Jan 2021 16:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A65220936
	for <linux-pm@archiver.kernel.org>; Sun,  3 Jan 2021 16:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbhACQey (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 3 Jan 2021 11:34:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbhACQey (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 3 Jan 2021 11:34:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5D6207FB;
        Sun,  3 Jan 2021 16:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609691653;
        bh=1Xh0kJRjsC6msrYqP8J5e1S//63sIFqo7WNBprGaGq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQ84APNGGuHPZM7DhlNyQvsTmUgXUOmP4dBofRfFaIjBw56KeffghZWQgEpD8ga1q
         a3ppMI00fB/i4F0rxEvYn0XDUyxeMCacsx8WYveu9vvIfRryheg0xI9QKY2eCaOW5/
         MibBEXOh5ONORJ52+VAE4dZD7sZk1ztXQfOiJ+W49XnPoljcsgI39jzxAIPYRFMCx9
         R9S9ldOEWjpeCCwthtERJKTVnSF7/6hWsYDGFhqVaTummyLk1hzHtRGMIMOsKQfR1J
         eutLUh4/4OBQlDPCn97JgMBNfwnnyOHb+bFfnQDbaSlsC/Vuf3VT5efbzGkhxgFM9x
         7WZw7xglKavBQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Timon Baetz <timon.baetz@protonmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: (subset) [PATCH v6 1/8] extcon: max8997: Add CHGINS and CHGRM interrupt handling
Date:   Sun,  3 Jan 2021 17:34:07 +0100
Message-Id: <160969163064.69953.7111810036827620312.b4-ty@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201230205139.1812366-1-timon.baetz@protonmail.com>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 30 Dec 2020 20:51:53 +0000, Timon Baetz wrote:
> This allows the MAX8997 charger to set the current limit depending on
> the detected extcon charger type.

Applied, thanks!

[8/8] ARM: dts: exynos: Add top-off charging regulator node for I9100
      commit: 3803f461bd28c1c817281348509399778633e82f

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>
