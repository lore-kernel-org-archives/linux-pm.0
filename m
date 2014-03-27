From: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH v4] powernv, cpufreq: cpufreq driver for powernv
 platform
Date: Thu, 27 Mar 2014 14:56:04 +1100
Message-ID: <20140327145604.539b871d@kryten>
References: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:42465 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658AbaC0D4B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Mar 2014 23:56:01 -0400
In-Reply-To: <1395852947-22290-2-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, benh@kernel.crashing.org, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, svaidy@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com


Hi Gautham,

> Backend driver to dynamically set voltage and frequency on
> IBM POWER non-virtualized platforms.  Power management SPRs
> are used to set the required PState.

I tested this version on ppc64le, it still looks good. I'm already
a Signed-off-by on the patch, but feel free to add:

Tested-by: Anton Blanchard <anton@samba.org>

Anton
