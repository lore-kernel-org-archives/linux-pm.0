From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Wed, 27 Apr 2016 23:10:34 -0700
Message-ID: <CAJFUiJir_zvQDXub=1zwPKJoZm_AnWNpGXuSUiCeHAEwEEUCMQ@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com>
 <20160421105042.GI3408@twins.programming.kicks-ass.net> <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
 <alpine.DEB.2.11.1604221834430.3941@nanos> <CAJFUiJg61i16JdC4LiQOXmD9Rrg8VDf7BEWs124dFTkbd4Rg-g@mail.gmail.com>
 <alpine.DEB.2.11.1604251018090.3941@nanos> <CAJFUiJjSvzv65sHApE5Gcp9oWA-j5j7JLb6b0=1eETrA4uQLkQ@mail.gmail.com>
 <alpine.DEB.2.11.1604271216400.3941@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34069 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbcD1GKz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Apr 2016 02:10:55 -0400
In-Reply-To: <alpine.DEB.2.11.1604271216400.3941@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Apr 27, 2016 at 3:17 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Mon, 25 Apr 2016, Lianwei Wang wrote:
>> On Mon, Apr 25, 2016 at 1:22 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> >> Anyway, from a product perspective way, if we don't want to restore
>> >> the unbalanced counter to 0, then maybe a BUG_ON is more reasonable
>> >> than WARN_ON.
>> >
>> > Not at all. BUG_ON is the last resort if we have no other way to handle an
>> > issue.
>> Actually to the customer, you do nothing currently at all, and once it
>> happened then there is no way for the customer to recover it except do
>> a power cycle. A BUG_ON can trigger a power cycle and recover it.
>
> Do you have a single incident where this happened?
>
> Thanks,
>
>         tglx

Yes. In our project, there is a kernel driver which register a pm
notifier. On some conditions this pm notifier will return an error and
abort the suspend process. The counter will be unbalanced in case it
happened.
