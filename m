Return-Path: <SRS0=A9Dn=EC=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD3C388F9
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 20:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5031E2222C
	for <linux-pm@archiver.kernel.org>; Tue, 27 Oct 2020 20:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDlcxJUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372752AbgJ0UZh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 27 Oct 2020 16:25:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36482 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372747AbgJ0UZg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 16:25:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id h6so4047319lfj.3;
        Tue, 27 Oct 2020 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VTXQrHTGLs/knVunju7s+4jC1elCcsEm6LiqWGczAOI=;
        b=IDlcxJUUO1ignMzHcKScWArX+JLa0B/wtkjwa+XqNZfVCgFQ+q//5075QoHnaqEmSN
         4Zgtxq3XetCP3KE9RukHxI2+GlnV+hVTkJxBs3DD8Pwr060BgQxWvF4+IMbUfNtWkswJ
         t8KNrMGfRdjxKIoJD2tMbH0bn8weWLtnEr1HBu1NDPcvHUNDmsAvUPpWb4LamG6b0vBv
         5jBxGWiJ3FVAbZRfcVCjcJuNMTCz9fHBvn3FAMH1rSFVCl+8hKk31loDa3OOX1BGIzYx
         UWX6aHGFi3DUccCqz9OY8dLShO/A2aDfG+k8xCRF2lkGW1wZroeeAywT1/IgVcUNaALb
         W0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTXQrHTGLs/knVunju7s+4jC1elCcsEm6LiqWGczAOI=;
        b=UYil4Mim+SRRiyDuR7VFacXdfvkqmFGME07fHYYu+EsYy0xz3UCC/QiHldLmz26nxX
         Nb0MZTBwC+fW/Tb7vHttwhWUVRGMYzv5SqVTVhrE/HQ2BAwo0LooDnhZD81zprIlz90t
         18csrH+bbD9pJCqxJH9J/XhoIiZNBnPLqA+JGK2ZSj6FnSmzvDstq20vI5j8OoCrcV0/
         LO5KRnMfmsXl7pV+fVfz1BwAUAQZHsCrSLPJouLfeIMBHd1puklv0W3c0q7i+TvO3zCP
         bLJFuZzXe2AYFdR3epTA/zgzUVatm3UUKhLM/MV5y9etaGmHWRCsbchzbRCbL8wWd8et
         A95A==
X-Gm-Message-State: AOAM530PY6bCAuBE1AW91u5Rl6FlkIlk1xYotn+XVYPGjrFELIQhlRWK
        MMWrrs+D1Ps9MOqgvh7wwIsMssOeXtY=
X-Google-Smtp-Source: ABdhPJyW7vkaNh0PaEpaOoYYagFca4oW2bsF5xEK54yv6TkubEGC09bzXNErjsukUFxfN3ye8lLohw==
X-Received: by 2002:a19:bed7:: with SMTP id o206mr1351034lff.360.1603830332966;
        Tue, 27 Oct 2020 13:25:32 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id j23sm137806lfm.16.2020.10.27.13.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 13:25:32 -0700 (PDT)
Subject: Re: [PATCH v6 33/52] memory: tegra20: Support interconnect framework
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-34-digetx@gmail.com> <20201027100951.GA17089@kozik-lap>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2eee94bc-10a7-acef-3b50-7b6fd7ceba70@gmail.com>
Date:   Tue, 27 Oct 2020 23:25:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201027100951.GA17089@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

27.10.2020 13:09, Krzysztof Kozlowski пишет:
...
>> +err_msg:
>> +	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
> 
> You will print such errors on all existing DTBs. Since it is not a
> failure of probe (it is actually quite expected, normal situation when
> booting with older DTB), let's change it to warning (here and in all
> other places and drivers).

The existing DTBs will be stopped on the error message below.

>> +
>> +	return err;
>> +}
>> +
>> +static int tegra_emc_opp_table_init(struct tegra_emc *emc)
>> +{
>> +	const char *rname = "core";
>> +	int err;
>> +
>> +	/*
>> +	 * Legacy device-trees don't have OPP table and EMC driver isn't
>> +	 * useful in this case.
>> +	 */
>> +	if (!device_property_present(emc->dev, "operating-points-v2")) {
>> +		dev_err(emc->dev, "OPP table not found\n");
>> +		dev_err(emc->dev, "please update your device tree\n");
>> +		return -ENODEV;
>> +	}

The existing DTBs are stopped here.

...
>> +	err = tegra_emc_opp_table_init(emc);
>> +	if (err)
>> +		goto unreg_notifier;
> 
> This looks like the ABI break I mentioned around DT bindings. Are the
> bindings marked as unstable?

This T20 EMC driver wasn't ever used so far at all and this series makes
it useful. Hence I think it should be fine to assume that the T20 EMC
ABI is unstable.
