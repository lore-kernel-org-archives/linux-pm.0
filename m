From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Mon, 11 Nov 2013 08:40:22 -0800
Message-ID: <52810876.2000402@linux.intel.com>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111163859.GE26898@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37170 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab3KKQlo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Nov 2013 11:41:44 -0500
In-Reply-To: <20131111163859.GE26898@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, l.majewski@samsung.com, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

On 11/11/2013 8:38 AM, Peter Zijlstra wrote:
> Like the package C states on x86 -- for those to be effective the
> scheduler needs to pack tasks and keep entire packages idle for as long
> as possible.

"package" C states on x86 are not really per package... but system wide.
the name is very confusing.

