From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: Properly handle errors from
 cpufreq_init_policy()
Date: Thu, 16 Jul 2015 10:16:14 +0100
Message-ID: <1437038174.2842.6.camel@linaro.org>
References: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org>
	 <1436354276.2844.20.camel@linaro.org> <20150708112023.GE1805@linux>
	 <3547840.51rbRs871Y@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smarthost01b.mail.zen.net.uk ([212.23.1.3]:46456 "EHLO
	smarthost01b.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754015AbbGPJQS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2015 05:16:18 -0400
In-Reply-To: <3547840.51rbRs871Y@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Thu, 2015-07-16 at 02:32 +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 08, 2015 04:50:23 PM Viresh Kumar wrote:
> > On 08-07-15, 12:17, Jon Medhurst (Tixy) wrote:
> > > I tried these patches without the earlier "cpufreq: Initialize the
> > > governor again while restoring policy" patch.
> > > 
> > > The result is that the error when bringing a cpu online is with flagged
> > > up with a kernel message:
> > > 
> > >   cpufreq: cpufreq_add_dev: Failed to initialize policy for cpu: 1 (-16)
> > > 
> > > and afterwards, the sysfs entries that I was poking and causing the
> > > crash aren't present. So looks like this patch has done what we want,
> > > and cleaned things up after an error. So...
> > > 
> > > Tested-by: Jon Medhurst <tixy@linaro.org>
> > > 
> > > Thanks for the prompt fix.
> > 
> > And thanks for your help in getting these tested :)
> 
> Both queued up for 4.3, thanks!

The crash I was getting was a regression caused by changes that went
into 4.2-rc1.

Indeed, the first patch from Viresh is marked:

Fixes: 18bf3a124ef8 ("cpufreq: Mark policy->governor = NULL for inactive policies")
For 4.2-rc

And I am having to carry that first patch to keep two ARM big.LITTLE
platforms working.

-- 
Tixy

