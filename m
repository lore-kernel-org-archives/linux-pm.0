Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B20C25B06
	for <linux-pm@archiver.kernel.org>; Thu,  4 Aug 2022 23:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiHDXIQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Aug 2022 19:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiHDXIP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Aug 2022 19:08:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C671B29CB6;
        Thu,  4 Aug 2022 16:08:14 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3439D6601AD1;
        Fri,  5 Aug 2022 00:08:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659654493;
        bh=nIKTHC5TpgtGoaGyFnf60f6v8daqV5/eetp2cNnFVUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDAVqgo9BlaaUvUiY0XCyNeS5W2pL0k+O29BBFHN9HicuIWjF6sdwHYlooS+j43iM
         k/TXrsfNw0kJMqG0KMCb3V5aYvit/JHFSoZxhN2Oz6IRmBbQJeSo4hdsOwN5xO5vfw
         C01y5PCmF+qsJbSymkjI4KZcHD/yHmDaouQBl/+VP1EmTa9sqnRV5yQ9H4mNNs9A/N
         BauwjogF+iteUngwO70XiR9CWVf8ReeHjPn36bVaOoX0aksJXkeOd+hCd2zHj/tKkK
         CgK2Y5df73Td3JWwb++1bZ/0pm9fQ4jDrmAP6y0vFWtJXxoiqGvECdOYcF6HL7CaFj
         pDyA3eei9q08w==
Date:   Thu, 4 Aug 2022 19:08:08 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     bchihi@baylibre.com
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8.1, 0/7] Add LVTS architecture thermal
Message-ID: <20220804230808.vackudl2vymysakw@notapiano>
References: <20220804130912.676043-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804130912.676043-1-bchihi@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 04, 2022 at 03:09:05PM +0200, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> This series moves thermal files related to MediaTek to the mediatek folder.
> And introduce the new architecture LVTS (low voltage thermal sensor) driver to report
> the highest temperature in the SoC and record the highest temperature sensor,
> each sensor as a hot zone.
> The LVTS body is divided into two parts, the LVTS controller and the LVTS device.
> The LVTS controller can connect up to 4 LVTS devices, and each LVTS device
> can connect up to 7 TSMCUs.
> 
> The architecture will be the first to be used on mt8192 and mt8195.
> 
> Changelog:
> Changes in v8.1 :

Please use whole numbers, no need to make this more confusing, v9 would've been
just fine :-).

Thanks,
Nícolas
