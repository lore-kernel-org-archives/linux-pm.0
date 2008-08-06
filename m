From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [linux-pm] [RFC-PATCH] Improve Menu Governor Prediction of
 interrupted C states.
Date: Tue, 5 Aug 2008 20:24:44 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361F4E439@dlee02.ent.ti.com>
References: <13B9B4C6EF24D648824FF11BE8967162035BEA0EDF@dlee02.ent.ti.com>
 <094BCE01AFBE9646AF220B0B3F367AAB034DBB7A@pdsmsx413.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761937AbYHFBZO@vger.kernel.org>
In-Reply-To: <094BCE01AFBE9646AF220B0B3F367AAB034DBB7A@pdsmsx413.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wei, Gang" <gang.wei@intel.com>, Linux Power Management List <linux-pm@lists.osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

> I also found current cpuidle Menu governor should have some problems
> while predicting next non-expected break-event after some expected
> break-events. The measured_us/elapsed_us/predicted_us will become
> larger
> and larger once (measured_us + BREAK_FUZZ >= data->expected_us -
> target->exit_latency). The major point is that it should be
> last_residency, not measured_us, that need to be used to do comparing
> and distinguish between expected & non-expected events.
>
> Below is my draft patch (not tested) for this. It is simple and should
> also be effective for high interrupt rates case.

This does seem to give better guesses.  However, first tests are not showing as well as the irq time stamp version I posted.

I'll need to grab some hardware trace to see what is going on.

Thanks,
Richard W.
