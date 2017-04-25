From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Performance of low-cpu utilisation benchmark regressed severely since 4.6
Date: Tue, 25 Apr 2017 14:03:31 -0700
Message-ID: <002901d2be07$67343950$359cabf0$@net>
References: <20170410084117.rjh3mtdx7hd2i5ze@techsingularity.net>        <000a01d2b9e6$393afef0$abb0fcd0$@net> <000301d2bb31$c0037790$400a66b0$@net>     <000501d2bc46$ad4b1fc0$07e15f40$@net>   <CAJZ5v0gBhVOYJ5a7YWpRHSH20qx3Cjx_Lg0qk52st-p+fQS9bQ@mail.gmail.com> 2Sh4dt8AXIBJV2Sh6dNtdh 2ee6dqi43ISm62eusdKnGr 2uN4d4J3kIBJV2ufJdVspi
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:55252 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954683AbdDYVDk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Apr 2017 17:03:40 -0400
In-Reply-To: 2uN4d4J3kIBJV2ufJdVspi
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael@kernel.org>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Mel Gorman' <mgorman@techsingularity.net>, 'Rafael Wysocki' <rafael.j.wysocki@intel.com>, =?UTF-8?Q?'J=C3=B6rg_Otte'?= <jrg.otte@gmail.com>, 'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Doug Smythies' <dsmythies@telus.net>

Hi Rafael,

Apologies, I reversed reported a couple of data points last night:

On 2017.04.25 00:13 Doug wrote:
> On 2017.04.24 07:25 Doug wrote:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> Plus that patch is in progress.
>
>3387.76 Seconds.
> Idle power 3.85 watts.
>
> Other potentially interesting information for 2 hour idle test:
> Driver called 21209 times. Maximum duration 2396 Seconds. Minimum duration 20 mSec. 

Wrong, should read:

Driver called 21209 times. Maximum duration 2510 Seconds. Minimum duration 0.587 mSec.

> Compared to kernel 4.11-rc7 (passive mode, schedutil governor)
> 3297.82 (re-stated from a previous e-mail)
> Idle power 3.81 watts
>
> Other potentially interesting information for 2 hour idle test:
> Driver called 1631 times. Maximum duration 2510 Seconds. Minimum duration 0.587 mSec.

Wrong, should read:

Driver called 1631 times. Maximum duration 2396 Seconds. Minimum duration 20 mSec.
