From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Fri, 1 Nov 2013 05:16:30 +0530
Message-ID: <CAKohpo=m1SR3mJoFuGzQRW5-AWSujtMYZ7V3-_LyRn5WoTCcuw@mail.gmail.com>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:32849 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978Ab3JaXqb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 19:46:31 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so3840749oag.6
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2013 16:46:30 -0700 (PDT)
In-Reply-To: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 1 November 2013 00:48, Andrew Lunn <andrew@lunn.ch> wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

As I have said early, you need to rebase this now over linux-next, which
has got over 150 patches for cpufreq for 3.13..

Over that following patchset would be included in linux-next as soon as
3.13-rc1 or rc2 is going to be released and so probably before your
patch makes it:

https://lkml.org/lkml/2013/10/30/553

So, please rebase your driver over linux-next & above patchset and
resend again..
