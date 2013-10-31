From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu
 node in DT.
Date: Fri, 1 Nov 2013 05:21:03 +0530
Message-ID: <CAKohpokTWfBnhWj+bdA9zx-+hyXUdp4ir5BYkZNLe08mcwVwLg@mail.gmail.com>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
	<1383247111-26834-4-git-send-email-andrew@lunn.ch>
	<1429743.Nz1AUEe5Hi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:42816 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab3JaXvE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 19:51:04 -0400
Received: by mail-oa0-f41.google.com with SMTP id o9so3914739oag.14
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2013 16:51:03 -0700 (PDT)
In-Reply-To: <1429743.Nz1AUEe5Hi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 1 November 2013 03:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
>> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
>> is also an interrupt generated when the DFS hardware completes a
>> change of frequencey. Add these to the cpu node in DT.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> I need someone with DT bindings knowledge to ACK this for me.

I can do that, but this set has to be rebased over all the latest developments
in cpufreq core before getting posted again..

@Andrew: you can add my: Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
for this patch..
