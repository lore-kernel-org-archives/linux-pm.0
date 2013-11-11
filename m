From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Mon, 11 Nov 2013 11:26:37 -0800
Message-ID: <52812F6D.8090404@linux.intel.com>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111165453.GB4586@e103034-lin> <20131111183142.GF29572@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30162 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710Ab3KKT1E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 Nov 2013 14:27:04 -0500
In-Reply-To: <20131111183142.GF29572@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11/11/2013 10:31 AM, Catalin Marinas wrote:
> I agree, we can't rely on the requested C-state but the_actual_  state
> and this means querying the hardware driver. Can we abstract this via
> some interface which provides the cost of waking up a CPU? This could
> take into account the state of the other CPUs in the cluster and the
> scheduler is simply concerned with the wake-up costs.

can you even query this without actually waking up the cpu and asking ???

