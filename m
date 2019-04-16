Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB664C10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96554206B6
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 17:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YW3jnrC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfDPRQo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:16:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34524 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfDPRQn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Apr 2019 13:16:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so28187922wrq.1
        for <linux-pm@vger.kernel.org>; Tue, 16 Apr 2019 10:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDOZE0aUj9wfgV9/RLJq9TMZJEXOqxo3qhA7+gP1SjY=;
        b=YW3jnrC/vtqgYhP348HrIXefzITFFFHtRBTXCcXuVlDwOYWXts6otMgA9Tcb1FGza3
         WTJKxPzWolkPbtrHUo6KBzQiBfQQSLb0XbMuM16/M/XLWVlH/svnIT53m4DRwDxVHjoO
         IXLJPnas/YG59khUQaEFQdZIWgM6uhoezjETyMD0ssrg1uOZinChPV7ajodjQZgI2aF/
         RGHQdgzrIg9nHKK0yj3/vWKMcf3/WA8FP7OPOVXhdudq4Fi6OocC4vuJn7EcT43LQej4
         1nOIuY/klurlQGeaefAR5C/bS2Z3ffNFtpIMCgZKEv1C2ypMXnvnfRWhtPaSTT+Oy04/
         FbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDOZE0aUj9wfgV9/RLJq9TMZJEXOqxo3qhA7+gP1SjY=;
        b=qO5JWFs2S0aMiYhLbq2MXHjsRL3AjzOL1Tv+zJXDPvzXduEJT1rDIp4KnP0qOrKzk6
         rIWeeXVZKvWuLCKq+vhQDs+Ctpj0/2j83eLiYzh/9odu0KiLd2DPDnxlmeNBKPSvj5Zs
         7NaflAhpn4LsMyf+wNI9ee5oi4iiBR7m1TJGrKPSa0x8ZcX6MAlAiRnUejDes1OOJm0e
         ACRbD5gMo3EIoSEEFScymvCK87ki14icLUEh9YUU1+Gr6us8qpCmxqr4EovANfOvY9PD
         fgZQyf7rfdPc+SsVtCKkR4jToieRQaEsljNq7GenAafhuWjJRwZ1+3i6mkW60veYT9v8
         /pTA==
X-Gm-Message-State: APjAAAWHvkKS4ynhWXnOEQjawOUpwzNt8MTb710uqLfTNuiQG055aWxW
        tNWXHaan3eKNEiLUsVrOlEC7NA==
X-Google-Smtp-Source: APXvYqyLUvhvo5VLukWB6R1KOucg1GjL6CBenyEdSGllLhFAdA0kI/SqXJIUzLI+4VFLui4iRipbNA==
X-Received: by 2002:a5d:5192:: with SMTP id k18mr19209521wrv.171.1555435002062;
        Tue, 16 Apr 2019 10:16:42 -0700 (PDT)
Received: from [192.168.0.41] (50.251.95.92.rev.sfr.net. [92.95.251.50])
        by smtp.googlemail.com with ESMTPSA id j7sm77288293wrt.96.2019.04.16.10.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 10:16:41 -0700 (PDT)
Subject: Re: [PATCH v4 11/12] thermal_hwmon: Add devres wrapper for
 thermal_add_hwmon_sysfs()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-12-andrew.smirnov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c4d350be-d33c-770c-5253-466e10a3f8eb@linaro.org>
Date:   Tue, 16 Apr 2019 19:16:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190413082748.29990-12-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190416171635.z6sO2KMDaCXPZj5gbu7qv9XFtzVQl0wMhlc5cqid2bU@z>

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
> code.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

