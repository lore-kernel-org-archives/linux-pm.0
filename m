From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH v2] drivers/idle: make intel_idle.c driver more
 explicitly non-modular
Date: Thu, 21 Apr 2016 13:42:18 -0400
Message-ID: <20160421174217.GM13379@windriver.com>
References: <20160407165355.GA9188@linaro.org>
 <1461165906-21614-1-git-send-email-paul.gortmaker@windriver.com>
 <20160420181322.GM5862@linaro.org>
 <20160421031249.GH13379@windriver.com>
 <20160421080427.GC14010@linaro.org>
 <20160421124454.GJ13379@windriver.com>
 <20160421132137.GA18670@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:53668 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933AbcDURmc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 13:42:32 -0400
Content-Disposition: inline
In-Reply-To: <20160421132137.GA18670@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, rcochran@linutronix.de, linux-pm@vger.kernel.org

[Re: [PATCH v2] drivers/idle: make intel_idle.c driver more explicitly non-modular] On 21/04/2016 (Thu 15:21) Daniel Lezcano wrote:

> On Thu, Apr 21, 2016 at 08:44:55AM -0400, Paul Gortmaker wrote:
> > [Re: [PATCH v2] drivers/idle: make intel_idle.c driver more explicitly non-modular] On 21/04/2016 (Thu 10:04) Daniel Lezcano wrote:
> > 
> > > On Wed, Apr 20, 2016 at 11:12:49PM -0400, Paul Gortmaker wrote:
> > > 
> > > [ ... ]
> > > 
> > > > > > We replace module.h with moduleparam.h since the file does declare
> > > > > > some module parameters, and leaving them as such is currently the
> > > > > > easiest way to remain compatible with existing boot arg use cases.
> > > > > 
> > > > > What about using __setup() ? so module* disappear from the file.
> > > > 
> > > > No, it can't be __setup since moduleparam uses an instance of the
> > > > filename as a prefix to the boot arg, and __setup does not.  And we
> > > > should stay compatible with existing boot arg use cases for people
> > > > who have embedded such a setting in their grub config a long time
> > > > ago and forgot it.  It would take looking at and likely extending the
> > > > early_param macro to provide a syntax compatible instance of what
> > > > the module_param currently does if I recall correctly -- hence the
> > > > above comment in the commit log.
> > > 
> > > -module_param(max_cstate, int, 0444);
> > > +static int __init max_cstate_param(char *str)
> > > +{
> > > +       max_cstate = simple_strtol(str, NULL, 0);
> > > +       return 1;
> > > +}
> > > +__setup("intel_idle.max_cstate=", max_cstate_param);
> > 
> > Yeah, I recall thinking it would be that easy too, but there was
> > something that happens when you manually insert the dot in there that
> > breaks processing.  I'd have to re-test to remind myself what failed.
> 
> Ok.
> 
> I quickly tested this code snippet and, except I missed something, it 
> worked.

Maybe it was when I used early_param in testing that it failed....

> 
> That said, I looked around and found that using module_param() for 
> non-modular is found in several places, so it is common. I don't like to 
> find references to modular code when the the caller is not supposed to be 

Agreed, I wasn't a fan of it either, and had it on my to-do list to
circle back around and revisit them once I'd got all the dead code
removed tree wide, and as you say, there are instances already, so I
figured no real drastic rush needed for that.

> modular but that's the situation today.
> 
> So I will let Len and you decice what to do ;)
> 
> Other than that: Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks for the input on this.  It is Len's subsystem, so he gets the final
say and not me.  :)

Paul.
--
