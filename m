From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V1 Resend 2/3] cpufreq: dt: Add generic platform-device creation support
Date: Tue, 29 Mar 2016 21:46:37 +0200
Message-ID: <4215539.cg6AY50O1k@wuerfel>
References: <cover.1459233524.git.viresh.kumar@linaro.org> <5412084.gVvuDFzkvo@wuerfel> <20160329164209.GF14322@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56724 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbcC2TrB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 15:47:01 -0400
In-Reply-To: <20160329164209.GF14322@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, k.kozlowski@samsung.com, kgene.kim@samsung.com, heiko@sntech.de, xf@rock-chips.com, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, mmcclint@codeaurora.org

On Tuesday 29 March 2016 22:12:09 you wrote:
> On 29-03-16, 17:14, Arnd Bergmann wrote:
> >       if (of_device_match(of_root, compat))
> 
> You meant of_match_node() here, right?
> 

Yes, sorry for the confusion.

	Arnd
