From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Add "cpuidle.use_deepest" to bypass governor and allow HW to go deep
Date: Fri, 10 Nov 2017 09:11:25 -0800
Message-ID: <001001d35a46$f22bbe80$d6833b80$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta17.telus.net ([209.171.16.90]:47693 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752877AbdKJRLa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Nov 2017 12:11:30 -0500
References: ChQPe845pQS28ChQQe67JC
In-Reply-To: ChQPe845pQS28ChQQe67JC
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Len Brown' <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, 'Len Brown' <len.brown@intel.com>, thomas.ilsche@tu-dresden.de, linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com

Hi Len,

Other feedback notwithstanding, works fine for me.
Just a small typo type comment:

On 2017.11.08 23:39 Len Brown wrote:

...[snip]...

> Here we create the "cpuidle.use_deepest" modparam to provide this capability.
> 
> "cpuidle.use_deepest=Y" can be set at boot-time, and
> /sys/module/cpuidle/use_deepest can be modified (with Y/N) at run-time.

Should be:

/sys/module/cpuidle/parameters/use_deepest

...[snip]...
