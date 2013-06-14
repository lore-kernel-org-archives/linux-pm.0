From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND][PATCH] cpufreq: stats: Add 'load_table' sysfs file to
 show accumulated data of CPU
Date: Fri, 14 Jun 2013 20:19:38 +0530
Message-ID: <CAKohpo=TNf=XK7S6_8Z92XvpBz-7jOqYA=p61c9qG3GSg7tzfA@mail.gmail.com>
References: <1370419882-16831-1-git-send-email-cw00.choi@samsung.com>
	<51BA7BDB.9070801@samsung.com>
	<CAKohpokL1PNsYXJvnrkYesUHhe4s9-HsZe_c5KW+toeHJep2PA@mail.gmail.com>
	<8166789.M9n1Uisvhs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:47948 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834Ab3FNOti (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2013 10:49:38 -0400
Received: by mail-oa0-f53.google.com with SMTP id k14so785798oag.26
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2013 07:49:38 -0700 (PDT)
In-Reply-To: <8166789.M9n1Uisvhs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

On 14 June 2013 18:18, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, June 14, 2013 09:41:13 AM Viresh Kumar wrote:
>> @Rafael: Would it be move trans_table to debugfs??

Oops!! What stupid english.

s/be/be sensible to/

> I'm not sure who uses it now.  If there are any user space tools depending on
> it in use, I'm afraid we can't just move it around.

Even I am also unsure about it.
