From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Fri, 21 Mar 2014 19:04:27 +0530
Message-ID: <CAKohpom9MFsWjionC0S7zyZ479s8tsK150hhZ0frdJ-QKN_ZNg@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
	<20140321104317.GA2493@in.ibm.com>
	<CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
	<20140321132326.GE2493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:54511 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761018AbaCUNe2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 09:34:28 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so2438479obb.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 06:34:27 -0700 (PDT)
In-Reply-To: <20140321132326.GE2493@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 21 March 2014 18:53, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Ok, I had based my code on linus's git tree. I checked the 'pm-cpufreq'

Always check his bleeding-edge or linux-next branch.

> branch of Rafael's 'linux-pm' tree and freq_table.c contains the
> following code snippet in show_available_frequencies:
>
>         if (show_boost ^ (table[i].driver_data == CPUFREQ_BOOST_FREQ))
>                         continue;
>
> I suspect we're talking about different code bases. So could you
> please tell me which one should I be looking at ?

Okay, there is some problem here. I will check how can I simplify this..
And yes, you were correct.

>> Because cpufreq_frequency_table_get_attr() and
>> cpufreq_frequency_table_put_attr() don't exist anymore :)
>
> Well, it does in the codebases that I was looking at. May be I've been
> looking at the wrong place.

Check the one I mentioned.
