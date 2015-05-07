From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/6] cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
Date: Thu, 07 May 2015 22:59:51 +0200
Message-ID: <4161534.4Jyd5dl4um@vostro.rjw.lan>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <5548824C.2030602@linux.vnet.ibm.com> <554B584A.3030507@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61890 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750876AbbEGUer (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 16:34:47 -0400
In-Reply-To: <554B584A.3030507@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

On Thursday, May 07, 2015 05:49:22 PM Preeti U Murthy wrote:
> On 05/05/2015 02:11 PM, Preeti U Murthy wrote:
> > On 05/05/2015 12:03 PM, Shilpasri G Bhat wrote:
> >> Hi Preeti,
> >>
> >> On 05/05/2015 09:30 AM, Preeti U Murthy wrote:
> >>> Hi Shilpa,
> >>>
> >>> On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
> >>>> Re-evaluate the chip's throttled state on recieving OCC_THROTTLE
> >>>> notification by executing *throttle_check() on any one of the cpu on
> >>>> the chip. This is a sanity check to verify if we were indeed
> >>>> throttled/unthrottled after receiving OCC_THROTTLE notification.
> >>>>
> >>>> We cannot call *throttle_check() directly from the notification
> >>>> handler because we could be handling chip1's notification in chip2. So
> >>>> initiate an smp_call to execute *throttle_check(). We are irq-disabled
> >>>> in the notification handler, so use a worker thread to smp_call
> >>>> throttle_check() on any of the cpu in the chipmask.
> >>>
> >>> I see that the first patch takes care of reporting *per-chip* throttling
> >>> for pmax capping condition. But where are we taking care of reporting
> >>> "pstate set to safe" and "freq control disabled" scenarios per-chip ?
> >>>
> >>
> >> IMO let us not have "psafe" and "freq control disabled" states managed per-chip.
> >> Because when the above two conditions occur it is likely to happen across all
> >> chips during an OCC reset cycle. So I am setting 'throttled' to false on
> >> OCC_ACTIVE and re-verifying if it actually is the case by invoking
> >> *throttle_check().
> > 
> > Alright like I pointed in the previous reply, a comment to indicate that
> > psafe and freq control disabled conditions will fail when occ is
> > inactive and that all chips face the consequence of this will help.
> 
> From your explanation on the thread of the first patch of this series,
> this will not be required.
> 
> So,
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

OK, so is the whole series reviewed now?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
