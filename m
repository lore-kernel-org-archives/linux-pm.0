From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [intel-pstate driver regression] processor frequency very high
 even if in idle
Date: Thu, 31 Mar 2016 00:25:59 +0200
Message-ID: <56FC5277.9050906@intel.com>
References: <CA+icZUVGq+rmnyGSbyNEfWJ+LsNg6j6daPPwoZM1zUp4WCJFGQ@mail.gmail.com>
 <1459376311.13525.108.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:32056 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbcC3W0E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 18:26:04 -0400
In-Reply-To: <1459376311.13525.108.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: sedat.dilek@gmail.com, Doug Smythies <dsmythies@telus.net>, =?UTF-8?Q?J=c3=b6rg_Otte?= <jrg.otte@gmail.com>, Linux PM List <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>

On 3/31/2016 12:18 AM, Srinivas Pandruvada wrote:
> On Wed, 2016-03-30 at 23:41 +0200, Sedat Dilek wrote:
>> Hi,
>>
>> I am using Intel-PState-Driver here with v4.6-rc1 and Intel-
>> SandyBridge-CPU.
>>
>> Here are my turbostat results attached.
>>
>> $ cd $BUILD_DIR
>> $ LC_ALL=C make -C tools/ turbostat
>>
>> $ sudo ./turbostat -i 1 --msr=0x199 --debug --out
>> /tmp/turbostat-i-1-msr-0x199-debug.txt
>>
>> Will try <https://patchwork.kernel.org/patch/8702071/>.
>>
>> Please see attached files.
>>
> Thanks. Your logs make sense. You have config set to performance mode
> by default (Which I believe default in all kernel Ubuntu). So as
> expected Intel P state was asking for max. So there is no issue here.

But the behavior is different from what it used to be, isn't it?

So there seems to be a problem here AFAICS.

