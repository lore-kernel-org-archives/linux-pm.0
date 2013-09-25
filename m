From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Results] [RFC PATCH v4 00/40] mm: Memory Power Management
Date: Thu, 26 Sep 2013 01:47:34 +0200
Message-ID: <20130925234734.GK18242@two.firstfloor.org>
References: <20130925231250.26184.31438.stgit@srivatsabhat.in.ibm.com>
 <52437128.7030402@linux.vnet.ibm.com>
 <20130925164057.6bbaf23bdc5057c42b2ab010@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20130925164057.6bbaf23bdc5057c42b2ab010@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, mgorman@suse.de, dave@sr71.net, hannes@cmpxchg.org, tony.luck@intel.com, matthew.garrett@nebula.com, riel@redhat.com, arjan@linux.intel.com, srinivas.pandruvada@linux.intel.com, willy@linux.intel.com, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, paulmck@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, andi@firstfloor.org, isimatu.yasuaki@jp.fujitsu.com, santosh.shilimkar@ti.com, kosaki.motohiro@gmail.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> Also, the changelogs don't appear to discuss one obvious downside: the
> latency incurred in bringing a bank out of one of the low-power states
> and back into full operation.  Please do discuss and quantify that to
> the best of your knowledge.

On Sandy Bridge the memry wakeup overhead is really small. It's on by default
in most setups today.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
