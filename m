Return-Path: <SRS0=UdxF=CN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92292C28E83
	for <linux-pm@archiver.kernel.org>; Fri,  4 Sep 2020 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61FB82151B
	for <linux-pm@archiver.kernel.org>; Fri,  4 Sep 2020 12:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSRbN12q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbgIDMHO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbgIDMHN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2020 08:07:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A02C061244;
        Fri,  4 Sep 2020 05:07:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so7640241ljo.5;
        Fri, 04 Sep 2020 05:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qArgLGR5u08jxqjeiIaKBsm2Gby+9FNWFXKhm4/XNe8=;
        b=WSRbN12q9LW1Lj8lPIpnEH31mQEURVGd3tAVeqqpORt/L7v2MClTqOe3bm5ACJ4ZY5
         kBeKWCEB9W2g7A9vlHe4jqeQW6yQOC1N8VElCh4+IpZF+Ysb3QZosgJ65dd1Xmog2JA9
         FsrUQjpwoSOp9NtWfVqG6M9cIioux3TV2tXmZU33dVBV6vKTvG1bOQZmdld0tFt6oXr/
         U2ou93Jm0rYmfnMeHBWiJEJRBdbV5Nv2zTO9K5t8Vz60EIIDUUJHeLDKzr4PI8Q8B6s2
         ogHUQBEsfuXNFPfOR9mB+AxHaZe/iit5Wzq+WDw/rIqNySKMLfW7lV/iTDOMEvcwe3Be
         MyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qArgLGR5u08jxqjeiIaKBsm2Gby+9FNWFXKhm4/XNe8=;
        b=mYk8MrWdL76TJSYvtlnSTwyp2zx0uedMyxCplu4jsyTZSiTPpwmw7tYnMMkKd9FUtf
         QJ2SWWr2p6QyStM2xAIvJPmv35m0dEOabYzjmFcyvRxqsctoo8cdXyzavnvlS5S5w6My
         QW0Tu/mZbp24BFcVShM9YL1qVUbcthM+y0EnRxfY0/r69aLiHP4hk8EIPWKl4KjokJZS
         etBYkedJw6UKLtu20XVJiIpHw9owPSalNWhwvzOrFq48vW/TRuFD3zpfuvJ48HPUVVz8
         sKsqvjySwP9J/MKU9szsLihXV2AwrE98Xxk7Yt7fOVre6Nat6zbQfgBWlYBTIgKlOWvR
         b4DQ==
X-Gm-Message-State: AOAM532mbLswa/DxjoaL0fo/Cwgae2bpfdsZgHK6Wo/ZvxcJBLwmyZk3
        YcMZSa4mBmeDHfVM1MBUykI7b6AGSMg=
X-Google-Smtp-Source: ABdhPJyyU60zq5tUu6ycbGZKp2YIc7fIwrUFaiI0p1yTQHkL7RZ5ksQ1SgtGs9RFEJegTpoNeBtUIA==
X-Received: by 2002:a2e:a16c:: with SMTP id u12mr3251357ljl.266.1599221231300;
        Fri, 04 Sep 2020 05:07:11 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id l16sm1261285ljb.72.2020.09.04.05.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 05:07:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org,
        linux-tegra@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20200830185356.5365-1-digetx@gmail.com>
 <20200830185356.5365-2-digetx@gmail.com> <20200903161022.GA2707794@bogus>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <790dbb23-7422-887a-3f11-5ae55bb916fa@gmail.com>
Date:   Fri, 4 Sep 2020 15:07:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903161022.GA2707794@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.09.2020 19:10, Rob Herring пишет:
> On Sun, 30 Aug 2020 21:53:51 +0300, Dmitry Osipenko wrote:
>> Add binding document for the ENE KB930 Embedded Controller.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 66 +++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/ene-kb930.example.dt.yaml: battery-cell: 'operating-range-celsius' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/supply/battery.yaml
> 
> 
> See https://patchwork.ozlabs.org/patch/1354004
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

Apparently bot uses outdated kernel.
