From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 4/5] powernv:cpufreq: Export nominal frequency via sysfs.
Date: Fri, 21 Mar 2014 15:27:19 +0530
Message-ID: <CAKohponhtLO1o6Dmr+=8-PM90tPMfJzPO_vr_bh5-xLphb-=MA@mail.gmail.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
	<1395317460-14811-5-git-send-email-ego@linux.vnet.ibm.com>
	<CAOh2x=kLwDGFtHR5sBKhE-9L=3=npV4_i+B+BVm+yBocmmMvzQ@mail.gmail.com>
	<20140321095534.GF27293@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:64285 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061AbaCUJ5T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Mar 2014 05:57:19 -0400
Received: by mail-ob0-f170.google.com with SMTP id uz6so2221388obc.15
        for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 02:57:19 -0700 (PDT)
In-Reply-To: <20140321095534.GF27293@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On 21 March 2014 15:25, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> Probably the use of ATTR_RO(cpuinfo_nominal_freq) and renaming
> show_cpuinfo_nominal_freq to cpuinfo_nominal_freq_show() would be even
> better. What do you think ?

+1
