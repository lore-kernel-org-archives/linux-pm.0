From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 1/4] cpufreq: Add per policy governor-init/exit infrastructure
Date: Fri, 22 Feb 2013 07:49:59 +0530
Message-ID: <CAKohpo=tkzFgxpUHaVBH+U8ZQ+vyYFT1c4zrDp8NhRzEPxnouw@mail.gmail.com>
References: <cover.1360568193.git.viresh.kumar@linaro.org>
	<3793606.bilcxohA80@vostro.rjw.lan>
	<CAKohpom8HiBEXE54BL72s-nWaeXzSRTrp7=MQKrJcon17T9tXQ@mail.gmail.com>
	<6210802.HjCYHcMl5j@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34281 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab3BVCT7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Feb 2013 21:19:59 -0500
Received: by mail-ob0-f174.google.com with SMTP id 16so168414obc.5
        for <linux-pm@vger.kernel.org>; Thu, 21 Feb 2013 18:19:59 -0800 (PST)
In-Reply-To: <6210802.HjCYHcMl5j@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, linaro-dev@lists.linaro.org, francescolavra.fl@gmail.com, toddpoynor@google.com

On 22 February 2013 07:51, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, February 22, 2013 07:38:12 AM Viresh Kumar wrote:
>> No. These are used atleast for ondemand & conservative.
>
> They will be after the next patch, you mean? :-)

> Well, it appeared so from the next patch ...

Yes :)
