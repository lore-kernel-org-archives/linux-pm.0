From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 0/8] Introduct cpu idle prediction functionality
Date: Tue, 17 Oct 2017 15:32:45 +0800
Message-ID: <a94fb81f-0491-2c77-19a2-88d951046f10@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <3026355.QRuoy6eIZM@aspire.rjw.lan>
 <c4eaedb9-904f-0b51-a6e3-3033a6808cf0@linux.intel.com>
 <3251888.IpbWLYog7H@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35320 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753611AbdJQHct (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Oct 2017 03:32:49 -0400
In-Reply-To: <3251888.IpbWLYog7H@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Aubrey Li <aubrey.li@intel.com>, tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/17 8:07, Rafael J. Wysocki wrote:
> On Monday, October 16, 2017 9:44:41 AM CEST Li, Aubrey wrote:
>>
>> Or you concern why the threshold can't simply be tick interval?
> 
> That I guess.
> 
>> For the latter, if the threshold is close/equal to the tick, it's quite possible
>> the next event is the tick and no other else event.
> 
> Well, I don't quite get that.
> 
> What's the reasoning here?

if we set the threshold to the tick interval, when the system keeps the tick on once,
it will have no chance to turn if off forever.

Because we turn on the tick, and count in the time of idle entry and idle exit,
the idle interval always < tick interval, that means idle is always a short idle.

Thanks,
-Aubrey
