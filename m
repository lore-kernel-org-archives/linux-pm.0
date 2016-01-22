From: Thomas Renninger <trenn@suse.de>
Subject: Re: Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Fri, 22 Jan 2016 13:10:31 +0100
Message-ID: <8034062.tMR12f4YiM@skinner>
References: <27955112.HtLWzIlZCK@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40881 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752733AbcAVMKd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Jan 2016 07:10:33 -0500
In-Reply-To: <27955112.HtLWzIlZCK@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Bahling <sbahling@suse.com>

On Friday, January 22, 2016 01:09:15 PM Thomas Renninger wrote:
> The assumption that BIOSes never want to have this register being set to
> full performance (zero) is wrong.

Patch is against latest linux-pm kernel.
Rafael: Can you queue this one up, please.

Thanks,

        Thomas
