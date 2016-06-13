From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 09/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead
 of MAX_POWERNV_IDLE_STATES
Date: Mon, 13 Jun 2016 17:01:50 +0200
Message-ID: <20160613150150.GE10634@linaro.org>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36963 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423004AbcFMPBy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jun 2016 11:01:54 -0400
Received: by mail-wm0-f49.google.com with SMTP id k204so83785569wmk.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jun 2016 08:01:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org

On Wed, Jun 08, 2016 at 11:54:29AM -0500, Shreyas B. Prabhu wrote:
> Use cpuidle's CPUIDLE_STATE_MAX macro instead of powernv specific
> MAX_POWERNV_IDLE_STATES.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
