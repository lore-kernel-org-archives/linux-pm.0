From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: Prevent problems in update_policy_cpu() if
 last_cpu == new_cpu
Date: Thu, 12 Sep 2013 12:14:16 +0530
Message-ID: <CAKohpomsHSMWmGAACurpN1dYSsvHvH6w_SDpQ5c7CE_1R2MGMg@mail.gmail.com>
References: <20130911201239.7832.72612.stgit@srivatsabhat.in.ibm.com>
	<20130911201334.7832.49714.stgit@srivatsabhat.in.ibm.com>
	<CAKohpomgd8X4UwFaVtJ49=CXTg2cyEirvD4_mj5ohqS5fk064Q@mail.gmail.com>
	<52315D7D.3030406@linux.vnet.ibm.com>
	<CAKohpoktJkAWf2xvRKmz3ZUW3wiRqHYdaR6d_HKsXZPXiiK53Q@mail.gmail.com>
	<52315F98.8020305@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53260 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab3ILGoR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Sep 2013 02:44:17 -0400
Received: by mail-oa0-f46.google.com with SMTP id o20so10238880oag.5
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 23:44:17 -0700 (PDT)
In-Reply-To: <52315F98.8020305@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephen Warren <swarren@wwwdotorg.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 12 September 2013 12:00, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Looking at the rate at which we are bumping into each others thoughts, I think
> maybe we should switch from email to IRC ;-) ;-)

Unbelievable, Even I thought so this morning :)

One more thing that I wanted to say for some other threads..
Your changelogs are simply superb.. The amount of information that you put in
them is fantastic.. I never do it that way and so get caught by Rafael a number
of times :)

Need to learn this from you for sure :)

Btw, I am on Freenode for many Linaro channels.... Where can I find you on
IRC? (Haven't sent this in a private mail as others might also find it useful)
