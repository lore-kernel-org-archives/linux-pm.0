From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH V2] ARM: cpuidle: davinci: Fix target residency
Date: Fri, 28 Jun 2013 12:12:43 +0530
Message-ID: <51CD3063.5010309@ti.com>
References: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584Ab3F1Gn0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jun 2013 02:43:26 -0400
In-Reply-To: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: khilman@deeprootsystems.com, sergei.shtylyov@cogentembedded.com, rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 6/27/2013 8:40 PM, Daniel Lezcano wrote:
> The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target
> residency to 100000, assuming this is a careless mistake.
> 
> commit 19976c2a88d125aec16b9255c7197c297bbdd637
> Author: Robert Lee <rob.lee@linaro.org>
> Date:   Tue Mar 20 15:22:45 2012 -0500
> 
>     ARM: davinci: Consolidate time keeping and irq enable
> 
>     Enable core cpuidle timekeeping and irq enabling and remove that
>     handling from this code.
> 
>     Signed-off-by: Robert Lee <rob.lee@linaro.org>
>     Reviewed-by: Kevin Hilman <khilman@ti.com>
>     Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>     Acked-by: Jean Pihet <j-pihet@ti.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> The same happened to the at91's cpuidle driver.
> 
> Fix it by putting the initial value to 10000.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
