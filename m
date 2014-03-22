From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 1/5] powernv: cpufreq driver for powernv platform
Date: Sat, 22 Mar 2014 09:13:53 +0530
Message-ID: <CAKohponk-attkX9O+Q2y_YcKYsNRHc6TQz5MZeQe_VPXzKR2wA@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-2-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x=kp65vrKamtxxR9iCX+t-S3nDJP05+1mfpOiWzbWpfGYA@mail.gmail.com>
	<20140321104317.GA2493@in.ibm.com>
	<CAKohpo=JqHOPF_pdcAsvRgc1vENmS=Sg9pS8ZXPGhfMFnA8ZUA@mail.gmail.com>
	<20140321145452.GA8755@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:37073 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaCVDny (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 23:43:54 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so3528291oac.30
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 20:43:54 -0700 (PDT)
In-Reply-To: <20140321145452.GA8755@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>

On 21 March 2014 20:24, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Ok, I guess the right thing to do at this point is call
>
>    cpufreq_table_validate_and_show(policy, powernv_freqs);
>
> Will fix the code to take care of this.

Yes.
