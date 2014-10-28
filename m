From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC/PATCH] PM / Sleep: Timer quiesce in freeze state
Date: Tue, 28 Oct 2014 09:29:00 +0100
Message-ID: <20141028082900.GP3337@twins.programming.kicks-ass.net>
References: <5446787E.60202@linux.intel.com>
 <20141024153656.GM12706@worktop.programming.kicks-ass.net>
 <544DE5CF.9040501@linux.intel.com>
 <20141027072816.GD10501@worktop.programming.kicks-ass.net>
 <544F1C50.8010505@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56637 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289AbaJ1I3F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 04:29:05 -0400
Content-Disposition: inline
In-Reply-To: <544F1C50.8010505@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>, "alan@linux.intel.com" <alan@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org >> Linux PM list" <linux-pm@vger.kernel.org>

On Tue, Oct 28, 2014 at 12:32:16PM +0800, Li, Aubrey wrote:
> On 2014/10/27 15:28, Peter Zijlstra wrote:
> > On Mon, Oct 27, 2014 at 02:27:27PM +0800, Li, Aubrey wrote:
> >>> Now I suppose the problem is with cpu_pause() which needs IPIs to
> >>> complete? Do we really need cpuidle_pause() there?
> >>> cpuidle_uninstall_handlers() seems like a daft thing to call just about
> >>> there.
> >>
> >> Please check the log of 8651f97bd951d0bb1c10fa24e3fa3455193f3548.
> >> Rafael should know more this question than me.
> > 
> > That changelog explains its complete bollocks to do it here. We _want_
> > to enter and/or remain in deep idle states.
> 
> cpuidle_resume() will be called at the end of dpm_resume_noirq(). So we
> still are able to enter deep idle states after resume.

cpuidle_resume is absolute crap, as is cpuidle_suspend for that matter
-- in this case.

The only reason we needed cpuidle_suspend is because some BIOS shat its
pants when some CPUs were in higher C states while trying to do the S3
thing. We're not going to use S states or BIOS calls _at_all_, so no
point in kicking CPUs out of their deep C states.

Read that changelog you referred me to again.
