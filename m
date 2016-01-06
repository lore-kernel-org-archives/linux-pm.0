From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 0/2] cpufreq: powernv: Redesign the presentation of throttle notification
Date: Wed, 06 Jan 2016 17:51:57 +1100
Message-ID: <877fjnjj3m.fsf@linux.vnet.ibm.com>
References: <1451686914-3761-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:52131 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbcAFGwX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 01:52:23 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Tue, 5 Jan 2016 23:52:22 -0700
In-Reply-To: <1451899527-14359-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net, pc@us.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> In POWER8, OCC(On-Chip-Controller) can throttle the frequency of the
> CPU when the chip crosses its thermal and power limits. Currently,
> powernv-cpufreq driver detects and reports this event as a console
> message. Some boxes may not sustain the max turbo frequency in all
> conditions and can be throttled frequently. This can lead to the
> flooding of console with throttle messages. So this patchset aims to
> redesign the presentation of this event via sysfs counters and
> tracepoints.

This likely should CC stable@ as we have seen this on some machines, at
least in the lab.

-- 
Stewart Smith
OPAL Architect, IBM.

