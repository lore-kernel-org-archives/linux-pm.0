From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/3] Stop sched tick in idle injection task
Date: Thu, 24 Nov 2016 01:24:48 +0100
Message-ID: <CAJZ5v0iUy9g0J9bZCHCho7oCQvf7rzM5c=AYww5V+BD2x1jV2A@mail.gmail.com>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAJZ5v0g6==h_qBQ1x6wbV+N3MjjWRb-iNmF4OShFrD0qR2L9JA@mail.gmail.com>
 <20161123214555.GC3092@twins.programming.kicks-ass.net> <CAJZ5v0j15suAbq8ZFdg5s4j9x+V8v3EoUNUL4DJT6ZLSjZ+UWw@mail.gmail.com>
 <20161123162507.2354e504@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33953 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbcKXAYu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 19:24:50 -0500
In-Reply-To: <20161123162507.2354e504@jacob-builder>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Thu, Nov 24, 2016 at 1:25 AM, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
> On Wed, 23 Nov 2016 23:38:39 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
>> On Wed, Nov 23, 2016 at 10:45 PM, Peter Zijlstra
>> <peterz@infradead.org> wrote:
>> > On Wed, Nov 23, 2016 at 10:12:46PM +0100, Rafael J. Wysocki wrote:
>> >> On Wed, Nov 23, 2016 at 9:13 PM, Jacob Pan
>> >
>> >>
>> >> Any objections anyone?
>> >>
>> >> If not, I'll queue up this series for 4.10.
>> >
>> > 1h30 is a bit short to expect people to have even seen this, let
>> > alone reviewed.
>>
>> I didn't say I'd queue it up right away. :-)
>
> The powerclamp change is on top of Petr and Sebastian's kworker and cpu
> hp state machine patches. I plan to put all powerclamp patches in one
> series after 1 and 2 are accepted.

OK

Thanks,
Rafael
