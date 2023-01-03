Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39845C3DA7D
	for <linux-pm@archiver.kernel.org>; Tue,  3 Jan 2023 23:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbjACXtG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Jan 2023 18:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjACXtB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 18:49:01 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A73B13F73
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 15:49:00 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so25237901wms.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 15:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VzuSR66Slw5b05LQRX+L6Dh2f0E0qoPcnQ6jREbJakU=;
        b=agQyEtUFxmGDkoWjDyOI0o/0JqJACgRXWCKdkS/Q0xy3nHi3tzh6xENmQfiW6E07Ow
         0dGc5o+2Dcd3L8A33jsUDtQBQmDz/8LJfsxK+3h5bicVrnDXxg4gLDNfHVvOzl9rw+1s
         OFR573pi7R+8Me6Bv0/mS26YHdsOfPZ/MsDnZfbIppabS1DsMKXHTJDQpG9pu6ZRv27O
         fDXN6g+fBtD9+icYb27T2Jm0uzVXU9uZrKlNgxRvGG8CGE8uJ+BobF08F/KjcFPM1mAZ
         ueA3q8UFFjaL0LE6NmM2VfGmZW30KaXjlcoHcOmQ65PBTnH7BnzMw+35yDlC8NWkZij1
         biXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VzuSR66Slw5b05LQRX+L6Dh2f0E0qoPcnQ6jREbJakU=;
        b=n4UrxhwV3Pyn4CrKN2/1uHvzp7Ir8zGuIFqUh2LJBs/sAv49r89DmmOMVrlLe8+/oT
         u21dcZbj3cQ8JAQ5xodwfceT8VRJO0GzItashOpdU6GwOy9iMr6T0Uo/uex56SoYnfr1
         A6uAvVJ7E5DECoCFJWgKNCXS1lRuVaICfo8z7sAQVoRp6tdsvAULsZ3G1OHhjGX4Ut+o
         8s6sDfwX9lvjvtGEln+hGYdv6zW1Zsg6fZSvcGcVM5k8Dkc7SECn8Mun/Vy7vjyCylAC
         LcNn9OMGRG30OnG7xL8F2aq1ab3uAjNKqWxR/6uffQ+bBxXpzLm70zuQ0tjOi15fVJLS
         Sa+g==
X-Gm-Message-State: AFqh2kp1yvvgNgdglVk7knwrNrh3/o8DFQLy1ZhqGihi0LkWILGy8inU
        g4WfBgEdiOcoAu3snQfi9yV89w==
X-Google-Smtp-Source: AMrXdXtK+qKI4wPxZ+4Hzl1jsGs9t3tiExxTJkvyc3L0CgmqC4vFQIO2kTCgUti8j7DGFEgLKnNdkQ==
X-Received: by 2002:a7b:cbd4:0:b0:3d3:3d51:7d44 with SMTP id n20-20020a7bcbd4000000b003d33d517d44mr32813918wmi.33.1672789739088;
        Tue, 03 Jan 2023 15:48:59 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k39-20020a05600c1ca700b003a84375d0d1sm54410904wms.44.2023.01.03.15.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 15:48:58 -0800 (PST)
Message-ID: <ca7bcae0-2427-fe65-92c2-9ca1f1526ef0@linaro.org>
Date:   Tue, 3 Jan 2023 23:48:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/4] interconnect: qcom: rpm: Set QoS parameters
 regardless of RPM bw setting
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
 <20230103173059.265856-2-konrad.dybcio@linaro.org>
 <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
In-Reply-To: <0e2bdaec-b7ba-0474-8b80-8901fcc87a0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/01/2023 23:43, Bryan O'Donoghue wrote:
> On 03/01/2023 17:30, Konrad Dybcio wrote:
> I agree your code does what it says on the tin but, whats the overall 
> justification to depart from the downstream logic ?
> 
> ---
> bod

and can we prove with a meaningful test a behaviour change ? Better 
throughput ? Lower thermals ?

---
bod
