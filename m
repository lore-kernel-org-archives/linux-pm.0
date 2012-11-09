From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/8][Sorted-buddy] mm: Linux VM Infrastructure to
 support Memory Power Management
Date: Fri, 09 Nov 2012 08:13:15 -0800
Message-ID: <509D2B9B.4090305@linux.vnet.ibm.com>
References: <20121106195026.6941.24662.stgit@srivatsabhat.in.ibm.com> <20121108180257.GC8218@suse.de> <20121109051247.GA499@dirshya.in.ibm.com> <20121109090052.GF8218@suse.de> <509D185D.8070307@linux.vnet.ibm.com> <509D200F.2000908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <509D200F.2000908@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Mel Gorman <mgorman@suse.de>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, akpm@linux-foundation.org, mjg59@srcf.ucam.org, paulmck@linux.vnet.ibm.com, maxime.coquelin@stericsson.com, loic.pallardy@stericsson.com, arjan@linux.intel.com, kmpark@infradead.org, kamezawa.hiroyu@jp.fujitsu.com, lenb@kernel.org, rjw@sisk.pl, gargankita@gmail.com, amit.kachhap@linaro.org, thomas.abraham@linaro.org, santosh.shilimkar@ti.com, linux-pm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/09/2012 07:23 AM, Srivatsa S. Bhat wrote:
> FWIW, kernbench is actually (and surprisingly) showing a slight performance
> *improvement* with this patchset, over vanilla 3.7-rc3, as I mentioned in
> my other email to Dave.
> 
> https://lkml.org/lkml/2012/11/7/428
> 
> I don't think I can dismiss it as an experimental error, because I am seeing
> those results consistently.. I'm trying to find out what's behind that.

The only numbers in that link are in the date. :)  Let's see the
numbers, please.

If you really have performance improvement to the memory allocator (or
something else) here, then surely it can be pared out of your patches
and merged quickly by itself.  Those kinds of optimizations are hard to
come by!

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
