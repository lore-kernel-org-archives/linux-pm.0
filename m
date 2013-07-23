From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] cpufreq: pmac64: speed up frequency switch
Date: Wed, 24 Jul 2013 07:14:03 +1000
Message-ID: <1374614043.3916.84.camel@pasglop>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
	 <9298823.WUCyZreP9q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41674 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758036Ab3GWVOf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 17:14:35 -0400
In-Reply-To: <9298823.WUCyZreP9q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Viresh Kumar <viresh.kumar@linaro.org>, Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Tue, 2013-07-23 at 23:20 +0200, Rafael J. Wysocki wrote:
> All looks good in the patchset from 10000 feet (or more), but I need
> Ben to speak here.

I want to give it a quick spin on the HW here, I'll ack then. But yes,
it looks good.

Cheers,
Ben.


