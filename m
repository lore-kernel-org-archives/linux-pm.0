From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 5/5] powernv:cpufreq: Implement the driver->get() method
Date: Fri, 21 Mar 2014 18:04:08 +0530
Message-ID: <CAKohpo=E1UEcLhbZHtmBJcD3S3trm8ypT7++quF_t6XHDXAvHA@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-6-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x==9JT-q2w95Ub_Ck_UMPcWY_4vo_Y44-i=DPjtu0jxwZg@mail.gmail.com>
	<20140321110445.GB2493@in.ibm.com>
	<CAKohpo=k-e1GLiLRNtJ3Xi3+NUWW1+gvtCNr_4Ag60j49dZvdQ@mail.gmail.com>
	<063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63589 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbaCUMeJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 08:34:09 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so2359858obb.4
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 05:34:09 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6E5386@AcuExch.aculab.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Linux PM list <linux-pm@vger.kernel.org>

On 21 March 2014 17:31, David Laight <David.Laight@aculab.com> wrote:
>> *(int *)ret_freq = freq;
>
> Because it is very likely to be wrong.
> In general casts of pointers to integer types are dangerous.

Where are we converting pointers to integers? We are doing a
cast from 'void * ' to 'int *' and then using indirection operator
to set its value.
