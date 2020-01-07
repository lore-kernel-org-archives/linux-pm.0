Return-Path: <SRS0=gDq+=24=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A120FC33C99
	for <linux-pm@archiver.kernel.org>; Tue,  7 Jan 2020 09:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749662087F
	for <linux-pm@archiver.kernel.org>; Tue,  7 Jan 2020 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578390575;
	bh=ogXjqSIxjeLgCNP6W582GpPpUCMuyqnI9ulxLpXjyTA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ilznmKSW5NfwpG9RHhADjY8cRbOOgdOGO8tKr2LVUtU35R3xgtUYCC4l25Ski0edT
	 bFTeBYIIUDF8ZZwobRoNzkejynvb7NzR3XSwAzBLI94neDAghcOHTAhaSgzsCsKp1d
	 gQM8ag1Us2A2GJgFRQraO1UB5CNSaq9Dj9tsWEYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgAGJtf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:49:35 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43266 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAGJte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 04:49:34 -0500
Received: by mail-ot1-f52.google.com with SMTP id p8so39251848oth.10
        for <linux-pm@vger.kernel.org>; Tue, 07 Jan 2020 01:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogXjqSIxjeLgCNP6W582GpPpUCMuyqnI9ulxLpXjyTA=;
        b=HrxHl67WEj/T2+pFf7Mx2svQ0ga8VfBJ/oydwXiZPT6w/KyOOT2gtseD93z8q7nL0T
         cL+ZPdHVtk1nqwJ3UYpDGrsE1JO/F7DGJeoiTJIMKq0iCuF18XlSiZKNHBKFjLvCpQin
         zA9FkcGMKftEljvFhP05VjrbGJlz1absXR9bIc4VYu7tllXllkNtALDqwcG+bVzNPFs5
         DW1w9+dEarS1KM9AGWncKUfb8eyj/Cpy7LcPW7tE3NkviiYGhWTIbTU9acDo1uW7DKy5
         c+bHU1BkFBqg3KVDHk/PHrVfiBnZCuYuKiCnv1vqcsRSofIWbZrQ5YXd8+aJUIYsO0IV
         0THw==
X-Gm-Message-State: APjAAAWXG4clzH4XieIQIIMt0pDDSkzAEfzyCOMfjgQdNR4Vqfn5Jdo3
        KRIuC3MTBIv58CkPi/UXd2j8tH6Q/J8u1Y4BTJ4=
X-Google-Smtp-Source: APXvYqymTeaIeKxDdp3wUs9KVFyo/WTZY2mOlOhswtmOyBfT7eoXPlmOTbVClBO0jE6p5pEB1K9deDnXOXr5rwFY7+g=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr123233651otd.266.1578390574299;
 Tue, 07 Jan 2020 01:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20200107064634.dqudplqrp47elm64@vireshk-i7>
In-Reply-To: <20200107064634.dqudplqrp47elm64@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 7 Jan 2020 10:49:23 +0100
Message-ID: <CAJZ5v0jdzW-hFO2-nexWN3rv7t1ogvqtJ9P2SD497MNZyh_K8w@mail.gmail.com>
Subject: Re: [GIT PULL] cpufreq/arm/fixes for 5.5-rc6
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 7, 2020 at 7:46 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi Rafael,
>
> This pull request contains a single commit:
>
> - Blacklist Tegra20/30 for probing by cpufreq-dt driver.

Pulled, thanks!
