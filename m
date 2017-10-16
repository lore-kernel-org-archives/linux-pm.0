From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 1/8] cpuidle: menu: extract prediction
 functionality
Date: Mon, 16 Oct 2017 10:46:20 +0800
Message-ID: <b9dc3eea-cd55-e2a5-71b7-f3c0a548e92b@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-2-git-send-email-aubrey.li@intel.com>
 <1629755.KbDSmDPDTX@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:30219 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbdJPCqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Oct 2017 22:46:23 -0400
In-Reply-To: <1629755.KbDSmDPDTX@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/14 8:26, Rafael J. Wysocki wrote:
> On Saturday, September 30, 2017 9:20:27 AM CEST Aubrey Li wrote:
>> There are several factors in the menu governor to predict the next
>> idle interval:
>> - the next timer
>> - the recent idle interval history
>> - the corrected idle interval pattern
>> These factors are common enough to be extracted to be one function.
>>
>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> 
> This patch alone would break things AFAICS, because it removes code from
> menu_select() without a replacement (and menu_predict() is never called
> just yet).
> 
> Please always do your best to ensure that things will work after *every*
> patch in a series.

okay, I'll correct this in the next version.

Thanks,
-Aubrey
