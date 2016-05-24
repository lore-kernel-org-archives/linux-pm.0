From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 8/9] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 24 May 2016 16:07:51 +0530
Message-ID: <20160524103751.GF12860@in.ibm.com>
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-9-git-send-email-shreyas@linux.vnet.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:48405 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005AbcEXKiL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 06:38:11 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Tue, 24 May 2016 04:38:10 -0600
Content-Disposition: inline
In-Reply-To: <1464016722-7488-9-git-send-email-shreyas@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org, linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

On Mon, May 23, 2016 at 08:48:41PM +0530, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added.
>  b) new per thread SPR named PSSCR is added which controls the behavior
> 	of stop instruction.
> 
> Supported idle states and value to be written to PSSCR register to enter
> any idle state is exposed via ibm,cpu-idle-state-names and
> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
> platform provided power_stop() needs to be invoked with the appropriate
> PSSCR value.
> 
> This patch adds support for this new mechanism in cpuidle powernv driver.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

--
Thanks and Regards
gautham.

