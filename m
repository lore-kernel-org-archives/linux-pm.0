From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [Results] [RFC PATCH v4 00/40] mm: Memory Power Management
Date: Thu, 26 Sep 2013 23:24:11 +0530
Message-ID: <524474C3.4030604@linux.vnet.ibm.com>
References: <20130925231250.26184.31438.stgit@srivatsabhat.in.ibm.com> <52437128.7030402@linux.vnet.ibm.com> <20130925164057.6bbaf23bdc5057c42b2ab010@linux-foundation.org> <52442F6F.5020703@linux.vnet.ibm.com> <3908561D78D1C84285E8C5FCA982C28F31D1B6BE@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31D1B6BE@ORSMSX106.amr.corp.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "mgorman@suse.de" <mgorman@suse.de>, "dave@sr71.net" <dave@sr71.net>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>, "riel@redhat.com" <riel@redhat.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "willy@linux.intel.com" <willy@linux.intel.com>, "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "gargankita@gmail.com" <gargankita@gmail.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "andi@firstfloor.org" <andi@firstfloor.org>, isimatu.yasuaki
List-Id: linux-pm@vger.kernel.org

On 09/26/2013 10:52 PM, Luck, Tony wrote:
>> As Andi mentioned, the wakeup latency is not expected to be noticeable. And
>> these power-savings logic is turned on in the hardware by default. So its not
>> as if this patchset is going to _introduce_ that latency. This patchset only
>> tries to make the Linux MM _cooperate_ with the (already existing) hardware
>> power-savings logic and thereby get much better memory power-savings benefits
>> out of it.
> 
> You will still get the blame :-)   By grouping active memory areas along h/w power
> boundaries you enable the power saving modes to kick in (where before they didn't
> because of scattered access to all areas).  This seems very similar to scheduler changes
> that allow processors to go idle long enough to enter deep C-states ... upsetting
> users who notice the exit latency.

Yeah, but hopefully the exit latency won't turn out to be _that_ bad ;-)
And from what Arjan said in his other mail, it does look like it is in the acceptable
range. So memory power management shouldn't pose any significant latency issues due to
the wakeup latency of the hardware. I'm more concerned about the software overhead
added by these patches in the core MM paths.. I _have_ added quite a few optimizations
and specialized access-structures to speed things up in this patchset, but some more
thought and effort might be needed to keep their overhead low enough to be acceptable.

> 
> The interleave problem mentioned elsewhere in this thread is possibly a big problem.
> High core counts mean that memory bandwidth can be the bottleneck for several
> workloads.  Dropping, or reducing, the degree of interleaving will seriously impact
> bandwidth (unless your applications are spread out "just right").
> 

Hmmm, yes, interleaving is certainly one of the hard problems in this whole thing
when it comes to striking a balance or a good trade-off between power-savings vs
performance...
 
Regards,
Srivatsa S. Bhat

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
