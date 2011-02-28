From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] intel_idle: disable NHM/WSM HW C-state
	auto-demotion (v3)
Date: Mon, 28 Feb 2011 11:08:50 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1102281105460.17782__15357.8732432381$1298909444$gmane$org@x980>
References: <alpine.LFD.2.02.1101182150400.14668@x980>
	<alpine.LFD.2.02.1101190035200.14668@x980>
	<alpine.LFD.2.02.1102160119430.843@x980>
	<AANLkTinVCvUkmX3pnSy_Ah3fOm6hV-jAPrQXAQ971xnS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <AANLkTinVCvUkmX3pnSy_Ah3fOm6hV-jAPrQXAQ971xnS@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > Hardware C-state auto-demotion is a mechanism where the HW overrides
> > the OS C-state request, instead demoting to a shallower state,
> > which is less expensive, but saves less power.

> I'm interrested, for pytimechart, to have trace information of what
> actual c-state got reached after each idle request.
> Do you have any info on how to get that?

the actual c-state residency can be seen in the residency 
counters that are exported by turbostat.
However, at the time of the request/return the OS doesn't know
that it's request got demoted demoted (or un-demoted).

No, checking the counters is not something we want to
add to the idle entry/exit path -- they are not optimized for speed.

thanks,
Len Brown, Intel Open Source Technology Center
