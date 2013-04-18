From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 00/15][Sorted-buddy] mm: Memory Power Management
Date: Thu, 18 Apr 2013 15:24:25 +0530
Message-ID: <516FC2D1.9020809@linux.vnet.ibm.com>
References: <20130409214443.4500.44168.stgit@srivatsabhat.in.ibm.com> <516ED378.2000406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <516ED378.2000406@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: akpm@linux-foundation.org, mgorman@suse.de, matthew.garrett@nebula.com, dave@sr71.net, rientjes@google.com, riel@redhat.com, arjan@linux.intel.com, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, amit.kachhap@linaro.org, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, wujianguo@huawei.com, kmpark@infradead.org, thomas.abraham@linaro.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/17/2013 10:23 PM, Srinivas Pandruvada wrote:
> On 04/09/2013 02:45 PM, Srivatsa S. Bhat wrote:
>> [I know, this cover letter is a little too long, but I wanted to clearly
>> explain the overall goals and the high-level design of this patchset in
>> detail. I hope this helps more than it annoys, and makes it easier for
>> reviewers to relate to the background and the goals of this patchset.]
>>
>>
>> Overview of Memory Power Management and its implications to the Linux MM
>> ========================================================================
>>
[...]
>>
> One thing you need to prevent is boot time allocation. You have to make
> sure that frequently accessed per node data stored at the end of memory
> will keep all ranks of memory active.
> 

I think you meant to say "... stored at the end of memory will NOT keep all
ranks of memory active".

Yep, that's a good point! I'll think about how to achieve that. Thanks!

Regards,
Srivatsa S. Bhat

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
