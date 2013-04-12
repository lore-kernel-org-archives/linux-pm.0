From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch v7 0/21] sched: power aware scheduling
Date: Fri, 12 Apr 2013 18:23:48 +0200
Message-ID: <20130412162348.GE2368@pd.tnic>
References: <1365040862-8390-1-git-send-email-alex.shi@intel.com>
 <516724F5.20504@kernel.org>
 <5167C9FA.8050406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44620 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab3DLQXy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Apr 2013 12:23:54 -0400
Content-Disposition: inline
In-Reply-To: <5167C9FA.8050406@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Len Brown <lenb@kernel.org>, mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, arjan@linux.intel.com, pjt@google.com, namhyung@kernel.org, efault@gmx.de, morten.rasmussen@arm.com, vincent.guittot@linaro.org, gregkh@linuxfoundation.org, preeti@linux.vnet.ibm.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, len.brown@intel.com, rafael.j.wysocki@intel.com, jkosina@suse.cz, clark.williams@gmail.com, tony.luck@intel.com, keescook@chromium.org, mgorman@suse.de, riel@redhat.com, Linux PM list <linux-pm@vger.kernel.org>

On Fri, Apr 12, 2013 at 04:46:50PM +0800, Alex Shi wrote:
> Thanks a lot for comments, Len!

AFAICT, you kinda forgot to answer his most important question:

> These numbers suggest that this patch series simultaneously
> has a negative impact on performance and energy required
> to retire the workload.  Why do it?

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
