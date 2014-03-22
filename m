From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Sat, 22 Mar 2014 09:13:21 +0530
Message-ID: <CAKohpomMTJ8dHg7i48fEACCvr7evXRvtbNrv5TJCYLL1v6iY5g@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
	<20140321104317.GA2493@in.ibm.com>
	<20140321144818.GA30371@dirshya.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:65187 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757AbaCVDnV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 23:43:21 -0400
Received: by mail-ob0-f169.google.com with SMTP id va2so3469699obc.28
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 20:43:21 -0700 (PDT)
In-Reply-To: <20140321144818.GA30371@dirshya.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 21 March 2014 20:18, Vaidyanathan Srinivasan
<svaidy@linux.vnet.ibm.com> wrote:
> Yeah, I had the driver written using driver_data to store pstates.
> Gautham found the bug that we are missing one PState when we match the
> ID with CPUFREQ_BOOST_FREQ!

I see..

> We did not know that you have taken care of those issues.  Ideally
> I did expect that driver_data should not be touched by the framework.
> Thanks for fixing that and allowing the back-end driver to use
> driver_data.

No, I haven't fixed anything yet. And this piece of code still exists.
I will see if I can get this fixed, by that time you can continue the
way your code is there in this version.
