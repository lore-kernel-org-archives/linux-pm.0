From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [RFCv4 PATCH 13/34] sched: Documentation for scheduler energy
 cost model
Date: Wed, 20 May 2015 09:34:38 +0530
Message-ID: <20150520040436.GA20318@linux.vnet.ibm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
 <1431459549-18343-14-git-send-email-morten.rasmussen@arm.com>
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:53722 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbETEE5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2015 00:04:57 -0400
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <kamalesh@linux.vnet.ibm.com>;
	Wed, 20 May 2015 09:34:54 +0530
Content-Disposition: inline
In-Reply-To: <1431459549-18343-14-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, preeti@linux.vnet.ibm.com, mturquette@linaro.org, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

* Morten Rasmussen <morten.rasmussen@arm.com> [2015-05-12 20:38:48]:

[...]
> +Energy consumed during transitions from an idle-state (C-state) to a busy state
> +(P-staet) or going the other way is ignored by the model to simplify the energy

Minor, nit pick. Spelling of "P-State".

> +model calculations.

Thanks,
Kamalesh.

