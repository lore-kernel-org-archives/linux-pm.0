From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Do not modify MSR_IA32_ENERGY_PERF_BIAS in kernel
Date: Fri, 22 Jan 2016 14:42:27 +0100
Message-ID: <6073976.iSsxakPPgX@vostro.rjw.lan>
References: <27955112.HtLWzIlZCK@skinner> <8034062.tMR12f4YiM@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53160 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753824AbcAVNll (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 08:41:41 -0500
In-Reply-To: <8034062.tMR12f4YiM@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Scott Bahling <sbahling@suse.com>

On Friday, January 22, 2016 01:10:31 PM Thomas Renninger wrote:
> On Friday, January 22, 2016 01:09:15 PM Thomas Renninger wrote:
> > The assumption that BIOSes never want to have this register being set to
> > full performance (zero) is wrong.
> 
> Patch is against latest linux-pm kernel.
> Rafael: Can you queue this one up, please.

Well, I'm not an x86 arch maintainer.

Can you at least CC them, please?

Thanks,
Rafael

