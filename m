Return-Path: <SRS0=4B4i=ZV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9524C43215
	for <linux-pm@archiver.kernel.org>; Fri, 29 Nov 2019 02:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730CD21774
	for <linux-pm@archiver.kernel.org>; Fri, 29 Nov 2019 02:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcqcwBt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfK2C1L (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 Nov 2019 21:27:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38898 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfK2C1L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 21:27:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id t3so13238983pgl.5
        for <linux-pm@vger.kernel.org>; Thu, 28 Nov 2019 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t99PgAEcDTrMbHbkn0VufWJ/LmM4ic7BKjRhA7eNd2I=;
        b=RcqcwBt6eY/UrWvwfYaBa+6RtBq0XGSmc+UQiEkU9UOJeNqj/lNbJrtRDcZbJLDsI/
         Rg8pj4oIy8uUjKscBC0oLZl1w5VJUVNuHOjQ7oWoDaGoFOyKAuoYf6Uvx2KXQOK3gE2O
         CbMGfNZeRXyR2ruuMfojy3+WWl+VSFbZ1qu33I93gsEg3dXSagHGePNZkGuUCfR9xTHw
         D6Rp4fOoV1P/yjtfg5U1rMFANI7ZQLfenHovGZGYyWKF0TDrR32mCR7YY8LqPaEG3nLE
         r03vzblIZ49fZ2sYEvStfOGKY4UlR7yAA6zgTsHVB2zRqtBmlhb6Gy52/cYFn+qqsgB3
         O1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t99PgAEcDTrMbHbkn0VufWJ/LmM4ic7BKjRhA7eNd2I=;
        b=TK/r2T0BJGdZCpXqka4akmSjKMsnVrg+yBVyVy1i/GPNfcILl+m1xWn4n6leV1v8P3
         8KcgsGYGYO5ASa5QlN3+j0s9ukrsW5h4AJAy9TI0fxLGVWT2zj3E6bfTOX1SeBeR52p2
         V2bQlr2If+XmUEgkO1sPpm2tnVM2XCI4F9+oqA5XF3aWKm1czDxeO3W2lvIzaVTj7b/i
         aF2QLglU/zxXGtBg61dqLJaaOhjqbpXLwc5wjfUIEo/csOIQL72fdtO6298PseOpxOlg
         i7ZKHtHycSZFa7jhFSjfSWXRB7V0xNp6DaXQze19V/993D/XbeGs55P9SoEO1c/+S8Yx
         HXag==
X-Gm-Message-State: APjAAAVsmf3s6fmF44wcnhtMgI61VTl4IcewTkkWf4PhFpps98Uv/wch
        8tclEIt9wqHkucwqOyDNrQlO5Q==
X-Google-Smtp-Source: APXvYqwQu4kSaLlq3LbFK2l2M8AthW8cvU/ZXw8ZZlj9vXim1BolXdXPBnjWsVUOT1XznPiXIWSAOw==
X-Received: by 2002:a63:9247:: with SMTP id s7mr14692233pgn.334.1574994428728;
        Thu, 28 Nov 2019 18:27:08 -0800 (PST)
Received: from localhost ([122.171.112.123])
        by smtp.gmail.com with ESMTPSA id y12sm12458359pjy.0.2019.11.28.18.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 18:27:08 -0800 (PST)
Date:   Fri, 29 Nov 2019 07:57:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] opp: Free static OPPs on errors while adding them
Message-ID: <20191129022706.rargieilar3dq3pg@vireshk-i7>
References: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befccaf76d647f30e03c115ed7a096ebd5384ecd.1574074666.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18-11-19, 16:32, Viresh Kumar wrote:
> The static OPPs aren't getting freed properly, if errors occur while
> adding them. Fix that by calling _put_opp_list_kref() and putting their
> reference on failures.
> 
> Fixes: 11e1a1648298 ("opp: Don't decrement uninitialized list_kref")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

@Stephen: Any inputs here on this series ?

-- 
viresh
