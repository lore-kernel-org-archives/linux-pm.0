From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: API for querying the resume cause
Date: Fri, 21 Aug 2015 11:17:38 +0800
Message-ID: <55D69852.3010902@intel.com>
References: <55D5BE6B.5070805@gmail.com> <CAJKOXPe+ud=uCRKbQiggg7tLeShgYJbD16W_26qYo4E4-4mXrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:63279 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751599AbbHUDOP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Aug 2015 23:14:15 -0400
In-Reply-To: <CAJKOXPe+ud=uCRKbQiggg7tLeShgYJbD16W_26qYo4E4-4mXrw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Yan Pashkovsky <yanpaso@gmail.com>
Cc: linux-pm@vger.kernel.org, Alexandra Yates <alexandra.yates@linux.intel.com>, Bastien Nocera <hadess@hadess.net>, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 08/21/2015 10:07 AM, Krzysztof Kozlowski wrote:
> 2015-08-20 20:47 GMT+09:00 Yan Pashkovsky <yanpaso@gmail.com>:
>
> A little bit similar work from Alexandra Yates (CC-ed):
> Report interrupt(s) that caused system wakeup
> http://comments.gmane.org/gmane.linux.power-management.general/63805
>
This topic is interesting : )
BTW, in github.com/systemd/systemd/issues/926, Lennart is worried
about rtcwake unstable platforms. How about using suspend-to-idle
on these platforms, and leverage a timer instead of rtcwake..

Best Regards,
Yu
>
>
> Best regards,
> Krzysztof


