From: "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v2 4/8] tick/nohz: keep tick on for a fast idle
Date: Mon, 16 Oct 2017 14:31:41 +0800
Message-ID: <39e58dd5-1abd-aac7-2577-9afa71236e35@linux.intel.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
 <1506756034-6340-5-git-send-email-aubrey.li@intel.com>
 <4523111.uMcC96MW3N@aspire.rjw.lan>
 <5beefd1a-2792-c371-3bb8-8ee2a6574020@linux.intel.com>
 <1508129104.8087.2.camel@gmx.de>
 <c64ed43d-8afe-7317-e31f-a7a5eef914d1@linux.intel.com>
 <1508135135.8087.17.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:56942 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbdJPGbn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Oct 2017 02:31:43 -0400
In-Reply-To: <1508135135.8087.17.camel@gmx.de>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Galbraith <efault@gmx.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017/10/16 14:25, Mike Galbraith wrote:
> On Mon, 2017-10-16 at 13:34 +0800, Li, Aubrey wrote:
>> On 2017/10/16 12:45, Mike Galbraith wrote:
>>> On Mon, 2017-10-16 at 11:26 +0800, Li, Aubrey wrote:
>>>>
>>>> I'll try to move quiet_vmstat() into the normal idle branch if this patch series
>>>> are reasonable. Is fast_idle a good indication for it?
>>>
>>> see x86_tip 62cb1188ed86 sched/idle: Move quiet_vmstate() into the NOHZ code
>>
>> It looks like this commit makes tick stop critical as it can be invoked in interrupt
>> exit path?
> 
> do_idle() ain't critical?  It is in my book.  Hopefully, you're about
> to make that idle_stat.fast_idle thingy liberal enough that we cease
> mucking about with the tick on every microscopic idle (and I can then
> trash my years old local patch to avoid needlessly eating that cost).
> 

Welcome any feedback of other patch set, Mike, :)

Thanks,
-Aubrey
