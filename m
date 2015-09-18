From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] [v4] PM / hibernate: Fix hibernation panic caused by
 inconsistent e820 map
Date: Fri, 18 Sep 2015 07:47:20 +0200
Message-ID: <20150918054719.GA18701@amd>
References: <1442425343-8339-1-git-send-email-yu.c.chen@intel.com>
 <20150917060735.GF6665@amd>
 <36DF59CE26D8EE47B0655C516E9CE64026584C75@SHSMSX101.ccr.corp.intel.com>
 <20150917204343.GA14658@amd>
 <36DF59CE26D8EE47B0655C516E9CE64026584EB5@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51805 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbIRFrX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 01:47:23 -0400
Content-Disposition: inline
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE64026584EB5@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, "jlee@suse.com" <jlee@suse.com>, "joeyli.kernel@gmail.com" <joeyli.kernel@gmail.com>, "yinghai@kernel.org" <yinghai@kernel.org>, Ingo Molnar <mingo@kernel.org>

Hi!

> > But I still don't like the patch.
> > 
> > 0) BIOS is broken, and this does not completely work around it. Users will still
> > see the failed hibernation when the memory that is now unavailable was
> > actually used.
> > 
> Unfortunately , yes :(  the patch is trying to replace the 'panic' with 'failure', because I guess 'failure'
> is a little better than a 'panic' ? It is a workaround for
> inconsistent BIOS.

I don't see the failure being better than panic here... and it is
certainly not worth the extra code.

And you can improve the panic message (or turn it into some other
printk) without any extra changes.

> Actually, according to ACPI spec 5, page 626, BIOS should not change its memory table
> during S4:
> " The memory information returned from the system address map 
> reporting interfaces should be the same before and after an S4 sleep"

Good.

> > 3) I'm not sure I understand the changelog correctly. What happens when
> > BIOS reports less memory on hibernation? Will you magically remove
> > memory from kernel at runtime? Will /proc/meminfo be invalid after resume?
> > Will all the memory management tuning need fixing?
> > 
> Oh, I did not notice it before. So deleting the logic of 
> ' info->num_physpages != get_num_physpages()' is not suitable. 
> The subset relationship should not be considered in this patch.

Ok. So... if you really want, you can add some messages like "hey,
this is bios bug, maybe updating bios is a good idea".. but please
lets keep the original logic.

Best regards,

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
