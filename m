From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
Date: Wed, 03 Apr 2013 10:51:32 -0600
Message-ID: <515C5E14.3070202@wwwdotorg.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>  <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org> <1364610152.2622.3.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:39472 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760213Ab3DCQvg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 12:51:36 -0400
In-Reply-To: <1364610152.2622.3.camel@jlo-ubuntu-64.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joseph Lo <josephl@nvidia.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "rnayak@ti.com" <rnayak@ti.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>, "arnd@arndb.de" <arnd@arndb.de>, "lenb@kernel.org" <lenb@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>

On 03/29/2013 08:22 PM, Joseph Lo wrote:
> On Fri, 2013-03-29 at 18:31 +0800, Daniel Lezcano wrote:
>> Initialize the idle states directly in the driver structure.
>>
>> That prevents extra structure declaration and memcpy at init time.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Hi Daniel,
> 
> Thank you.
> 
> Both the 5th and 6th patch,
> 
> Reviewed-by: Joseph Lo <josephl@nvidia.com>

Thanks. Those same two patches therefore,

Acked-by: Stephen Warren <swarren@nvidia.com>

