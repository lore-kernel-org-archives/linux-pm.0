Return-Path: <SRS0=8Vg7=SO=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CCDC10F0E
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 12:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C462171F
	for <linux-pm@archiver.kernel.org>; Fri, 12 Apr 2019 12:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zt3e68gD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfDLMcm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:32:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDLMcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Apr 2019 08:32:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so11688833wrq.8
        for <linux-pm@vger.kernel.org>; Fri, 12 Apr 2019 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+Bcx6F3YyYobacbTTW4hytwrgeDrJrL4+XeVWxQT7jA=;
        b=Zt3e68gDgtreMCjw9RTgIZOcg+rninyYIFYBK9++wOCgbhurh4AfqRz4C0Zz69Dxiq
         LJpTNzgsM82PXXh2vqFwwoS4NfC40w8GQnZ098kCbxkC7OnxXs1nNy1I6Szlf4eoy4Wo
         epYmXSJDkmYJn0yZLNafRxGHH+yq+PMUgTEhqVbRx8dZiqWlA2S4lnoGtqewIqHI9tIi
         3ZtaEf18iXy2nlH6NSTWewfwppq7fKXX47YIwR8F6462VvqA6LYNYgaZ8G8WtkSxeJqS
         m3gW0HjNpxnr50VMNnIsZmzhUyS2FEwV7kJEB2vbcAJQd1URi9PAnQbpp8NTSSyMb5j1
         Cjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Bcx6F3YyYobacbTTW4hytwrgeDrJrL4+XeVWxQT7jA=;
        b=pbPr1GkjygYGfs6CBKQZspQck1FtvzuHWz41N589kNhotfXZWKaSUAC+jzmLReHDb/
         hToUhbnEvS4+AibK2KLvZus5wYBOEe3rdHUU14m3aZljbmKh3W8pPLwI0zJSnQCnZVcW
         4BH3hOyTYbzUYrk24jY5HAbM9PGUQJf8hLDiEUPIquryi/iilmw6Sqie9jKgw4C4nWaH
         ytxhbc2ZlwBBg1fXlPNEIUz56ygDMwG5ZZfvf3+9VddNmMwm0Jd5vR8p7PrI2Kr3fJAj
         YImdJSpHoXandUOaHuB65k187zfhS2uJeBDk830PJe9Jas6n4lVOxy5A6bAH4VmofnFh
         GCxQ==
X-Gm-Message-State: APjAAAXMhCjOe5hQ1XYDc7XeRf7Iwwy+gKY6Tkjf3vR/iJeQeuZFJjcH
        8yMHtZsQs1UaO75fT+/umpZPnA==
X-Google-Smtp-Source: APXvYqyNeFJjbyvzUNPXl/CdF/pNEvmohlwCxtj6G2b1VMMKIaRPRdM+99XV+jdJu1BFc//AefMasQ==
X-Received: by 2002:a5d:4f07:: with SMTP id c7mr7370047wru.104.1555072359895;
        Fri, 12 Apr 2019 05:32:39 -0700 (PDT)
Received: from [192.168.8.100] (134.96.130.77.rev.sfr.net. [77.130.96.134])
        by smtp.googlemail.com with ESMTPSA id s12sm12786122wmj.42.2019.04.12.05.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:32:39 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] thermal: Introduce Amazon's Annapurna Labs Thermal
 Driver
To:     Talel Shenhar <talel@amazon.com>, robh@kernel.org,
        edubezval@gmail.com, dwmw@amazon.co.uk, jonnyc@amazon.com,
        rui.zhang@intel.com, hhhawa@amazon.com, ronenk@amazon.com,
        hanochu@amazon.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
References: <1554978168-17369-1-git-send-email-talel@amazon.com>
 <1554978168-17369-3-git-send-email-talel@amazon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <61186ba3-659c-cc62-cb70-532e89aaae44@linaro.org>
Date:   Fri, 12 Apr 2019 14:32:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554978168-17369-3-git-send-email-talel@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190412123237.WcsIoYZv1YisK1zEvvkO7Dbtcea87_BL04MszOKuPw4@z>

On 11/04/2019 12:22, Talel Shenhar wrote:
> This is a generic thermal driver for simple MMIO sensors, of which
> amazon,al-thermal is one.
> 
> This device uses a single MMIO transaction to read the temperature and
> report it to the thermal subsystem.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

