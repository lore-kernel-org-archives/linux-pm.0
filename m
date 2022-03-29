Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167ABC433FE
	for <linux-pm@archiver.kernel.org>; Tue, 29 Mar 2022 16:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiC2Qzf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 29 Mar 2022 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiC2Qze (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2022 12:55:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6561FCCC;
        Tue, 29 Mar 2022 09:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7175CE1A3E;
        Tue, 29 Mar 2022 16:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88405C34100;
        Tue, 29 Mar 2022 16:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648572828;
        bh=RAzIK088iuyQ7PoKVZupgXhmKvM+p5UafnbQ28nSC8U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ojZGFzGFPFX5vrMm6KvzIsaWK/ZFQbVPFSYVgNp18yHgwWcgFWXT4UqqvKvxjSkbc
         qqVUWUNXs4wi9gqsNKQGT/tKmCrVgwHjPW9LofKvZtvoxhPBniZPnO6xGGshJUV0bW
         QAfcxg9WckuMpSyez2FKwCX6vy3nom/sRhiVLA0Jg/9xjaFUAXKlBwaoLuzqWo0p5l
         xULb/SVBz7dmHWhqtWktl+MsgWdpupyppN4lBrXKazo+BvIj2wDMSGtf9TgdcXe9fi
         mDwGlX0845WH4RYYYPnYQhlNo6g1W75HW4RtIr+v9hyVPP7zMxcngp+iy27kijkSi1
         jys1jIAeY0YtA==
Message-ID: <32033e8b-b630-b977-e4b0-58632094c0dc@kernel.org>
Date:   Tue, 29 Mar 2022 18:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Content-Language: en-US
To:     Li-hao Kuo <lhjeff911@gmail.com>,
        krzysztof.kozlowski@canonical.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com
References: <cover.1648531197.git.lhjeff911@gmail.com>
 <5c3d0ab5baa9126b544a8f54ac5c773269ee1944.1648531197.git.lhjeff911@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <5c3d0ab5baa9126b544a8f54ac5c773269ee1944.1648531197.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 29/03/2022 07:24, Li-hao Kuo wrote:
> Add bindings for Sunplus SP7021 thermal driver
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v6:
>  - Modify yaml file.
>  - Addressed comments from Mr. Krzysztof Kozlowski

No, you did not address.

If you think otherwise, please provide some context because I really do
not see any change here.


Best regards,
Krzysztof
