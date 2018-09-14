From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] PM / suspend: Count suspend-to-idle loop as sleep time
Date: Fri, 14 Sep 2018 10:04:22 +0200
Message-ID: <20180914080422.GG24124@hirez.programming.kicks-ass.net>
References: <9611469.2z7W9akjOQ@aspire.rjw.lan>
 <20180914074052.GF24124@hirez.programming.kicks-ass.net>
 <CAJZ5v0hnchptNz8sHxtuTDbE-f3axgfMgKMgRiasoUv2G7Z0+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hnchptNz8sHxtuTDbE-f3axgfMgKMgRiasoUv2G7Z0+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 14, 2018 at 09:47:28AM +0200, Rafael J. Wysocki wrote:
> On Fri, Sep 14, 2018 at 9:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Do we want a 'warning' of sorts when the delta becomes significant (for
> > whatever that is) ? That might be an indication that there are frequent
> > wakeups which we might not be expecting. Of keep the number of spurious
> > wakeups in a stat counter somewhere -- something to look at if the
> > battery drains faster than expected.
> 
> If you echo 1 to /sys/power/pm_debug_messages, dmesg will tell you
> that (with gory details). :-)

Shiny, didn't know that ;-)
