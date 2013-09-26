From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Results] [RFC PATCH v4 00/40] mm: Memory Power Management
Date: Thu, 26 Sep 2013 21:38:22 +0200
Message-ID: <20130926193822.GO18242@two.firstfloor.org>
References: <20130925231250.26184.31438.stgit@srivatsabhat.in.ibm.com>
 <52437128.7030402@linux.vnet.ibm.com>
 <20130925164057.6bbaf23bdc5057c42b2ab010@linux-foundation.org>
 <52442F6F.5020703@linux.vnet.ibm.com>
 <3908561D78D1C84285E8C5FCA982C28F31D1B6BE@ORSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31D1B6BE@ORSMSX106.amr.corp.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, "mgorman@suse.de" <mgorman@suse.de>, "dave@sr71.net" <dave@sr71.net>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "matthew.garrett@nebula.com" <matthew.garrett@nebula.com>, "riel@redhat.com" <riel@redhat.com>, "arjan@linux.intel.com" <arjan@linux.intel.com>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "willy@linux.intel.com" <willy@linux.intel.com>, "kamezawa.hiroyu@jp.fujitsu.com" <kamezawa.hiroyu@jp.fujitsu.com>, "lenb@kernel.org" <lenb@kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "gargankita@gmail.com" <gargankita@gmail.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "andi@firstfloor.org" <andi@firstfloor.org>, "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fuji>
List-Id: linux-pm@vger.kernel.org

> The interleave problem mentioned elsewhere in this thread is possibly a big problem.
> High core counts mean that memory bandwidth can be the bottleneck for several
> workloads.  Dropping, or reducing, the degree of interleaving will seriously impact
> bandwidth (unless your applications are spread out "just right").

In practice this doesn't seem to be that big a problem.

I think because most very memory intensive workloads, use 
all the memory from all the cores, so they effectively interleave
by themselves.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
