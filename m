From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 16:50:47 +0530
Message-ID: <CAKohpokb3S3czYB46JsDYggYBYi34CmRhjNGVJDO3wtLV7xGzQ@mail.gmail.com>
References: <3b19a388891fe997c6c7bc14463453c27312edfa.1404968266.git.viresh.kumar@linaro.org>
	<53BE75EE.6010200@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:42888 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbaGJLUs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 07:20:48 -0400
Received: by mail-ob0-f172.google.com with SMTP id wn1so813901obc.17
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2014 04:20:47 -0700 (PDT)
In-Reply-To: <53BE75EE.6010200@mit.edu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa@mit.edu>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Saravana Kannan <skannan@codeaurora.org>, "Bu, Yitian" <ybu@qti.qualcomm.com>, Stable <stable@vger.kernel.org>

On 10 July 2014 16:45, Srivatsa S. Bhat <srivatsa@mit.edu> wrote:
> Looks good to me. But I think it would be better to move the invocation of
> kobject_move() to update_policy_cpu() itself, so that update_policy_cpu()
> will do all the work involved in updating the policy->cpu, as its name suggests.

Its called from remove path as well ..
