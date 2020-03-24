Return-Path: <SRS0=R0/j=5J=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503FCC43331
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AA920714
	for <linux-pm@archiver.kernel.org>; Tue, 24 Mar 2020 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585074379;
	bh=94PgeoB+p2WY6XFVXPILv+rmdwQzZBt2xnAqRW92a4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tM1IDeWk4ImrqsNigM3rzmHvzlU6qKblZcdUgJLXMIH5ovZGJPIiO4evAmeIPEC9e
	 tF9yqoWIJ/TYNT6324g8c8wpW+/9lxl5/dvIDWvf8cEYNfGKCcg5Qn3tw0EX7NjuNE
	 JCRkOr/kcmW+uBKgeYr27Llhu0NSaF0RHe0lPWnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgCXS0S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:26:18 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36645 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbgCXS0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 14:26:18 -0400
Received: by mail-qk1-f196.google.com with SMTP id d11so20367676qko.3;
        Tue, 24 Mar 2020 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VKDCXEZ42UY913CTtFDT6Viou96lkFeyc6FJl6g05Vg=;
        b=AkI4Xkx1tlFJcJ9dNLecf4+W/yiyVYQzQJjxQEP3fsUyxtJlsDPsp2922A08nOHUqt
         Raz6pWjrCl2Hhym8BGoSwUNuuPSH9d7vYfRnfoGLRBR/CRLOXfi4zD6n1d5fSUpIvQFH
         G5SdqFXcT/F1KCp2Jmv8aiswNEn5y/cJFvk9n9q+ccGDLGwlnioNCKkDSHsNmzL95JtU
         pURc9Y4b8prbYmhRvfO+VUUnf+r33J9ni46guh0TYipbbdvAZhJ7v5nxJcAVMvEu04Wz
         kEBSWZbCndALY8ZvcfA6P1KQIOyEPipSsEPBC1fuESUBy2/Xy1bELlSr4o1v/OGJeB1M
         HkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VKDCXEZ42UY913CTtFDT6Viou96lkFeyc6FJl6g05Vg=;
        b=YK4zi2vsEO8fslwdFCmHmI44nU73DBTi5VB68l9zG+KPb/Bn+HzE8mLoj66fQ4CbKT
         V5rKgLIe43efmAT6PrI083fz6nAf7OkdQyUuVKlkpzr57ga9pBzHOUi6vfn10Su5+g5S
         +UO594/OVoJ/fMHgNiH1RPuexbewUlDquIvrHDvtURtW4o5ptByqkoDlHgFv6uDuV8xc
         0yOaYIoCpGzDkI1v48iwPtA9/zXwy96HKZ0BpTYqrtCCUWZ2B99czqp88AfmBgIUMXLJ
         vFD4BCpScYARiHhvkgclYj/CoeXgQda4Ykh/63flEkfl3Iv8nziUW9e3G0pYvusoEXtE
         2t3Q==
X-Gm-Message-State: ANhLgQ04MVZBMeaWRp2YDl8SmMzX5PYQXt/8mecEQ7St1nL0U/50l8jj
        dcmkp7HCqUHLF3n4WyY0VM10rYHqGeo=
X-Google-Smtp-Source: ADFU+vtMSJC8sWVJYJ3arOh+M32uZq0yu5b1h8oEMGbdpbxd7Z3KHLEAw55hEBb1joWKeLW3rp8Z0g==
X-Received: by 2002:a37:a208:: with SMTP id l8mr26130803qke.302.1585074377272;
        Tue, 24 Mar 2020 11:26:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::19c2])
        by smtp.gmail.com with ESMTPSA id m65sm13998087qke.109.2020.03.24.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:26:16 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:26:15 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Marco Ballesio <balejs@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net,
        Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-pm@vger.kernel.org, Minchan Kim <minchan@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200324182615.GF162390@mtj.duckdns.org>
References: <20200219183231.50985-1-balejs@google.com>
 <20200303134855.GA186184@mtj.thefacebook.com>
 <CAKOZuevzE=0Oa8gn--rkVJ8t69S+o2vK--pki65XXg6EVuOhMQ@mail.gmail.com>
 <20200320201038.GB79184@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320201038.GB79184@google.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,

On Fri, Mar 20, 2020 at 01:10:38PM -0700, Marco Ballesio wrote:
> It might also be desirable for userland to have a way to modify the behavior of
> an already mounted v1 freezer.
> 
> Tejun, would it be acceptable to have a flag but disable it by default, hiding
> it behind a kernel configuration option?

Given how dead-end this is, I'm not sure this needs to be upstream. Can you give
me some rationales?

Thanks.

-- 
tejun
