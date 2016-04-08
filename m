From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [regression] cross core scheduling frequency drop bisected to 0c313cb20732
Date: Fri, 8 Apr 2016 15:19:14 -0700
Message-ID: <001101d191e4$b00602d0$10120870$@net>
References: <1460092854.4051.1.camel@gmail.com> <20160408064510.GK3448@twins.programming.kicks-ass.net> <1460098254.5582.17.camel@gmail.com> <2428384.mEkP3EOpsR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta2.telus.net ([209.171.16.75]:58066 "EHLO cmta2.telus.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484AbcDHWTS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Apr 2016 18:19:18 -0400
In-Reply-To: <2428384.mEkP3EOpsR@vostro.rjw.lan>
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Mike Galbraith' <umgwanakikbuti@gmail.com>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'LKML' <linux-kernel@vger.kernel.org>, 'Linux PM list' <linux-pm@vger.kernel.org>, 'Rik van Riel' <riel@redhat.com>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>

On 2016.04.08 14:00 Rafael J. Wysocki wrote:
> On Friday, April 08, 2016 08:50:54 AM Mike Galbraith wrote:
>> On Fri, 2016-04-08 at 08:45 +0200, Peter Zijlstra wrote:
>> 
>>> Cute, I thought you used governor=performance for your runs?
>> 
>> I do, and those numbers are with it thus set.

> Well, this is a trade-off.
>
> 4.5 introduced a power regression here so this one goes back to the previous
> state of things.

Mike:

Could you send me, or point me to, the program "pipe-test"?
So far, I have only found one, but it is both old and not
the same program you are running (based on print statements).

I realize I might not be to recreate your problem scenario anyhow,
I just want to try.

... Doug


