Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441BC7EE2A
	for <linux-pm@archiver.kernel.org>; Mon,  5 Jun 2023 07:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjFEHgr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 5 Jun 2023 03:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFEHgq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2023 03:36:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAB83;
        Mon,  5 Jun 2023 00:36:45 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CEA0A66056AA;
        Mon,  5 Jun 2023 08:36:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685950603;
        bh=Vjm3ihthJvkZLq+tjlrnOh0IMA05G6NIKzps6uAqPq4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D66lucLU60+oysiEO+49sOUc+ebQrmsgjhrN5JHtLefKmhNh8EhiilKzGFZBKl+YF
         ADZbnI9PEeGpHmNHyoQNuJjeVQLnOZR1ikTSW8FOD/5+kar0zhnIZXbcY/0sTpa1cZ
         gKj0lZ7vodDLmBNmGPorXC62hvzrSfFcwuZLJJ7MJTK8EtDCTc8VvgXiu2Sl2i06SM
         reLN219D71BIdCLGqlQjEIUPrJzV1fqQhKX0KkWg5SewHB4/r7HJC8+0TIK/QzkHZr
         v1+q8et83WMBojnOs3/jzayTvNAb8K5KbphnXvxwYQSlI7sc3YcMlCN4ZiFxktJTeW
         46o6fh5/WNHeQ==
Message-ID: <0144a00a-aa87-58f0-9d49-6ce35e41c945@collabora.com>
Date:   Mon, 5 Jun 2023 09:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings: thermal: mediatek: Move auxdac
 binding to yaml
To:     matthias.bgg@kernel.org, rafael@kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <20230601134425.29499-1-matthias.bgg@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601134425.29499-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Il 01/06/23 15:44, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Convert the older binding to yaml syntax.
> The thermal IP has several sensors, to reflect that
> thermal-sensors-cells is set to '1'. Apart optional regulator
> for bank supply wasn't part of the old binding description,
> this patch adds them.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


