From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] x86: do not use cpufreq_quick_get() for /proc/cpuinfo
 "cpu MHz"
Date: Tue, 20 Jun 2017 12:15:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706201215171.1869@nanos>
References: <1497668594-9266-1-git-send-email-lenb@kernel.org> <f9250362b5eb66bc34402c1fd175f9db7a841532.1497665794.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbdFTKPj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Jun 2017 06:15:39 -0400
In-Reply-To: <f9250362b5eb66bc34402c1fd175f9db7a841532.1497665794.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rafael@kernel.org, x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

On Fri, 16 Jun 2017, Len Brown wrote:
> Issue 4 will remain -- users that really care about
> accurate frequency information should not be using either
> proc or sysfs kernel interfaces.
> They should be using using turbostat(8), or a similar
> purpose-built analysis tool.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
