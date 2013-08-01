From: Guilherme Salazar <gmesalazar@gmail.com>
Subject: Re: [PATCH] =?utf-8?b?Y3B1ZnJlcS9pbnRlbF9wc3RhdGU6?= Change to scale off of max P-state
Date: Thu, 1 Aug 2013 17:56:54 +0000 (UTC)
Message-ID: <loom.20130801T194134-745@post.gmane.org>
References: <1374162523-2777-1-git-send-email-dirk.j.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52983 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab3HASAI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Aug 2013 14:00:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1V4xAS-0002hI-QI
	for linux-pm@vger.kernel.org; Thu, 01 Aug 2013 20:00:05 +0200
Received: from 187.114.250.127.static.host.gvt.net.br ([187.114.250.127.static.host.gvt.net.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2013 20:00:04 +0200
Received: from gmesalazar by 187.114.250.127.static.host.gvt.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Thu, 01 Aug 2013 20:00:04 +0200
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

 <dirk.brandewie <at> gmail.com> writes:

> 
> From: Dirk Brandewie <dirk.j.brandewie <at> intel.com>
> 
> Change to using max P-state instead of max turbo P-state.  This change
> resolves two issues.
> 
> On a quiet system intel_pstate can fail to respond to a load change.
>    https://bugzilla.kernel.org/show_bug.cgi?id=59481
> 
> On CPU SKUs that have a limited number of P-states and no turbo range
> intel_pstate fails to select the highest available P-state.
> 
> This change is suitable for stable v3.9+
> 
> Reported-by: arjan <at> linux.intel.com
> Reported-by: dsmythies <at> telus.net
> Tested-by: arjan <at> linux.intel.com
> Tested-by: dsmythies <at> telus.net
> 
> CC: stable <at> vger.kernel.org
> CC: dsmythies <at> telus.net
> Signed-off-by: Dirk Brandewie <dirk.j.brandewie <at> intel.com>

Hi,

I've just tested the patch and, even though it works (the frequency now sits 
around 1.3-1.5 GHz), I noticed that if I suspend the laptop and then resume 
it, the abnormal behavior (frequency sitting above 2 GHz) returns.

Before suspending, the value in 
/sys/devices/system/cpu/intel_pstate/min_perf_pct was 37; afterwards, 100.

cpuinfo: http://pastebin.com/C6zR90HC

I'd be glad to give any further details.

Best,
Guilherme

