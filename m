Return-Path: <SRS0=KcDj=TD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB21CC04AAA
	for <linux-pm@archiver.kernel.org>; Fri,  3 May 2019 08:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D33B2087F
	for <linux-pm@archiver.kernel.org>; Fri,  3 May 2019 08:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOwMT0Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfECIEo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 3 May 2019 04:04:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41920 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfECIEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 May 2019 04:04:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id c12so6607281wrt.8
        for <linux-pm@vger.kernel.org>; Fri, 03 May 2019 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TpXqJQI7PVBHDytg+IGA8i8m1/XYj0MrND3X98mgWRU=;
        b=KOwMT0Cl9efaAA08+DXGflf+klv1sSVEHKxtGUL+CBB2gxt07xyd+GyRUCCFVKzsBF
         vKFUzaTq0/DOqlmb39mbYs9iH9RkOcgL/KAAeaSaMlUscaGj/bjbj+P1qApNVwESdscJ
         g+1LJrqUlO8vcWihy8sZ39L1L6LS1ajt0o5fzIYYJaQhvca+WfuJGXFbdFR2rcym4b4t
         zBYkf1Llb/Z3r2f2Mqm8DStMLgaZcHBFBYpuH2Uow5/FZOaBijtEgoGFhaFs2w3Lbcsf
         fUx7d6Qd9AwY90DycZfziK6toE6kMAjg8Mx+cK1CNVyDwdMXuzYcxD1e3vRmAV6UcGSV
         1pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpXqJQI7PVBHDytg+IGA8i8m1/XYj0MrND3X98mgWRU=;
        b=pZeqAjPKgHG6t6JLFQxKW7nAUEA1QgT+fBqcqxPterz69qltxMhKT0gD9+Z05Klh1S
         JMnP7k36Wsk9zQBfYvSAMZH4kklPR+b0k5wWEjc9gh9LW7728glq1tzefpaQx7zbw/3n
         /ZS1CWYObq/wwkHbzky8qBaFSAeV8BBgOu3sbpI5f8KP+LTab3zEcT0zKnjTtxZRYSbI
         kTgHjqCrjxRDgTElCUREmrHljFvHJogNTxMMhS/FUU2VfFQ5hPA/Ytbpz0M4c8t4W5s1
         LfXqS+VQwHH3ue5L/2K6CpLD5PZ9vEVbeHgIpXJJ3zRboO1kC6ZGx4uJD27TpEdbo1uE
         wUwQ==
X-Gm-Message-State: APjAAAUIkEma3Y0KXor6aP49i6mRRkG5LUTqVYaf5tbK32tlaPzn2enN
        kTn80bFa0ZWf+hjsqqHR2jfAaw==
X-Google-Smtp-Source: APXvYqzRH5TpkdzGloadzIxAtQZsM2JgxqfDy9oibY2Qrd4ctA1Tpc85qqJ9ZfJamG8tTMt5Vi3YIQ==
X-Received: by 2002:a5d:430f:: with SMTP id h15mr5756534wrq.132.1556870681778;
        Fri, 03 May 2019 01:04:41 -0700 (PDT)
Received: from [192.168.0.41] (223.235.129.77.rev.sfr.net. [77.129.235.223])
        by smtp.googlemail.com with ESMTPSA id k1sm1159060wmi.48.2019.05.03.01.04.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 01:04:41 -0700 (PDT)
Subject: Re: [PATCH 1/6] thermal: Introduce
 devm_thermal_of_cooling_device_register
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
 <1555617500-10862-2-git-send-email-linux@roeck-us.net>
 <20190501164843.GA16333@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c8a26b7d-2775-e13f-21b7-dbc901ea3b0b@linaro.org>
Date:   Fri, 3 May 2019 10:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501164843.GA16333@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190503080439.e-UqulZXsE6eg_X0xLBuSCPW6y0v2je-1d7RzDWgDPA@z>

On 01/05/2019 18:48, Guenter Roeck wrote:
> On Thu, Apr 18, 2019 at 12:58:15PM -0700, Guenter Roeck wrote:
>> thermal_of_cooling_device_register() and thermal_cooling_device_register()
>> are typically called from driver probe functions, and
>> thermal_cooling_device_unregister() is called from remove functions. This
>> makes both a perfect candidate for device managed functions.
>>
>> Introduce devm_thermal_of_cooling_device_register(). This function can
>> also be used to replace thermal_cooling_device_register() by passing a NULL
>> pointer as device node. The new function requires both struct device *
>> and struct device_node * as parameters since the struct device_node *
>> parameter is not always identical to dev->of_node.
>>
>> Don't introduce a device managed remove function since it is not needed
>> at this point.
>>
> 
> Any feedback / thoughts / comments ?

Hi Guenter,

I have comments about your patch but I need some time to double check in
the current code how the 'of' and 'devm' are implemented.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

