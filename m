From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Date: Fri, 21 Mar 2014 18:42:50 +0530
Message-ID: <CAKohpomHHToqOND=ZtMeqBd11X3VA=PeZ2K6Tyj31y2V4G9-uA@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
	<20140321110445.GB2493@in.ibm.com>
	<CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
	<20140321130450.GD2493@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:39003 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbaCUNMu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 09:12:50 -0400
Received: by mail-oa0-f41.google.com with SMTP id j17so2498078oag.28
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 06:12:50 -0700 (PDT)
In-Reply-To: <20140321130450.GD2493@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On 21 March 2014 18:34, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Consider the case when pmspr = 0x00feffffffffffff;
>
> We are interested in extracting the value 'fe'. And ensure that when
> we store this value into an int, we get the sign extension right.
>
> So the following doesn't work:
>
>    pstate_id = (pmspr_val >> 48) & 0xFFFFFFFF;

What about pstate_id = (pmspr_val >> 48) & 0xFF; ??
