From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Fri, 18 Sep 2015 06:11:36 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64026584F10@SHSMSX101.ccr.corp.intel.com>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
 <20150917060735.GF6665@amd>
 <36DF59CE26D8EE47B0655C516E9CE64026584C75@SHSMSX101.ccr.corp.intel.com>
 <20150917204343.GA14658@amd>
 <36DF59CE26D8EE47B0655C516E9CE64026584EB5@SHSMSX101.ccr.corp.intel.com>
 <20150918054719.GA18701@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18687 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019AbbIRGME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 02:12:04 -0400
In-Reply-To: <20150918054719.GA18701@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "jlee@suse.com" <jlee@suse.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>


Hi, Pavel,

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Friday, September 18, 2015 1:47 PM
> To: Chen, Yu C
> Cc: rjw@rjwysocki.net; Brown, Len; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; Zhang, Rui; jlee@suse.com;
> joeyli.kernel@gmail.com; yinghai@kernel.org; Ingo Molnar
> Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
> inconsistent e820 map
> 
> > > 3) I'm not sure I understand the changelog correctly. What happens
> > > when BIOS reports less memory on hibernation? Will you magically
> > > remove memory from kernel at runtime? Will /proc/meminfo be invalid
> after resume?
> > > Will all the memory management tuning need fixing?
> > >
> > Oh, I did not notice it before. So deleting the logic of '
> > info->num_physpages != get_num_physpages()' is not suitable.
> > The subset relationship should not be considered in this patch.
> 
> Ok. So... if you really want, you can add some messages like "hey, this is bios
> bug, maybe updating bios is a good idea".. but please lets keep the original
> logic.
> 
OK. I see, I'll not change its original code.
So can I add a function here that checks if current BIOS  e820 map is 
strictly the same as it was before S4?  If it is not the same, we will print some warnnings
, and if we panic later, we will print that , the panic reason might be due to broken BIOS.
I think I can archive this by putting  the e820_saved array  into struct swsusp_info, 
 and pass it to second kernel: 
struct swsusp_info will always occupy one page size, and has a lot of extra space left,
meanwhile the total size of e820 map will not exceed the PAGE_SIZE currently, it's safe 
to put it in struct swsusp_info.

And this does not need much changing of current code. What do you think? Thanks.

Best Regards,
Yu



