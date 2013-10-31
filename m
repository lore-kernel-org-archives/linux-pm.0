From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/4] mvebu: Dove: Instantiate cpufreq driver.
Date: Fri, 1 Nov 2013 05:22:00 +0530
Message-ID: <CAKohpo=Y30y=0COqYf-JP0W4MY7RTDx0yVEdehGHGucNw_kiGA@mail.gmail.com>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
	<1383247111-26834-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:43431 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab3JaXwB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 19:52:01 -0400
Received: by mail-oa0-f49.google.com with SMTP id j10so3877940oah.36
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2013 16:52:01 -0700 (PDT)
In-Reply-To: <1383247111-26834-2-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 1 November 2013 00:48, Andrew Lunn <andrew@lunn.ch> wrote:
> Add a platform driver definition to instantiate the dove cpufreq
> driver. Also indicate the ARCH has cpufreq support, so allowing the
> cpufreq framework to be enabled.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
