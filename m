From: Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: Re: [PATCH v4 1/2] cpufreq: ondemand: handle SW coordinated CPUs
Date: Fri, 23 Nov 2012 13:42:21 +0100
Message-ID: <20121123124221.GA7378@balto.lan>
References: <1353663117-10074-1-git-send-email-fabio.baltieri@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53339 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673Ab2KWMm0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Nov 2012 07:42:26 -0500
Received: by mail-wi0-f178.google.com with SMTP id hm6so1574719wib.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Nov 2012 04:42:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353663117-10074-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rickard Andersson <rickard.andersson@stericsson.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org

Hi Rafael,

On Fri, Nov 23, 2012 at 10:31:56AM +0100, Fabio Baltieri wrote:
>  drivers/cpufreq/cpufreq_ondemand.c | 152 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 132 insertions(+), 20 deletions(-)

I just noticed that the whole ondemand driver was refactored in your
linux-pm.git/linux-next branch so my patch does not apply.  I'm
preparing a rebased version of the set, so feel free to skip this one.

Thanks,
Fabio

-- 
Fabio Baltieri
