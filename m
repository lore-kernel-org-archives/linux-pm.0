Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9994CC433F5
	for <linux-pm@archiver.kernel.org>; Tue, 17 May 2022 13:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiEQNdY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 May 2022 09:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiEQNdX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 09:33:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD342A09;
        Tue, 17 May 2022 06:33:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 445A01F4405C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652794401;
        bh=cx1hTNJ0Ru+529Hy8oVuqWz9XxAPU7ZBoyO0Pt8qPnY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cP30jv+yJP/108pNL4W2mQ+sAYRgXswkGZm+3/iNe+X73PIRX0E8LuqN1Lzt548j1
         Jlw0Tp0c2hdO3qA+EoKnzWtq1WLnxtJWajUiBTsB+oWnN7yMpPgqj+mGdpJRRorq00
         /c/9Y9Jrvut5q1lOac7jY9Tcx5RAZ8f4bMiUO5ejqVpTuOyJWauB+h8oPHKFXbak2G
         +CWZB2RaV6oCm8ZLL/OGgP1IRPns/kuJAR9aEUhBUCO4Web8po/r3adDWi/xefeSLn
         ujGUlQrRolZl3y4vpmWT8QDhyS5LCJCi6gkxbpcDvdeNCUbwwB29PhtAtgnAcq0Sye
         esOP5a5u9UcUw==
Message-ID: <b06c93e0-5638-7a53-ccee-5c81a4ddc46b@collabora.com>
Date:   Tue, 17 May 2022 15:33:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] cpufreq: mediatek: fix error return code in
 mtk_cpu_dvfs_info_init()
Content-Language: en-US
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     rex-bc.chen@mediatek.com, jia-wei.chang@mediatek.com,
        khilman@baylibre.com, viresh.kumar@linaro.org
References: <20220517133450.2266243-1-yangyingliang@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220517133450.2266243-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 17/05/22 15:34, Yang Yingliang ha scritto:
> If regulator_get_voltage() fails, it should return the error code in
> mtk_cpu_dvfs_info_init().
> 
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
