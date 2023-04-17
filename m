Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7437AC77B70
	for <linux-pm@archiver.kernel.org>; Mon, 17 Apr 2023 12:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDQMJJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 17 Apr 2023 08:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjDQMJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2023 08:09:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DB2619C
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 05:08:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q23so54020685ejz.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Apr 2023 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681733292; x=1684325292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RyjCqigehhRKiED+F7i3vp1+UnMWF7PX5LVbym+vBgo=;
        b=eQ/pX6Pevn30y70TZq3BnGur7Qv7Y+QHdBV5HQbPhPQNMotYG22G/1W2bDgBpa1opH
         0u16TrJwKJgvC2W2CCerev70jsUcGpTvdyy+TDCzzo0syb6024IEULDHSBzQtjEGSR2K
         nnvz2qVv3wT5bWXKQF/YY4ka+HkgVVMYgYzTuxI9QwFVZHOo2GL3mStHWb7AxH8fAyLG
         Gda8aFXZ3COmfANJaXtpuF7NtyV5RQC1R8i/toWNDAMr5D8tdZbv3M5tgADKJL1XzjND
         qDiD4Wx0ttkvBPgkhCUQ/usDq2EeQPtDh/YlF+n2bVYDNJDBTEJrG7/fuW7Cx0Ew3hzI
         imkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681733292; x=1684325292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RyjCqigehhRKiED+F7i3vp1+UnMWF7PX5LVbym+vBgo=;
        b=XPopLcTxyqAG+ga6H0Ci9m08NeWR0U+28Sc86LogqeL9CC/GQQinOycXm+Fd+tvSKp
         AlEM/EmRTZ1UR0Z6dD7viYgO3xbkTUj+O1boyPh2/REsVyZ2Zu/xC1nZO+CsUGYz7Txs
         u0sj6XZ5j3PkrRUoLKfLaGlnT44mKsisxSPLeii4TF2Z7e/RbvbqW0XfbQFMN2ncb1/u
         BB2lTZhv5I5NopdHKBdsGd+z4hsTMoij3KHiLp+WOLBssla3LmCJmndfNI379lplyZFi
         jqzPH3lN2hKOnBOcBgSDipiRW7cTKooe2VwDZS3v1/GEZ4A8fsS5xkVpQNYHRIiQ1s0F
         59LA==
X-Gm-Message-State: AAQBX9ew75O/F/74hCEgD1XRUfZhgMoVlkCzmloSwTIbbVMCvoCIqStC
        yt19VYkKkPI7NNeBkCmJvMMOehGLN1vby7scjwo72XGh
X-Google-Smtp-Source: AKy350Z9M8w8QtKoLzHMqZ92p1x/RdWw+D+90EtnaEBd1Rdy0qMwdeE+XVr5iDzYlUx2fn7cjTHsaw==
X-Received: by 2002:a17:906:d9b:b0:93f:505b:9742 with SMTP id m27-20020a1709060d9b00b0093f505b9742mr7135280eji.65.1681733292530;
        Mon, 17 Apr 2023 05:08:12 -0700 (PDT)
Received: from [10.27.64.40] ([193.205.131.2])
        by smtp.googlemail.com with ESMTPSA id gl17-20020a170906e0d100b0094f09cd4658sm3963255ejb.71.2023.04.17.05.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 05:08:12 -0700 (PDT)
Message-ID: <dd0c6f67-99bd-afda-cbc7-797797b82f2b@linaro.org>
Date:   Mon, 17 Apr 2023 14:08:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] thermal/drivers/intel/int340x: Add DLVR support
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230413213753.129962-1-srinivas.pandruvada@linux.intel.com>
 <5c21f6b7-8c7e-6e42-fe02-c8fd3ae64016@linaro.org>
 <CAJZ5v0ir+-MEYkPSZKFSyZ=iAnUbVXtk9jMZHdgpWM6LMQ10jA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ir+-MEYkPSZKFSyZ=iAnUbVXtk9jMZHdgpWM6LMQ10jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 17/04/2023 12:16, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Mon, Apr 17, 2023 at 12:00 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Rafael,
>>
>> do you want me to pick this patch ?
> 
> No, thank you.
> 
> You can generally assume that I will be applying patches for
> thermal/intel/ and ACPI-related ones directly.
> 
> I may pick up thermal core patches too.
> 

Ok, noted, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

