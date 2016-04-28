From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic
 code
Date: Thu, 28 Apr 2016 07:57:14 +0530
Message-ID: <20160428022714.GY4225@vireshk-i7>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
 <20160420095557.GF12019@vireshk-i7>
 <5720ED0F.6050204@free.fr>
 <F0617D5F-67FB-4A02-9CDB-1DA9AD4CA27B@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36301 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbcD1C1T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 22:27:19 -0400
Received: by mail-pa0-f51.google.com with SMTP id bt5so26319559pac.3
        for <linux-pm@vger.kernel.org>; Wed, 27 Apr 2016 19:27:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <F0617D5F-67FB-4A02-9CDB-1DA9AD4CA27B@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthew McClintock <mmcclint@codeaurora.org>
Cc: Mason <slash.tmp@free.fr>, Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, k.kozlowski@samsung.com, Sebastian Frias <sf84@laposte.net>

On 27-04-16, 11:57, Matthew McClintock wrote:
> On Apr 27, 2016, at 11:47 AM, Mason <slash.tmp@free.fr> wrote:
> > 
> > Should I add it at the beginning or at the end?
> > (I suppose at the end.)
> 
> I was going to do alphabetical order.

That's right, you should follow the way things are present in the file itself.
So, it should be in alphabetical order, + blank lines separating your platform
from the rest.

-- 
viresh
