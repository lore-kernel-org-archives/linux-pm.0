From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] intel_pstate: enable hwp per cpu
Date: Wed, 15 Jul 2015 07:41:45 -0700
Message-ID: <20150715074145.686897b7@kcaccard-desk.amr.corp.intel.com>
References: <1436892383-4217-1-git-send-email-kristen@linux.intel.com>
	<20150714105832.43ef93d0@kcaccard-desk.amr.corp.intel.com>
	<CADjb_WSyVQNeeKEoC+MEUfwZTEpzuAO8-Bwae24Z49vJCKewTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:50763 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbbGOOlp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 15 Jul 2015 10:41:45 -0400
In-Reply-To: <CADjb_WSyVQNeeKEoC+MEUfwZTEpzuAO8-Bwae24Z49vJCKewTQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: yu chen <yu.chen.surf@gmail.com>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org

On Wed, 15 Jul 2015 19:17:53 +0800
yu chen <yu.chen.surf@gmail.com> wrote:

> On Wed, Jul 15, 2015 at 1:58 AM, Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
> 
> >
> > Oops - don't apply this one yet please.  I think I
> > might have broken S3 resume.
> >
> 
> Hi, Kristen
> This patch will fix the S3 resume panic bug.
> We encountered panic on kernel without this patch applied last week.
> After this patch applied,  each cpu will get a chance to
> re-enable HWP in intel_pstate_cpu_init, after resuming.
> 
> Yu

Ok.  Rafael, would you mind applying the patch after all?  False
alarm :).

Thanks,
Kristen
