From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap/rapl: handle domain energy unit
Date: Fri, 13 Mar 2015 03:53:17 -0700
Message-ID: <20150313035317.712e271d@ultegra>
References: <1426078509-3767-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<5500B2E0.9000107@gmail.com>
	<20150312142413.7bd42863@icelake>
	<55020C4F.3010406@gmail.com>
	<20150312150536.630c0644@icelake>
	<5502182C.90304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5502182C.90304@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kazutomo <kazutomo.yoshii@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 12 Mar 2015 17:50:20 -0500
kazutomo <kazutomo.yoshii@gmail.com> wrote:

> On 03/12/2015 05:05 PM, Jacob Pan wrote:
> > On Thu, 12 Mar 2015 16:59:43 -0500
> > kazutomo <kazutomo.yoshii@gmail.com> wrote:
> >
> >>> according to the document, future DRAM energy unit will always be
> >>> hardcoded to 15.3uJ, no enumeration since there is no domain
> >>> specific MSR for energy unit.  
> >> Which document are you referring to?
> > Intel DocID:330784-001 Sept 2014
> > Intel Xeon Processor E5-1600 and E5-2600 V2 of 2.
> 
> I think V2 is Ivy Bridge.  Is this typo?
>  
v2 is volume 2, glad you found the doc.

BTW, i just sent out v2 of the patch to address the issues, changes are
1. use pJ for driver energy unit
2. fix max_energy_range_uj, makes it per domain
3. add reference doc info to commit message

Thanks,

Jacob
> By googling, I found a datasheet titled:
> "Intel Xeon Processor E5-1600 and E5-2600 v3 Product Families, Volume
> 2 of 2. Datasheet, September 2014, Reference Number: 330784-001 "
> 
> It clearly says "ENERGY_UNIT for DRAM domain is 15.3uJ."
> 
> - kaz
> 




-- 
Jacob Pan
