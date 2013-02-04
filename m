From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 1/4] davinci: cpuidle - use global variable for ddr2 flag
Date: Mon, 4 Feb 2013 15:18:33 +0530
Message-ID: <510F83F1.7000706@ti.com>
References: <1359726495-8024-1-git-send-email-daniel.lezcano@linaro.org> <1359726495-8024-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56064 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903Ab3BDJsu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 Feb 2013 04:48:50 -0500
In-Reply-To: <1359726495-8024-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, patches@linaro.org, linaro-dev@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, lenb@kernel.org, linux-pm@vger.kernel.org

On 2/1/2013 7:18 PM, Daniel Lezcano wrote:
> +static bool ddr2_pdown = false;

checkpatch.pl warned against zero initialization of static variable
here. Other than that the series looks good. I checked that both state0
and state1 are entered on da850 evm. Making power measurements requires
more elaborate setup so I left that out.

Target residency of state1 seems high and it is entered very
infrequently. But that's not something introduced by this series. So for
all the patches, you can add:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

