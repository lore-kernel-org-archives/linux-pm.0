Return-Path: <SRS0=xQv0=SK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E08C10F13
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 10:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211B8213F2
	for <linux-pm@archiver.kernel.org>; Mon,  8 Apr 2019 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AMKCnuEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfDHKqm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:46:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41188 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHKqm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2019 06:46:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so7119988plj.8
        for <linux-pm@vger.kernel.org>; Mon, 08 Apr 2019 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MUfTj0U/AFRbGfrf89mQyaA20QBLVJpQ0dy99tQO6LY=;
        b=AMKCnuEvLEa0XGxOrAE+IB7K7WxkUyLrwAjvxZ9eQqXaGqJM9uF0xMXweyTKKoAuwZ
         n/vQkaQTUEyuBmDUmSn8DbkOlTl3PF+TgqkEqXpSKiT+H56Jy/Z7AJ1OVbjLkZstYI+a
         mkilHOLW72ksjNp9lem0sW7bmHmU3wlmbQmBDvp58KcWwX6/VQMC8KOxPz71j51ZyDxQ
         vbnln3Ejn7LQkvCVVVOcMa9loI0ZJkspJJYpbfYoOeONQF6DIq/yTpYlwcLxa2n8K954
         OH9a+vCvu+3un9ICTUAwjuAQKy8kVlKa3jdW1BULveUH5oPYaSHieNShUzEZvR4yOc33
         hBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUfTj0U/AFRbGfrf89mQyaA20QBLVJpQ0dy99tQO6LY=;
        b=FLJO4UzfQRLJgu5v9fvaHa9cGGtbEv9G1WPwgqsxcrYE30n1zzZxdW6XCPrTKus/Fk
         OnjMO36MdZyAZJUBt0PKYANMC51qs97RxW5HSqnqU4msKai/PN42U60w15NRptQ99s/u
         cF/1UdTY9nSl4i4tbIm0rzA4oHY8mLNEd1yMSy9x/DHEBM+htP+KQ6aY2nRbUgjEzsZb
         i7SrnLQnjeTzsQxLKYhO37qGciNZcK8ZFMlaGlB2wo04KpJzlvd7QbmSGJlWQykC31XN
         HAXoXqq2P5edcKOGMGCoH99wj9Q4lEkjnb00VSh5h7cbLxyo12WvhsfiQs9A7BuoA+ia
         8wUw==
X-Gm-Message-State: APjAAAX9MUXEjn0WGYitQephyf6oZvPEQOtDBdyovmWAe/my98ayyLJX
        Er+ZMuTQjXoUgR/+A0E0QopZ+w==
X-Google-Smtp-Source: APXvYqxP/nmAlCh7SMX1H6bVQibWuwf4p42N1CsPTFWWEsj6r/cIM8lurc3N3m1RYbhKNfFZ4xAI6A==
X-Received: by 2002:a17:902:2a29:: with SMTP id i38mr29724845plb.22.1554720401271;
        Mon, 08 Apr 2019 03:46:41 -0700 (PDT)
Received: from localhost ([122.172.162.162])
        by smtp.gmail.com with ESMTPSA id q77sm13532822pfi.45.2019.04.08.03.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 03:46:40 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:16:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, Qais.Yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Message-ID: <20190408104638.43ttxvxhwbp6ba2u@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <2575955.AqKVkXLaMl@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <2575955.AqKVkXLaMl@aspire.rjw.lan>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190408104638.4-0m1ECiqyECOigoq7isFC8FU3M44hV4PGZ5IkEhM1s@z>

On 21-02-19, 12:30, Rafael J. Wysocki wrote:
> On Thursday, February 21, 2019 12:29:26 PM CET Viresh Kumar wrote:
> > Hello,
> > 
> > This patchset attempts to manage CPU frequency constraints using the PM
> > QoS framework. It only does the basic stuff right now and moves the
> > userspace constraints to use the QoS infrastructure.
> > 
> > Todo:
> > - Migrate all users to the QoS framework and get rid of cpufreq specific
> >   notifiers.
> > - Make PM QoS learn about the relation of CPUs in a policy, so a single
> >   list of constraints is managed for all of them instead of per-cpu
> >   constraints.
> > 
> > V1->V2:
> > - The previous version introduced a completely new framework, this one
> >   moves to PM QoS instead.
> > - Lots of changes because of this.
> 
> Well, thanks for working on this, but I'm rather unlikely to look at it in
> detail before 5.1-rc1 is released.

Ping!

-- 
viresh
