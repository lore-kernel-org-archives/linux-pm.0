From: kazutomo <kazutomo.yoshii@gmail.com>
Subject: Re: [PATCH] powercap/rapl: handle domain energy unit
Date: Thu, 12 Mar 2015 17:50:20 -0500
Message-ID: <5502182C.90304@gmail.com>
References: <1426078509-3767-1-git-send-email-jacob.jun.pan@linux.intel.com>	<5500B2E0.9000107@gmail.com>	<20150312142413.7bd42863@icelake>	<55020C4F.3010406@gmail.com> <20150312150536.630c0644@icelake>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:43799 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbCLWuX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Mar 2015 18:50:23 -0400
In-Reply-To: <20150312150536.630c0644@icelake>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>

On 03/12/2015 05:05 PM, Jacob Pan wrote:
> On Thu, 12 Mar 2015 16:59:43 -0500
> kazutomo <kazutomo.yoshii@gmail.com> wrote:
>
>>> according to the document, future DRAM energy unit will always be
>>> hardcoded to 15.3uJ, no enumeration since there is no domain
>>> specific MSR for energy unit.  
>> Which document are you referring to?
> Intel DocID:330784-001 Sept 2014
> Intel Xeon Processor E5-1600 and E5-2600 V2 of 2.

I think V2 is Ivy Bridge.  Is this typo?
 
By googling, I found a datasheet titled:
"Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, Volume 2
of 2. Datasheet, September 2014, Reference Number: 330784-001 "

It clearly says "ENERGY_UNIT for DRAM domain is 15.3uJ."

- kaz

