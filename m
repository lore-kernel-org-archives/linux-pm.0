From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/4] mvebu: Dove: Enable cpufreq driver in defconfig
Date: Fri, 1 Nov 2013 05:22:21 +0530
Message-ID: <CAKohpomOpfg3+OVooum9jVK2H12bu1Nz=zPMFWF02sCh6MdUhQ@mail.gmail.com>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
	<1383247111-26834-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:60308 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab3JaXwW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 19:52:22 -0400
Received: by mail-oa0-f48.google.com with SMTP id m17so3832246oag.7
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2013 16:52:21 -0700 (PDT)
In-Reply-To: <1383247111-26834-3-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux ARM <linux-arm-kernel@lists.infradead.org>

On 1 November 2013 00:48, Andrew Lunn <andrew@lunn.ch> wrote:
> Add cpufreq to dove_defconfig, so it is built by default.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
>  arch/arm/configs/dove_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
