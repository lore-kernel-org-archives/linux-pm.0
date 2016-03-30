From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device
 creation support
Date: Wed, 30 Mar 2016 08:52:40 +0530
Message-ID: <20160330032240.GB8773@vireshk-i7>
References: <cover.1459233524.git.viresh.kumar@linaro.org>
 <5412084.gVvuDFzkvo@wuerfel>
 <20160329163649.GE14322@vireshk-i7>
 <12972545.Mi9sHiNJpR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33746 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447AbcC3DWu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 23:22:50 -0400
Received: by mail-pa0-f43.google.com with SMTP id zm5so29356174pac.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Mar 2016 20:22:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <12972545.Mi9sHiNJpR@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mmcclint@codeaurora.org

On 29-03-16, 21:45, Arnd Bergmann wrote:
> Regarding new platforms, I'd hope that we could manage to define an extension
> to the oppv2 binding that marks a machine as compatible with opp, so we can

The extension of oppv2 binding or compatible string is for platforms that really
need extend oppv2 (like ST, which already have a new compatible string). I am
not sure if we should be putting that into the Machine's compatible area, as I
though it is something internal to OPP layer or their driver.

But we can see that when we handle it.

-- 
viresh
