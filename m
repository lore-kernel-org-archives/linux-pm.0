Return-Path: <SRS0=beHt=CG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D3AC433E2
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 07:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF02078A
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 07:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J49JeyBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgH1Hr0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH1HrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 03:47:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942ECC061264;
        Fri, 28 Aug 2020 00:47:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e11so260093ljn.6;
        Fri, 28 Aug 2020 00:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xABvBOjUjE/6Ma/canmyIeuEwfrJZ5bd2hFxjrXapqc=;
        b=J49JeyBZ8CHjUeC7b8mxVVNC6Kl0wD5oJ/r6YkyFBnpK496fQ7RBRa1j70Mticb62Z
         bAMWB6pq7vmyp0BgDEPbzbpCL8DpnG0+qCP/H0+nbl0kHVY1/5BOXNMzp9oi4jOlMgWK
         thlr3IyerR7GrUhWgd/wcaLpCxwkxTbZYVr1+CwatjQweDkFrhivHIesoEXMrMZgyxu0
         WrQhgRmVCjV1xOMtdpKcfK+isHNKlPBbhXfKPxJdbdDT+SAwxVxi1QWZkTDNAg2VYGHS
         q6VDZCiEg8K/48FsP7nfmoEtc7lGSknVNR/yUAbirSVf3H2LeH2T0Ar38RqUcncjtfbF
         wAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xABvBOjUjE/6Ma/canmyIeuEwfrJZ5bd2hFxjrXapqc=;
        b=Ws10c8vRzycNo6dzHOuVxUc/B8dOAhvNKrPGKak07GIZIGPL6V7GCsO40PSrYAuBt/
         2fs3k1CnWeYg7kCEip9Yi5N8GpvkAfw4zl0KooU7SMvVkhvdfFBj+9IdSfy9XG4dC/HM
         uF9cma8t2MLqybhp0Tb/zS3zt57mC1INuYLHsAy/48ItgVWyAJxr0HSA8Pj1SKL2lF/K
         XIIJ92nLUECxuxdWvPSCRIITdcoprx546ZGYjyW4LnNx4kOETFRGIV+RtrDF7KfG4ICG
         mfYp9mSq8UebSeuyJIjKO3klC3zY9R1iVyTlXyBTcfAqHA9AVABL1nqL+eC/lvT2dnGx
         wnNw==
X-Gm-Message-State: AOAM530w8Z/Sfz0OvvPo5peIQCkKJPcbG3FdmN0b4uVmwlTf2uvBQgcH
        c0WI/C07RShhhun9yjE8pmc=
X-Google-Smtp-Source: ABdhPJweblXGkrN2qRcyBTA4qWihpObd51CJgYkbAEjhJrnOKbbp/5xzWti/go/hwhQXkKLoF7T8sA==
X-Received: by 2002:a2e:8689:: with SMTP id l9mr296089lji.467.1598600843035;
        Fri, 28 Aug 2020 00:47:23 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id i16sm38333ljn.100.2020.08.28.00.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 00:47:22 -0700 (PDT)
Subject: Re: [PATCHv1 0/2] power: supply: smb347-charger: Cleanups
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20200826144159.353837-1-sebastian.reichel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4d02de0e-7345-a937-7fce-66f4438a8144@gmail.com>
Date:   Fri, 28 Aug 2020 10:47:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826144159.353837-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

26.08.2020 17:41, Sebastian Reichel пишет:
> Hi Dmitry,
> 
> Please check the following cleanup patches for smb347 driver
> do not break functionality on your Nexus 7.
> 
> -- Sebastian
> 
> Sebastian Reichel (2):
>   power: supply: smb347-charger: Drop pdata support
>   power: supply: smb347-charger: Use generic property framework
> 
>  drivers/power/supply/smb347-charger.c | 305 ++++++++++++++------------
>  include/linux/power/smb347-charger.h  | 114 ----------
>  2 files changed, 167 insertions(+), 252 deletions(-)
>  delete mode 100644 include/linux/power/smb347-charger.h
> 

Hello, Sebastian!

Thank you very much, very nice cleanup! I checked that the DT properties
are applied correctly and everything works properly on Nexus 7 after
applying this series just like it worked before, no problems spotted,
charger does its job and battery is charging up fine!
