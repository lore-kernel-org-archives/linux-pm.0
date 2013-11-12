From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Tue, 12 Nov 2013 08:48:41 -0800
Message-ID: <52825BE9.2080605@linux.intel.com>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111163630.GD26898@twins.programming.kicks-ass.net> <52810851.4090907@linux.intel.com> <20131111181805.GE29572@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15784 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213Ab3KLQsn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 Nov 2013 11:48:43 -0500
In-Reply-To: <20131111181805.GE29572@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11/11/2013 10:18 AM, Catalin Marinas wrote:
> The ordering is based on the actual C-state, so a simple way is to wake
> up the CPU in the shallowest C-state. With asymmetric configurations
> (big.LITTLE) we have different costs for the same C-state, so this would
> come in handy.

btw I was considering something else; in practice CPUs will be in the deepest state..
... at which point I was going to go with some other metrics of what is best from a platform level

