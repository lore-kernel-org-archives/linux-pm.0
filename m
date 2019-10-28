Return-Path: <SRS0=0rhz=YV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DF0CA9EC1
	for <linux-pm@archiver.kernel.org>; Mon, 28 Oct 2019 17:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16D921783
	for <linux-pm@archiver.kernel.org>; Mon, 28 Oct 2019 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572284144;
	bh=1pGl8wS/kA7QWDCSMr3u2WpdYGE0b+F0m3AK76EPjJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dBlaFztHQpue03YMcMKNEsVv23FnxyX67VOB+3Or0BjghVnmbGWtJsunKx4rDwuBa
	 oHjYkbxnmMRrbd4ieWwHHimNk7sXjjoVTE9576Sg35oN/HylcPcUJQxD6z+vD/AT6C
	 x0Jf+MNJQX/2Ijnwa2K9Jak8q204xjatOlUwAXmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfJ1Rfo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Oct 2019 13:35:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37853 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJ1Rfn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 13:35:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id e12so8435956edr.4;
        Mon, 28 Oct 2019 10:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dlbkLkbjNwkW8dWaTCD1qZUiGkWumkyUbrY4hy+PP0=;
        b=PnottxPjqEi8TbNnyEKb6HLm8XjR8T/0aJm9XOa7YYk9xZm0QZblqiSl3R3Lw6rEeU
         Hi8CLL4n13+4DjoscXA1xlUEc2RNkPWoHO0y/gTHzG3kUHslIIXIPLgfzGFbCEiYNs+a
         eFFs7EvnN8RdyFgaDsw8yGImQS3YPhJ/LyGcQm2fYHp9yqhODEasNR5gk0AzaWQSsPJ/
         R1XadkYa8GUfVDvCv9dVlbeUj/GRBcpJxpCmXO5jpoMkuwqBSyrnB6HrErVi7ubv83M4
         OwZO7CMS4kX7XgPZyMGLjvNee10fACbJ7C9VHOUxO1QnewwrZjc70/kyExSXiivy65AD
         X0Yg==
X-Gm-Message-State: APjAAAWokOPmgnO04exvBVg6+lihM+fkseOC01ZI/FdxFk8pyyjU9iuI
        3pXO5ruHK9M9ZHRo7hLBCLTvnBtx
X-Google-Smtp-Source: APXvYqy34BMLtkw8CEAwuKj/UeFjOMF1P1pIJI/GgyugK8iJZkPbVsQ8W9s1ePT5wtn+zaKQGhDcow==
X-Received: by 2002:a17:906:1c97:: with SMTP id g23mr17892494ejh.66.1572284141338;
        Mon, 28 Oct 2019 10:35:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id x6sm601095edc.50.2019.10.28.10.35.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 10:35:40 -0700 (PDT)
Date:   Mon, 28 Oct 2019 18:35:38 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, vireshk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 1/3] soc: samsung: Drop "syscon" compatible requirement
 from the chipid driver
Message-ID: <20191028173538.GA14395@kozik-lap>
References: <CGME20191028152057eucas1p1d6b4252e9ce3f15c0d81e6941a62d2be@eucas1p1.samsung.com>
 <20191028152050.10220-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028152050.10220-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 04:20:48PM +0100, Sylwester Nawrocki wrote:
> As we dropped the requirement of "syscon" compatible in the chipid
> nodes rework code acquiring the regmap to use device_node_to_regmap()
> rather than syscon_node_to_regmap().
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/soc/samsung/exynos-chipid.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof

