From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 00/15][Sorted-buddy] mm: Memory Power Management
Date: Wed, 29 May 2013 11:06:49 +0530
Message-ID: <51A593F1.5090200@linux.vnet.ibm.com>
References: <20130409214443.4500.44168.stgit@srivatsabhat.in.ibm.com> <5170D781.3000102@gmail.com> <5170EE4F.9030908@linux.vnet.ibm.com> <51A50EC4.4090108@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <51A50EC4.4090108@ubuntu.com>
Sender: owner-linux-mm@kvack.org
To: Phillip Susi <psusi@ubuntu.com>
Cc: Simon Jeons <simon.jeons@gmail.com>, akpm@linux-foundation.org, mgorman@suse.de, matthew.garrett@nebula.com, dave@sr71.net, rientjes@google.com, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, amit.kachhap@linaro.org, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, wujianguo@huawei.com, kmpark@infradead.org, thomas.abraham@linaro.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/29/2013 01:38 AM, Phillip Susi wrote:
> 
> On 4/19/2013 3:12 AM, Srivatsa S. Bhat wrote:
>> But going further, as I had mentioned in my TODO list, we can be
>> smarter than this while doing compaction to evacuate memory regions
>> - we can choose to migrate only the active pages, and leave the
>> inactive pages alone. Because, the goal is to actually consolidate
>> the *references* and not necessarily the *allocations* themselves.
> 
> That would help with keeping references compact to allow use of the
> low power states, but it would also be nice to keep allocations
> compact, and completely power off a bank of ram with no allocations.
> 

That is a very good point, thanks! But one of the differences we have to
keep in mind is that powering off a bank requires intervention from the
OS (ie., OS should initiate the power-off, because we lose the contents
on power-off) whereas going to lower power states can be mostly done
automatically by the hardware (because it is content-preserving).

But powering-off unused banks of RAM (using techniques such as PASR -
Partial Array Self Refresh) can give us more power-savings than just
entering lower power states. So yes, keeping allocations consolidated
has that additional advantage. And the sorted-buddy design of the page
allocator helps us achieve that.

Thanks a lot for your inputs, Phillip!

Regards,
Srivatsa S. Bhat

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
