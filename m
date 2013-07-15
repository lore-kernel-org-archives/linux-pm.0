From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: Fix cpufreq regression after suspend/resume
Date: Mon, 15 Jul 2013 11:43:40 +0530
Message-ID: <51E39314.6060808@linux.vnet.ibm.com>
References: <51C08370.4050906@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com> <51CF1E53.6060902@gmx.de> <8029836.CFiJCXmRQ0@vostro.rjw.lan> <51D05DF4.50704@linux.vnet.ibm.com> <51D06556.7080204@gmx.de> <51D07E7F.2030709@linux.vnet.ibm.com> <51DDC8FA.4020609@gmx.de> <1373710596.1352.26.camel@x61.thuisdomein> <1373719972.1359.8.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:35191 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab3GOGRU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 02:17:20 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 15 Jul 2013 11:41:46 +0530
In-Reply-To: <1373719972.1359.8.camel@x61.thuisdomein>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 07/13/2013 06:22 PM, Paul Bolle wrote:
> On Sat, 2013-07-13 at 12:16 +0200, Paul Bolle wrote:
>> I suspect that the stuck frequency is a regression introduced in v3.10.0.
> 
> The culprit apparently is commit a66b2e503f ("cpufreq: Preserve sysfs
> files across suspend/resume"). Srivatsa submitted a patch to revert that
> commit (see https://lkml.org/lkml/2013/7/11/661 ). That revert seems to
> fix this issue too.
> 
>

Thanks a lot for your tests and for confirming that the complete revert
fixes your cpufreq issue.
 
 
Regards,
Srivatsa S. Bhat

