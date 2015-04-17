From: Heinz Diehl <htd+ml@fritha.org>
Subject: Re: Failure to wake from S2D
Date: Fri, 17 Apr 2015 08:23:47 +0200
Message-ID: <20150417062347.GA1481@fritha.org>
References: <20150416094739.GA10911@fritha.org>
 <744357E9AAD1214791ACBA4B0B909263014D3FC0@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:51063 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbbDQGXx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Apr 2015 02:23:53 -0400
Content-Disposition: inline
In-Reply-To: <744357E9AAD1214791ACBA4B0B909263014D3FC0@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 17.04.2015, Zhang, Rui wrote: 

> Have you checked any earlier kernel versions?

No. Every hang means fs corruption, and this is a production machine.
At least some of the 3.19.x series shows the same behaviour.

> Does the problem still existing when using idle=poll?

Yes, it does.

> What cpuidle driver are you using?

[htd@chiara ~]$ cat /sys/devices/system/cpu/cpuidle/current_driver
intel_idle

> Please file a bug report at https://bugzilla.kernel.org/enter_bug.cgi?product=Power%20Management
> With the test result after using boot option "idle=poll"

Will do. However, idle=poll is not a permanent option on this system, since it
significantly increases heat and power consumption.

Thanks,
Heinz.

-- 
OpenPGP Fingerprint: 531E 8E75 4395 ED38 CEC2  FD75 A1EB 6944 60F4 A92C
