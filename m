Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D740C433EF
	for <linux-pm@archiver.kernel.org>; Fri, 15 Apr 2022 12:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353262AbiDOM1L (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbiDOM1J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Apr 2022 08:27:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E60C12C3;
        Fri, 15 Apr 2022 05:23:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B2CBA1F47DFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650025438;
        bh=aNUKZRqzWwuRZBD1tLkU4cEBLexGxURzllQ3UN6Q9gA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Qieib9C620ulPkn9RIaxxXXGF49cv69L6yVDjRiQpNHO4tQoF75xKxpM/bxv+MRdc
         AS+5mudJXju3cjkfN/EgKVXP7MMgbwvygGE+4uIc48d4+0+rOduZWFULRjV+vC4QAk
         zNRua3AIQ9E4O8LqCegItEtEzEeF2uU+qPfKhAP+FmPDrmP/g7vhAHMkdUgNlxNfGF
         lLwfMpdUPgWCUPEPW2Q6Cn3PebgSYyvoxQjpNQUs45qNSDYXa89HWJEGjYCWHtnnUw
         Evijst0eiTLPiCtC0Kl4kamg/j53uARs+e2baQIRwjK/Mik3W8Rfp0cSUt0wU9rSqm
         CGEux1jTi4eUg==
Message-ID: <04718ddd-424f-72bb-3fa8-df23b996c022@collabora.com>
Date:   Fri, 15 Apr 2022 14:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V3 14/15] arm64: dts: mediatek: Add MediaTek CCI node for
 MT8183
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com
Cc:     jia-wei.chang@mediatek.com, roger.lu@mediatek.com,
        hsinyi@google.com, khilman@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
References: <20220415055916.28350-1-rex-bc.chen@mediatek.com>
 <20220415055916.28350-15-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220415055916.28350-15-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 15/04/22 07:59, Rex-BC Chen ha scritto:
> Add MediaTek CCI devfreq node for MT8183.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


