Return-Path: <SRS0=6yE2=3J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D45C33CB7
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jan 2020 05:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1923207FD
	for <linux-pm@archiver.kernel.org>; Mon, 20 Jan 2020 05:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmBNL68w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbgATFn3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 20 Jan 2020 00:43:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34729 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATFn3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2020 00:43:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id c9so7399844plo.1;
        Sun, 19 Jan 2020 21:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=64XMCd5LTgEtp+yMw+EJAZboO4/7kIhrsJP3cuFWUNQ=;
        b=jmBNL68wUeMsIeo9T7IR9gSDDPRP76eyffnTrd4o2SsieCYjnJvqwZ2/gCB4G5GxfB
         P6XSo/wrEm/Cvba1ZR2oAVjCJnQJUELWaVh9Cpa9WSkYGN5b+V5tYPSByNb26KwyBk0w
         KxzLSdZtoCRX9a6DS8r8P24EyWV8Kh+nShqoTrBfOnahbxZsmiRSykoYP6hvOoYdkQFE
         fJFtLQtZF2ZQ8M7nKkZcu34rzEWb0VScYmDJZNUaUGlDaZLT/PSanz7bQe6Mrjv3MvxO
         TeD7duqsc3SXhis1f+5cD/7Gy9DEXbn1TvQyaX0co6Cy7NH4smleOAeZLqQxoAibRSrk
         X5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=64XMCd5LTgEtp+yMw+EJAZboO4/7kIhrsJP3cuFWUNQ=;
        b=bj2bqL4Sqb184Hcj2qnyYXgtapI5mB2hS3sRjhD85rczs4hxDcWsM2W5/etqYpBru8
         +0gSFNN1yXmqk2XxwGcKrbfk7h/TIEIo5uxG0l6TdStkSa+TdVIbY4oWbSWWSU0xrYKW
         1CxD+aSMVOCZ4BTgSYqGIHs3Q1qWsQuf7uxWtSso92Chy8fx80dXxbuM/jt9DuRL5UFV
         ieH7dCPfNVHjX+z33FU1bElUj0V6/DpY+EgLKGMswSY3BMaERriofNXUB6Ksghbz4dTs
         cBLDwxdEDJK6Aozci3ugwDCl+BnL3mHeXBhoKKVMU0hQWbNykCGheIZ8lbijeJK0ZUf5
         Kc9A==
X-Gm-Message-State: APjAAAV/JML4QpF2gnJ67cSPw9yzn2T9GxD8G3uMgirkQBIXDeNxoyhe
        NS+0BjCQCxoaQXGqFrUh7Sc=
X-Google-Smtp-Source: APXvYqwsZKQ3dzCdikp0kMy3xYQVB4S6djt4GRgx6wrAUA6qZr+BJgFoB2KY0jXPL38GVfIpGgKDKg==
X-Received: by 2002:a17:90a:d78f:: with SMTP id z15mr21856717pju.36.1579499008199;
        Sun, 19 Jan 2020 21:43:28 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id 12sm38005809pfn.177.2020.01.19.21.43.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 19 Jan 2020 21:43:27 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:43:25 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v3] cpufreq: s3c: fix unbalances of cpufreq policy
 refcount
Message-ID: <20200120054325.GA5185@cqw-OptiPlex-7050>
References: <1578383599-11207-1-git-send-email-qiwuchen55@gmail.com>
 <20200107080145.7c4gxilnjjxjfqpc@vireshk-i7>
 <CAD1-QrohtJFLWDMCYmVs2G5WDcDN_E8xcsNZqJ428cEkohcB0Q@mail.gmail.com>
 <20200120052821.tvijbt3bzkn76yz6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120052821.tvijbt3bzkn76yz6@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 10:58:21AM +0530, Viresh Kumar wrote:
> On 19-01-20, 10:25, qiwu chen wrote:
> > Hi
> > Any progress about this patch?
> 
> I already applied it in my tree, it will be part for v5.5-rc1.
> 
> -- 
> viresh

OK, Thanks a lot!

Qiwu
