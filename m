From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 0/3] Stop sched tick in idle injection task
Date: Wed, 23 Nov 2016 23:38:39 +0100
Message-ID: <CAJZ5v0j15suAbq8ZFdg5s4j9x+V8v3EoUNUL4DJT6ZLSjZ+UWw@mail.gmail.com>
References: <1479931990-11732-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <CAJZ5v0g6==h_qBQ1x6wbV+N3MjjWRb-iNmF4OShFrD0qR2L9JA@mail.gmail.com> <20161123214555.GC3092@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33521 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbcKWWil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 17:38:41 -0500
In-Reply-To: <20161123214555.GC3092@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Petr Mladek <pmladek@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On Wed, Nov 23, 2016 at 10:45 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Nov 23, 2016 at 10:12:46PM +0100, Rafael J. Wysocki wrote:
>> On Wed, Nov 23, 2016 at 9:13 PM, Jacob Pan
>
>>
>> Any objections anyone?
>>
>> If not, I'll queue up this series for 4.10.
>
> 1h30 is a bit short to expect people to have even seen this, let alone
> reviewed.

I didn't say I'd queue it up right away. :-)
