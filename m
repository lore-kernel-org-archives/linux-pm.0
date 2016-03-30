From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device creation support
Date: Wed, 30 Mar 2016 09:53:34 +0200
Message-ID: <7250220.227umpmTug@wuerfel>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <12972545.Mi9sHiNJpR@wuerfel> <20160330032240.GB8773@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62415 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758143AbcC3Hx7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 03:53:59 -0400
In-Reply-To: <20160330032240.GB8773@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, linux-pm@vger.kernel.org, mmcclint@codeaurora.org, xf@rock-chips.com, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org

On Wednesday 30 March 2016 08:52:40 Viresh Kumar wrote:
> On 29-03-16, 21:45, Arnd Bergmann wrote:
> > Regarding new platforms, I'd hope that we could manage to define an extension
> > to the oppv2 binding that marks a machine as compatible with opp, so we can
> 
> The extension of oppv2 binding or compatible string is for platforms that really
> need extend oppv2 (like ST, which already have a new compatible string). I am
> not sure if we should be putting that into the Machine's compatible area, as I
> though it is something internal to OPP layer or their driver.
> 
> But we can see that when we handle it.
> 

I think it should be something in the /cpus or the /opp_table hierarchy,
not the root of the device tree, but other than that I don't care much
whether it's a variation of the oppv2 compatible string or an additional
property in any of the nodes.

	Arnd
