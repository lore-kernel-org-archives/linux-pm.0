Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB421C636D3
	for <linux-pm@archiver.kernel.org>; Tue, 31 Jan 2023 13:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjAaNUA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAaNTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Jan 2023 08:19:52 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015FF2D4D
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 05:19:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y1so14198242wru.2
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2023 05:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMo1Uvj2rFI4YHTrqKmdTiIi+u7MqVqqdbblHM1ubeA=;
        b=kT92r7GyRZTYR8mGvgkCO/iUaBkKd9TU3//8coQoHSHU+cufA/dutHuoRLuzdyc612
         cmMfzb32RJyjFvQBBazq4YCQZjXecLfEvDgswp3vd5OrAovEyua7dmxfVhBAynZr9X5R
         Z0w0gg3rmzsp6BhvnC368L3nI/Zdj5m6hy8RQiVJLY1XkBJzBHqZ2mM5dpIjz0vqzUBJ
         pF66ooIVvEvvgLvrI59mXLlVQpMLH715+rNS6fu+ZhoeXdRHTQgc6bPEHtBeCFoQNQXS
         /zBc2fq5ZJOVg+my1zToMpg8UTKAftWOoYJXVXf3w8MsWv/lUK9oKNblKUdnP2+a/Kbi
         mTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMo1Uvj2rFI4YHTrqKmdTiIi+u7MqVqqdbblHM1ubeA=;
        b=GglgaCGqgZSl+MexwK/7D2od8VJwuJB69lszaYrfQku2ONkX5NY1UDrOfgtql+8Z5u
         rJAgMC8H5Db5OR3kOCBeKp3dvag+ME3ZwLjGgyM2j5CedSSZARd1IIcCk6149ivvdIf0
         G6lvfmJF461WuGC9zWeV8KxlnLd+veLgqPS9n3FOTkwJvXqQBniG/FgDAYNfG0XynlrX
         swuSQMYE71M9668kZVJzIkCl1E0OPxPXvvoveDFYFDc0dQkecbsXVDhXSgDPssSWLNqC
         Tc1ck2U0UfPDPeXLym3al4GMfy8naqqQ+hwejF5ldg3ox3emAHrjyoZDfLOobEUCcOwd
         Vn+Q==
X-Gm-Message-State: AO0yUKVZ55gf7BkmZDdDHjXPo3VSAQsUEqVWrTuDD1IBq92hZOt/T21h
        QqfUjCb3fXGBh+uSSGAxoQozcg==
X-Google-Smtp-Source: AK7set8+z14j6byknzmPNfNDAcrTd590sAlEwun1KVKdHHIegxp6ZEjbaL4ahrm/j8PcjQbdAxnScg==
X-Received: by 2002:adf:a11e:0:b0:2bf:e9dc:5536 with SMTP id o30-20020adfa11e000000b002bfe9dc5536mr7841401wro.45.1675171167643;
        Tue, 31 Jan 2023 05:19:27 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b002be34f87a34sm14918057wrr.1.2023.01.31.05.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:19:27 -0800 (PST)
Message-ID: <05668142-761b-e422-5c81-15a70fa77be8@linaro.org>
Date:   Tue, 31 Jan 2023 14:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/8] thermal: intel: intel_pch: Eliminate redundant
 return pointers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <1847763.CQOukoFCf9@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1847763.CQOukoFCf9@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/01/2023 19:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both pch_wpt_init() and pch_wpt_get_temp() can return the proper
> result via their return values, so they do not need to use return
> pointers.
> 
> Modify them accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

