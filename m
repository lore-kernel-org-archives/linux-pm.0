From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Mon, 11 Nov 2013 10:20:17 -0800
Message-ID: <52811FE1.2020404@linux.intel.com>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111163630.GD26898@twins.programming.kicks-ass.net> <52810851.4090907@linux.intel.com> <20131111181805.GE29572@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:45333 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754975Ab3KKSUU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Nov 2013 13:20:20 -0500
In-Reply-To: <20131111181805.GE29572@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11/11/2013 10:18 AM, Catalin Marinas wrote:

>
> Even for symmetric configuration, the cost of moving a task to a CPU
> includes wake-up cost plus the run-time cost which depends on the
> P-state after wake-up (that's much trickier since we can't easily
> estimate the cost of a P-state and it may change once you place a task
> on it).

yup including cache refill times (assuming you picked C states
that flushed the cache, which will be the common case... but even
if not, since you're moving at task the likelyhood of cache coldness is high)

