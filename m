From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] cpufreq: fix governor start/stop race condition
Date: Wed, 12 Jun 2013 15:01:23 +0530
Message-ID: <CAKohponeWuaXPah4s9GjO-fLwQNuyKidUFosN1iE+e7bngDPdQ@mail.gmail.com>
References: <1371028189-15758-1-git-send-email-chenxg@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34386 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab3FLJbX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Jun 2013 05:31:23 -0400
Received: by mail-oa0-f48.google.com with SMTP id f4so4920077oah.7
        for <linux-pm@vger.kernel.org>; Wed, 12 Jun 2013 02:31:23 -0700 (PDT)
In-Reply-To: <1371028189-15758-1-git-send-email-chenxg@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xiaoguang Chen <chenxg@marvell.com>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, njiang1@marvell.com, zjwu@marvell.com, ylmao@marvell.com, chenxg.marvell@gmail.com

On 12 June 2013 14:39, Xiaoguang Chen <chenxg@marvell.com> wrote:

>         ret = policy->governor->governor(policy, event);

We again reached to the same problem. We shouldn't call
this between taking locks, otherwise recursive locks problems
would be seen again.
