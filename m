From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC][PATCH v5 00/14] sched: packing tasks
Date: Mon, 11 Nov 2013 17:43:04 -0500 (EST)
Message-ID: <alpine.LFD.2.10.1311111742040.9667@knanqh.ubzr>
References: <1382097147-30088-1-git-send-email-vincent.guittot@linaro.org> <CAHkRjk69GNYtLGBSWCNcsCzkBHywKrD0qQQbNkJRpMbcdsCPyw@mail.gmail.com> <20131111165453.GB4586@e103034-lin> <20131111183142.GF29572@arm.com> <52812F6D.8090404@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:36770 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab3KKWnI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2013 17:43:08 -0500
Received: by mail-qc0-f174.google.com with SMTP id v2so1143898qcr.33
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2013 14:43:07 -0800 (PST)
In-Reply-To: <52812F6D.8090404@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>, Chris Metcalf <cmetcalf@tilera.com>, Tony Luck <tony.luck@intel.com>, "alex.shi@intel.com" <alex.shi@intel.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, linaro-kernel <linaro-kernel@lists.linaro.org>, "len.brown@intel.com" <len.brown@intel.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Mon, 11 Nov 2013, Arjan van de Ven wrote:

> On 11/11/2013 10:31 AM, Catalin Marinas wrote:
> > I agree, we can't rely on the requested C-state but the_actual_  state
> > and this means querying the hardware driver. Can we abstract this via
> > some interface which provides the cost of waking up a CPU? This could
> > take into account the state of the other CPUs in the cluster and the
> > scheduler is simply concerned with the wake-up costs.
> 
> can you even query this without actually waking up the cpu and asking ???

On those systems we're interested in we sure can.


Nicolas
