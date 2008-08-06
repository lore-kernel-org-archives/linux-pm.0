From: "Wei, Gang" <gang.wei@intel.com>
Subject: RE: [linux-pm] [RFC-PATCH] Improve Menu Governor Prediction of interrupted C states.
Date: Wed, 6 Aug 2008 09:51:14 +0800
Message-ID: <094BCE01AFBE9646AF220B0B3F367AAB035B08D0@pdsmsx413.ccr.corp.intel.com>
References: <13B9B4C6EF24D648824FF11BE8967162035BEA0EDF@dlee02.ent.ti.com> <094BCE01AFBE9646AF220B0B3F367AAB034DBB7A@pdsmsx413.ccr.corp.intel.com> <13B9B4C6EF24D648824FF11BE89671620361F4E439@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764269AbYHFBwr@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361F4E439@dlee02.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Linux Power Management List <linux-pm@lists.osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

> Hi,
> 
>> I also found current cpuidle Menu governor should have some problems
>> while predicting next non-expected break-event after some expected
>> break-events. The measured_us/elapsed_us/predicted_us will become
larger
>> and larger once (measured_us + BREAK_FUZZ >= data->expected_us -
>> target->exit_latency). The major point is that it should be
>> last_residency, not measured_us, that need to be used to do comparing
>> and distinguish between expected & non-expected events.
>> 
>> Below is my draft patch (not tested) for this. It is simple and
should
>> also be effective for high interrupt rates case.
> 
> This does seem to give better guesses.  However, first tests are not
showing
> as well as the irq time stamp version I posted. 
> 
> I'll need to grab some hardware trace to see what is going on.

Thanks for the trial. My original patch has already been merged into
another patch "[patch 2/3] cpuidle: Menu governor fix wrong usage of
measured_us" sent out by Venkatesh. The new patch should be more intact.

Jimmy
