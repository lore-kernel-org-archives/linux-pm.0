From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH] Thermal: x86 package temp thermal crash
Date: Thu, 11 Jul 2013 08:59:11 -0700
Message-ID: <20130711155911.GB5857@fifo99.com>
References: <1373521763-23184-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fifo99.com ([67.223.236.141]:38597 "EHLO fifo99.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563Ab3GKQIj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 11 Jul 2013 12:08:39 -0400
Content-Disposition: inline
In-Reply-To: <1373521763-23184-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com

On Wed, Jul 10, 2013 at 10:49:23PM -0700, Srinivas Pandruvada wrote:
> On some older platform this resulted in general protection fault,
> for accessing MSRs, which are not present.
> Added change so that the module is loaded, only when the CPU has
> PTS feature. The previous check has an issue when DTS sensor is
> present but PTS is not supported.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reported-by: Daniel Walker <dwalker@fifo99.com>
> ---


Although I should note that my platform is not old by any means.. So
your comments above aren't exactly correct.

Tested-By: Daniel Walker <dwalker@fifo99.com>

