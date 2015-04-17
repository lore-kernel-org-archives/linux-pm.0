From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: Failure to wake from S2D
Date: Fri, 17 Apr 2015 01:02:26 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014D3FC0@SHSMSX101.ccr.corp.intel.com>
References: <20150416094739.GA10911@fritha.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:23260 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbbDQBCa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 21:02:30 -0400
In-Reply-To: <20150416094739.GA10911@fritha.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heinz Diehl <htd+ml@fritha.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Heinz Diehl
> Sent: Thursday, April 16, 2015 5:48 PM
> To: linux-pm@vger.kernel.org
> Subject: Failure to wake from S2D
> 
> Hi,
> 
> about 3-4 times out of 10, my system doesn't wake from S2D. S2R works
> flawlessly. The only documentation I have is a screenshot when the system
> hangs (hard reset required), due to "no_console_suspend=1".
> 
> The screendump is here:
> http://www.fritha.org/dump.jpg
> 
> The dump shows the output running kernel 4.0.0-rc5, but the same output is
> present using 3.19.x or 4.0.0 final.
> 
Have you checked any earlier kernel versions?

> Booting with "maxcpus=1" resolves the problem, but that can't be a serious
> option on a multicore Xeon. The mainboard is an Asus H97-Pro with the latest
> BIOS.

Does the problem still existing when using idle=poll?

What cpuidle driver are you using?

Please file a bug report at https://bugzilla.kernel.org/enter_bug.cgi?product=Power%20Management
With the test result after using boot option "idle=poll"

Thanks,
rui

> 
> Thanks,
>  Heinz.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
