From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
Date: Mon, 20 May 2013 10:59:42 +0530
Message-ID: <CAKohpon97dbLDF0xU7vhf5V+UVeJv7WdeMuZ1jXLUTey2+gD2A@mail.gmail.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
	<CAKohponkFB7ND38jv5oGnQLx8cq0b=uHTCmL3EERe6P54ijYhw@mail.gmail.com>
	<093901ce509f$afe92f40$0fbb8dc0$%kim@samsung.com>
	<2001452.Fn2HjLbNED@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:37781 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443Ab3ETF3m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 01:29:42 -0400
Received: by mail-oa0-f45.google.com with SMTP id j6so7287399oag.18
        for <linux-pm@vger.kernel.org>; Sun, 19 May 2013 22:29:42 -0700 (PDT)
In-Reply-To: <2001452.Fn2HjLbNED@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Robin Randhawa <robin.randhawa@arm.com>, Ben Dooks <ben-linux@fluff.org>, linux-pm@vger.kernel.org, patches@linaro.org, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve.Bannister@arm.com, arvind.chauhan@arm.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com

On 14 May 2013 18:30, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, May 14, 2013 09:36:42 PM Kukjin Kim wrote:
>> Viresh Kumar wrote:
>> >
>> > On 13 May 2013 16:21, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > > That doesn't matter I suppose.  I can take it, but please rebase it on
>> > top
>> > > of current linux-next.
>> >
>> > I have already done that (attached). But i wasn't sure what Kukjin wants
>> > as
>> > he may report conflicts again and i will ask the same question for 3.12 :)
>> >
>> Since this missed last time, this would be sent to upstream via samsung tree
>> again. It means the conflicts should be handled by myself.
>>
>> Rafael, if you don't mind, let me take this into Samsung tree for v3.11.
>
> Sure, please go ahead.

Kukjin,

I hope you have already applied this for linux-next?
