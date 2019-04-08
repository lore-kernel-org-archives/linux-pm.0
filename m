Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DA0C10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A0C20883
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PoFroFYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfDHKow (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:44:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40848 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfDHKow (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 06:44:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so7394176pfc.7
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 03:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Do567jb5pvMfMDC8A/0Ct++Ouy5BDdPJlPi9HiPjOgI=;
        b=PoFroFYmQDL1qoqLuT2Z2InIhcdfN9or+hy3E9o1C3kWliyeQdCWF8imcV+IRiqDXq
         Q/D9HQLX96O4hpY6rhOj0v5KYfQe/tvP9fWOFYPPFhrUNbyZDLwo4+TV1Ghz2qrB+BR6
         nzk6Cr7ixSHG6f6jUdsSGiFLJ+i2f6RWwf1mL31TeSS51Xwr/6U1QnumIqJAFF5wFm3M
         VRBPRoWabVqxV1BjBQQxKFvjrL5swvttWiBxQo34VxsVK/IU2gLjbtXNHSIBW9mI5TbK
         IfbEsyp95cilYFZ5Q/YuiQ6Olq8uPlUVvN6dLJiRcEbCMr7Mhwov0kWstPzbpyxpWUZW
         n/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Do567jb5pvMfMDC8A/0Ct++Ouy5BDdPJlPi9HiPjOgI=;
        b=MwSiAg0pAEJHXc/+gmwlK2r7VjH6UQjMIMPtU/Z3dT/jFvpq8Zw0OEEIOYsC+3Ub7u
         3FhL9Ssj1+SO2C4gN20E+OF622e4OdtgwDW6LIwukkdzf7POr5MGpCP+ZVA2jJLawRqb
         jmtouCps6RNrP+moeAMHdUBRv7jZDMOQOSTZSBFDdCFIPmGQlZuD2PRWALhi5wZf3wD1
         FgmByIHf0+3CLR6cMSxGB8NwgdlTsGqm6s7B8JR0truKzYpsPN9PpUDbYkSvyTPKg4Qx
         /SHa0E6uro7BL/D0VC71Pi9rsYuDKPokA5myxawvbe/v6ezKTYSTUAIhPqpQsXd4zV2v
         fmeQ==
X-Gm-Message-State: APjAAAXSuxaUko3JGsXLgVFUFMehDoIP9uzJsu9aqaXejAAKspv2j4RN
        05APDwwL+XkxLTpQpqa1unHgtg==
X-Google-Smtp-Source: APXvYqxscKB0OBTYsfDN7tA/run04HM83o8l+gcII8Ydvxco46COhIHtOB9oi2j9m8vyGhbORh2deQ==
X-Received: by 2002:aa7:9aa8:: with SMTP id x8mr6928766pfi.193.1554720291887;
        Mon, 08 Apr 2019 03:44:51 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id k65sm57380024pfb.68.2019.04.08.03.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:44:51 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:14:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        Sricharan R <sricharan@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/9] cpufreq: qcom: Re-organise kryo cpufreq to use
 it for other nvmem based qcom socs
Message-ID: <20190408104449.zqbamhcrjheanlgt@vireshk-i7>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-3-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190404050931.9812-3-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190408104449.6YXG7AqkozeJfDhzH-PuUsapyOK0UVsJ0iuxwF7RKQo@z>

On 04-04-19, 07:09, Niklas Cassel wrote:
> From: Sricharan R <sricharan@codeaurora.org>
> 
> The kryo cpufreq driver reads the nvmem cell and uses that data to
> populate the opps. There are other qcom cpufreq socs like krait which
> does similar thing. Except for the interpretation of the read data,
> rest of the driver is same for both the cases. So pull the common things
> out for reuse.

This is really sad for me. The driver was added in May last year and I am quite
sure it would have been known at that time itself that there are more hardware
platforms which will end up using this driver because of the similarity in
hardware. Not that you (personally) could have done anything about it as you
weren't there then, but it should have been taken care of by the then
developers.

Anyway, its okay now, can't do anything but rename things.

-- 
viresh
