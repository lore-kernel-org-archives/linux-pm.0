From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH resend] cpufreq: dt: disable unsupported OPPs
Date: Wed, 1 Oct 2014 08:59:17 +0530
Message-ID: <CAKohpomH6V3akJjSQZS-xWubC6xUzfJihWcNT0FpYM98qvayNQ@mail.gmail.com>
References: <1412090950-20835-1-git-send-email-l.stach@pengutronix.de>
	<2197100.Nocxtjmizk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:41157 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbaJAD3S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 23:29:18 -0400
Received: by mail-ob0-f176.google.com with SMTP id vb8so241790obc.7
        for <linux-pm@vger.kernel.org>; Tue, 30 Sep 2014 20:29:18 -0700 (PDT)
In-Reply-To: <2197100.Nocxtjmizk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lucas Stach <l.stach@pengutronix.de>, Mark Brown <broonie@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 1 October 2014 01:23, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, September 30, 2014 05:29:10 PM Lucas Stach wrote:
>> If the regulator connected to the CPU voltage plane doesn't
>> support an OPP specified voltage with the acceptable tolerance
>> it's better to just disable the OPP instead of constantly
>> failing the voltage scaling later on.
>>
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> ---
>> resend:
>> - no functional change, split out from the imx5 cpufreq series
>> v2:
>> - rebase on top of pm/linux-next
>
> This makes sense to me, but I need ACKs from people who are more familiar
> with OPPs in general.

@Rafael: Where is this gone?

http://permalink.gmane.org/gmane.linux.power-management.general/49384

I am quite sure you applied this.. Have you dropped this while playing with
branches ?
