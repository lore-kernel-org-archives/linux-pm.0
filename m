From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: pr_err()/pr_info() strings
 should end with newlines
Date: Mon, 09 Oct 2017 21:37:45 -0700
Message-ID: <1507610265.3552.20.camel@perches.com>
References: <277b8d12fc6980ec2ffd039a872f681ec0e49c19.1507549738.git.arvind.yadav.cs@gmail.com>
         <7555b065-f4de-2988-283b-b6800ce189ab@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:45279 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750734AbdJJEhu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 00:37:50 -0400
In-Reply-To: <7555b065-f4de-2988-283b-b6800ce189ab@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-10-09 at 14:33 +0200, Daniel Lezcano wrote:
> On 09/10/2017 13:51, Arvind Yadav wrote:
> > pr_err()/pr_info() messages should end with a new-line to avoid
> > other messages being concatenated.
[]
> > diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
> > @@ -675,13 +675,13 @@ static int __init powerclamp_probe(void)
> >  {
> >  
> >  	if (!x86_match_cpu(intel_powerclamp_ids)) {
> > -		pr_err("CPU does not support MWAIT");
> > +		pr_err("CPU does not support MWAIT\n");

[etc...]

> Hi Arvind,
> 
> you are sending these fixes for all the drivers around. There is a way
> to fix this once and for all: use the coccinelle tools [1], add the
> script in the changelog with a big patchset and add the script in the
> coccinelle scripts directory [2].

That can't work as any printk without a newline termination
could be followed by a printk(KERN_CONT/pr_cont( in another
function.

All of these must be hand-verified.
