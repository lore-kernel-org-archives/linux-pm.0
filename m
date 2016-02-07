From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Sun, 7 Feb 2016 17:52:12 +0530
Message-ID: <20160207122212.GA3808@vireshk>
References: <56B4D4BE.2040008@free.fr>
 <3308645.nrPBoahQ2V@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35302 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbcBGMWS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 07:22:18 -0500
Received: by mail-pa0-f49.google.com with SMTP id ho8so59143132pac.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Feb 2016 04:22:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3308645.nrPBoahQ2V@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>

On 05-02-16, 23:24, Arnd Bergmann wrote:
> We no longer call platform_device_register_simple() from platform code, at least
> for new platforms, and we should probably remove the code from the existing
> platforms that still do it. I forget what the replacement was, but I'm not
> going to take this version. Viresh should be able to help you do it the right
> way.

We thought initially that opp-v2's compatible string can be used to probe the
drivers, but that was denied later and all we do today is add platform devices
for cpufreq.

What do you have in mind Arnd ?

-- 
viresh
