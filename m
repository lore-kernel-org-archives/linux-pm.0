From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver
	and its DT glue
Date: Thu, 7 Mar 2013 00:51:19 +0000
Message-ID: <20130307005119.GY17833@n2100.arm.linux.org.uk>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org> <20130305105251.GL17833@n2100.arm.linux.org.uk> <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55732 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805Ab3CGAvi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Mar 2013 19:51:38 -0500
Content-Disposition: inline
In-Reply-To: <CAKohpo=cBkHZnSa8ZsM=k7RRN+RZDXFUWDM82EXXBSQcM-8Vhw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, Steve.Bannister@arm.com, linux-pm@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Liviu.Dudau@arm.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, robin.randhawa@arm.com, linux-arm-kernel@lists.infradead.org, mark.hambleton@broadcom.com, linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com

On Thu, Mar 07, 2013 at 08:32:37AM +0800, Viresh Kumar wrote:
> On 5 March 2013 18:52, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > On Tue, Mar 05, 2013 at 12:52:41PM +0800, Viresh Kumar wrote:
> >> +     clk[cluster] = clk_get(NULL, name);
> >> +     if (!IS_ERR_OR_NULL(clk[cluster])) {
> >
> > NAK.  Two reasons.
> >
> > 1. IS_ERR_OR_NULL.  You know about this, it's been on the list several
> >    times.
> 
> Hey, i had a second thought about this one and i have some other opinion
> here. This is a cpufreq driver and we need clock support for sure here, we
> can't work without it. And so here is the latest fixup:

NAK.  You just don't understand.
