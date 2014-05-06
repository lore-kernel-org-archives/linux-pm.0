From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 5/5] thermal: add trace events to the power
 allocator governor
Date: Tue, 6 May 2014 08:28:16 -0400
Message-ID: <20140506082816.186d3603@gandalf.local.home>
References: <1399377998-14870-1-git-send-email-javi.merino@arm.com>
	<1399377998-14870-6-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:18982 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756228AbaEFMbT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 May 2014 08:31:19 -0400
In-Reply-To: <1399377998-14870-6-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, Punit.Agrawal@arm.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@redhat.com>

On Tue,  6 May 2014 13:06:38 +0100
Javi Merino <javi.merino@arm.com> wrote:


> Hi trace maintainers,

Hi Javi,

> 
> We would like to add cpumask to a trace point.  We currently allocate
> a string and print the mask there with cpumask_scnprintf() which is a
> bit heavyweight.  Will it be possible to add this capability to ftrace
> so that we can add the cpumask to the trace buffer and then trace-cmd
> prints the mask when reporting?

Hmm, that shouldn't be too hard. I would suggest making it work like a
dynamic array, as we don't want to store more bits than necessary.

I'll see if I can whip something up.

-- Steve

