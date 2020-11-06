Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664C1C388F2
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192D92072E
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 18:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604687504;
	bh=LMBXdAsn9DT6OW8ld/o150F+tXkg+XnpoGWXZIqkFHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yki0nCtIP52P66+Z8xp3d2KUxpf2G8i3NUsvr39m5dVYU6xCqVVLkIM0BzELTtL+7
	 JTHJLUqg0muMnH3AbXHs0aYN1uXdQko0Te6suojWdZSHmw6nRaDXJ5GhniH12e/YO8
	 BE7UWipkuFNt3lXydL37tVa5aY3DFFsaQ4fvHa4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKFSbk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:31:40 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36947 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgKFSbk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 13:31:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id cq7so2041415edb.4;
        Fri, 06 Nov 2020 10:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m3JWw/czlUscK3v/4x+B2bi2sLrcQuLQAHZQ7qhezhc=;
        b=cMLSgmOCjquqqDrJ9NhN70XAkC2NW6B2pgNMoVQnhV9q30J66o3pEpkEv0bk5Prgcx
         T7DuiDqWZX2AhyeSmHHe4B3oNw9u2RXEQoErvBu8wud/9rjYnY3hoNKUSoc+nLerIP7Q
         kmnYlViKOXu9BEkOlqlqO6/Wm/OeLKNcd3TLaXX6vYLTCol/pZjl34gcMLYv/d0+NHme
         fMAhK0tXMSeBqADcIWADzNZkWmbCrrxh3XjNxRLXQFEJBbiCvFV69OlPOJSaLkjAMGRO
         6eO9oUvYYJnljkQww2CD5z7hpvmOCPX0uyJOaskf3Huj8RxG/4JM46L0AYJwODj3ahA/
         Z4Og==
X-Gm-Message-State: AOAM533PuTk1Pt0Fh5pcWxqQ6AzXuXQkrBw+XDpS+mrhnYo+k2cs6P2h
        Hnsfy4dd+YWdOW2e2yUJpJQ=
X-Google-Smtp-Source: ABdhPJyPCnCNyqQEGMYqe6aJV5PmuafkDpPyxmHMBtBR3WyFPPgLZQFHhyXhGi5TtzLjvkxw+Fwlwg==
X-Received: by 2002:aa7:d1d8:: with SMTP id g24mr3483957edp.324.1604687498112;
        Fri, 06 Nov 2020 10:31:38 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id fx1sm1481160ejb.12.2020.11.06.10.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:31:37 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:31:35 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
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
Subject: Re: [PATCH v7 09/47] dt-bindings: memory: tegra30: mc: Document new
 interconnect property
Message-ID: <20201106183135.GI65086@kozik-lap>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104164923.21238-10-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Nov 04, 2020 at 07:48:45PM +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied.

Best regards,
Krzysztof

