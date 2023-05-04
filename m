Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CDEC7EE22
	for <linux-pm@archiver.kernel.org>; Thu,  4 May 2023 00:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjEDAvd (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 3 May 2023 20:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjEDAva (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 May 2023 20:51:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BAA118;
        Wed,  3 May 2023 17:51:29 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A819166029DE;
        Thu,  4 May 2023 01:51:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161487;
        bh=ZuwMTWHm2iPyq3ojep0jRCMBzTJ63CqAsLJCGNoZM4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bucvv2nuoDCdR5cpffHY+fXqyyr7lKu3Lp695q9QahUtJgi2NMBczsUCdCqCICVuT
         Wy3f3+u1Eu1PD2+V+tlvI3EzA1+pc975LPsnvk6ohdVu6TuGCm6j18RoJUJVFoLx54
         lzGp+9DDXtZLiw5r4SwMda/n+KByUipc80cKD+wJUh2QpMZaAGJhY+hfObYLaxyvam
         HVT0q5eovfnnnfIru3ZPy1pL0hlDFbzY6s/O/3qCkH+Hm6nrcx5d/ujjoH5gCo+xcW
         k5aq0xqbD6/lExzcW1tdr24VdAkYahPKbjinTN08g8aZay6VzPCghA+X/6GqOFmyAZ
         QNm6kKOjmT3og==
Date:   Wed, 3 May 2023 20:51:21 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com,
        amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v2 3/5] thermal/drivers/mediatek/lvts_thermal: Add mt8192
 support
Message-ID: <922e6f99-cc03-4b1d-b390-a3d3bcf2ef83@notapiano>
References: <20230425133052.199767-1-bchihi@baylibre.com>
 <20230425133052.199767-4-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230425133052.199767-4-bchihi@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Apr 25, 2023 at 03:30:50PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add LVTS Driver support for MT8192.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> Co-developed-by : Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

As you're the one submitting the patch, your SoB should come last [1].

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Otherwise, with the change to use filtered mode instead of immediate mode as I
mentioned before,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
