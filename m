From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Fri, 18 Sep 2015 03:47:53 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026584EB5@SHSMSX101.ccr.corp.intel.com>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
 <20150917060735.GF6665@amd>
 <36DF59CE26D8EE47B0655C516E9CE64026584C75@SHSMSX101.ccr.corp.intel.com>
 <20150917204343.GA14658@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:7300 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbbIRDsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2015 23:48:07 -0400
In-Reply-To: <20150917204343.GA14658@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "jlee@suse.com" <jlee@suse.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>

Thanks, Pavel,

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Pavel Machek
> Sent: Friday, September 18, 2015 4:44 AM
> To: Chen, Yu C
> Cc: rjw@rjwysocki.net; Brown, Len; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Zhang, Rui; jlee@suse.com;
> joeyli.kernel@gmail.com; yinghai@kernel.org; Ingo Molnar
> Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
> inconsistent e820 map
> 
> Yes, that's better.
> 
> But I still don't like the patch.
> 
> 0) BIOS is broken, and this does not completely work around it. Users will still
> see the failed hibernation when the memory that is now unavailable was
> actually used.
> 
Unfortunately , yes :(  the patch is trying to replace the 'panic' with 'failure', because I guess 'failure'
is a little better than a 'panic' ? It is a workaround for inconsistent BIOS. 
Actually, according to ACPI spec 5, page 626, BIOS should not change its memory table
during S4:
" The memory information returned from the system address map 
reporting interfaces should be the same before and after an S4 sleep"


> 1) It allocates bm3 even on systems that don't need the workaround (arm,
> ia32)
> 
 I'll try to solve this.
> 2) If you use hibernation on 32-bit kernel on affected system, you'll still get
> panic.
> 
I think 32 bit kernel will not get panic?  because:
1) If the page to be restored is in low memory, 
     it will be checked by swsusp_page_is_valid, 
     which will check if the page is in the directly-mapped region(pfn_mapped),
     for 32 bit kernel, the pfn_mapped region contains mapping lower than max_low_pfn.
    so accessing  low memory is ok.

2) if the page to be restored is in high memory, it will be accessed by
    kmap_atomic, so accessing high memory is ok.

> 3) I'm not sure I understand the changelog correctly. What happens when
> BIOS reports less memory on hibernation? Will you magically remove
> memory from kernel at runtime? Will /proc/meminfo be invalid after resume?
> Will all the memory management tuning need fixing?
> 
Oh, I did not notice it before. So deleting the logic of 
' info->num_physpages != get_num_physpages()' is not suitable. 
The subset relationship should not be considered in this patch.

> Changelog is really confusing. "failor" is not a english word.
> 
Sorry for my poor English, I'll check it again.

> After this patch applied, the panic will be replaced with the warning:
> 
> ...
> 
> according to your explanation, panic will be replaced with the resume failure,
> not mere warning.
> 
> I believe we have case of "this BIOS problem can not be reasonably worked
> around" here.
> 
Agree, so I guess the current patch is trying to make the problem more acceptable to user,
at least  make user aware of the inconsistent BIOS.

Thanks!


Best Regards,
Yu

