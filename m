From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/5] powernv: Enable Dynamic Frequency
Date: Fri, 21 Mar 2014 13:49:42 +0530
Message-ID: <20140321081942.GE27293@in.ibm.com>
References: <1395317460-14811-1-git-send-email-ego@linux.vnet.ibm.com>
 <CAOh2x=mYnRWEqs=qBi4C4OWog+ds85=e+uDTJGpojozEr-XKhQ@mail.gmail.com>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:44731 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545AbaCUIUF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 21 Mar 2014 04:20:05 -0400
Received: from /spool/local
	by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Fri, 21 Mar 2014 04:20:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7F1F8C90041
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 04:19:55 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp22033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2L8JxUs8716694
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 08:19:59 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2L8JwNC008579
	for <linux-pm@vger.kernel.org>; Fri, 21 Mar 2014 04:19:58 -0400
Content-Disposition: inline
In-Reply-To: <CAOh2x=mYnRWEqs=qBi4C4OWog+ds85=e+uDTJGpojozEr-XKhQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com

Hi Viresh,

On Fri, Mar 21, 2014 at 01:16:03PM +0530, Viresh Kumar wrote:
> On Thu, Mar 20, 2014 at 5:40 PM, Gautham R. Shenoy
> <ego@linux.vnet.ibm.com> wrote:
> > This is the v3 of the consolidated patchset consisting
> > patches for enabling cpufreq on IBM POWERNV platforms
> > along with some enhancements.
> 
> This is the first time I saw them. Looks like you never Cc'd linux-pm list.
> Also, would be better to keep Maintainers in --to field so that they can
> review them as soon as possible. Otherwise they might stay on lists for
> a long time..

Yes, I hadn't Cc'ed linux-pm list last time around. Sorry about
that. Will keep this in mind the next time around. Also, your
suggestion regarding keeping the Maintainers in --to field is well
taken.

--
Thanks and Regards
gautham.
> 

