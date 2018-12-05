From: shuah <shuah@kernel.org>
Subject: Re: [PATCH] cpupower : Auto-completion for cpupower tool
Date: Wed, 5 Dec 2018 07:57:01 -0700
Message-ID: <89d66277-ed2c-d3d5-ab62-b8244e9108f2@kernel.org>
References: <20181205113104.71319-1-huntbag@linux.vnet.ibm.com>
 <2133486.u21R1XiQqC@house>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2133486.u21R1XiQqC@house>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com, Bharath Thodla <bharath.thodla@in.ibm.com>, shuah <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 12/5/18 4:48 AM, Thomas Renninger wrote:
> On Wednesday, December 5, 2018 12:31:04 PM CET Abhishek Goel wrote:
>> This script adds support for auto-completion for cpupower tool.
>> Added support for auto-completion of all the eight commands for
>> cpupower tool and their all subsequent sub-commands, wherever
>> possible.
> 
>>From what I see all changes I proposed in a previous review round
> with a "not that broad audience" have been addressed.
> 
> I already integrated the patch (slightly different, without functional
> changes) into the latest cpupower sources of our build service and
> things work out nice.
> 
> Shuah: Can you pick this up for next cpupower submission round, please.
> 
> Thanks,
> 
>         Thomas
> 

Thanks Thomas.

Patch applied to

git.kernel.org/pub/scm/linux/kernel/git/shuah/linux cpupower branch to 
be included in the next pull request to Rafael.

thanks,
-- Shuah
