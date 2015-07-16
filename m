From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] cpufreq: Properly handle errors from cpufreq_init_policy()
Date: Thu, 16 Jul 2015 02:32:14 +0200
Message-ID: <3547840.51rbRs871Y@vostro.rjw.lan>
References: <276debea91831d86c34079f6a40d773ce258a62c.1436348436.git.viresh.kumar@linaro.org> <1436354276.2844.20.camel@linaro.org> <20150708112023.GE1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64616 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753768AbbGPAFg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2015 20:05:36 -0400
In-Reply-To: <20150708112023.GE1805@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Jon Medhurst (Tixy)" <tixy@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Wednesday, July 08, 2015 04:50:23 PM Viresh Kumar wrote:
> On 08-07-15, 12:17, Jon Medhurst (Tixy) wrote:
> > I tried these patches without the earlier "cpufreq: Initialize the
> > governor again while restoring policy" patch.
> > 
> > The result is that the error when bringing a cpu online is with flagged
> > up with a kernel message:
> > 
> >   cpufreq: cpufreq_add_dev: Failed to initialize policy for cpu: 1 (-16)
> > 
> > and afterwards, the sysfs entries that I was poking and causing the
> > crash aren't present. So looks like this patch has done what we want,
> > and cleaned things up after an error. So...
> > 
> > Tested-by: Jon Medhurst <tixy@linaro.org>
> > 
> > Thanks for the prompt fix.
> 
> And thanks for your help in getting these tested :)

Both queued up for 4.3, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
