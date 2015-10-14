From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] PM / OPP: Remove confusing error message in
 of_cpumask_init_opp_table()
Date: Wed, 14 Oct 2015 23:10:39 +0200
Message-ID: <20151014231039.1f62167c@free-electrons.com>
References: <1444837943-32263-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<2178316.qF1soG5NSE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46621 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753842AbbJNVKm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 17:10:42 -0400
In-Reply-To: <2178316.qF1soG5NSE@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>

Rafael,

On Wed, 14 Oct 2015 23:28:51 +0200, Rafael J. Wysocki wrote:

> > To avoid this confusion, this patch simply deletes the error message.
> > 
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> That's only present in linux-next now, right?

No, it is already in 4.3-rc since 4.3-rc1. The commit adding the
problematic function is 8d4d4e98acd68c31435ebb7beea591dbf60b9eb2, and
this function gets used in cpufreq-dt starting at commit
2e02d8723edf6599988852a8ade8f83b2f766cb8.

$ git tag --contains 2e02d8723edf6599988852a8ade8f83b2f766cb8
v4.3-rc1
v4.3-rc2
v4.3-rc3
v4.3-rc4
v4.3-rc5

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
