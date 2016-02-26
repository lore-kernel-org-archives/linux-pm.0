From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Fri, 26 Feb 2016 17:42:29 +0100
Message-ID: <2368347.dTYjf0g22d@skinner>
References: <4687430.mfM0GbdeDL@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49169 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932737AbcBZQmb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Feb 2016 11:42:31 -0500
In-Reply-To: <4687430.mfM0GbdeDL@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: lenb@kernel.org, x86@kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

This in fact is a re-send, including x86 maintainers.
Even this is a PM (Power Management) issue, the code is in the
x86 architecture paths.

>From last submit:
> > Patch is against latest linux-pm kernel.
> > Rafael: Can you queue this one up, please.

> Well, I'm not an x86 arch maintainer.
> Can you at least CC them, please?

Can someone, best would be a x86 maintainer?, take the patch please if
it is considered ok.

Thanks,

       Thomas
