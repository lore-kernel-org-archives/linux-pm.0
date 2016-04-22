From: Lianwei Wang <lianwei.wang@gmail.com>
Subject: Re: [PATCH] cpu/hotplug: handle unbalanced hotplug enable/disable
Date: Fri, 22 Apr 2016 09:32:56 -0700
Message-ID: <CAJFUiJih1YMast1S2z4_sfVaLwsPpHyRrS9tAhwTket2KbRDxA@mail.gmail.com>
References: <1461214567-3356-1-git-send-email-lianwei.wang@gmail.com> <20160421105042.GI3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34145 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702AbcDVQdR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 12:33:17 -0400
In-Reply-To: <20160421105042.GI3408@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, oleg@redhat.com, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Apr 21, 2016 at 3:50 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 20, 2016 at 09:56:07PM -0700, Lianwei Wang wrote:
>> Currently it just print a warning message but did not
>> reset cpu_hotplug_disabled when the enable/disable is
>> unbalanced. The unbalanced enable/disable will lead
>> the cpu hotplug work abnormally.
>>
>> Reset it to 0 when an unablanced enable detected.
>
> How can this happen in the first place?

That's is my question too, and why we check it with WARN_ON here?
Obviously it is possible to happened because the
cpu_hotplug_disable/enable are both kernel API and any driver can call
it. A unbalanced check is a good way to handle it.

The actually problem here is that what we do in case it happened? Just
give a warning or do some error handling and recover it back? This's
my focus..
