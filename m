From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH v2 0/8] Introduct cpu idle prediction functionality
Date: Thu, 30 Nov 2017 02:37:28 +0100
Message-ID: <CAJZ5v0i2biAtXDxYHTs6QRo7UwPhfVyafeaeu2G9UX+Q6CR+sA@mail.gmail.com>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com> <0f4d78d4-09d7-5b68-8706-5427b39fa0ed@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35002 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752734AbdK3Bh3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Nov 2017 20:37:29 -0500
In-Reply-To: <0f4d78d4-09d7-5b68-8706-5427b39fa0ed@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc: Aubrey Li <aubrey.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Nov 30, 2017 at 2:00 AM, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> Hi,
>
> Thanks Rafael's comments against V2. I'd like to ping here to see which
> direction this proposal should go and what fundamental change this proposal
> should make.
>
> I'm also open to any suggestions if my proposal is not on the right way.

To me (and I discussed that with Peter briefly last month in Prague)
the way to go would be to avoid stopping the scheduler tick until we
are entirely sure that it should be stopped.  Which is when the
governor (any governor BTW, not just menu) chooses the target idle
state for the CPU and the target residency of that state is long
enough for the tick to be stopped ("long enough" here means that if
the tick is not stopped, the time spent by the CPU in the target idle
state will be shorter than the target residency).  Note that this is
totally independent on what governor is used and it doesn't involve
any "refinements" or "improvements" of the prediction whatever.

Of course, for the governor to make the state selection, it generally
will have to know when the next non-tick timer is going to expire and
getting that information to it will require some effort.

Thanks,
Rafael
