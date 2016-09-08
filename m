From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/8] Support Intel(R) Turbo Boost Max Technology 3.0
Date: Thu, 8 Sep 2016 15:22:42 +0200
Message-ID: <CAJZ5v0gpSAN79M2cMEY1OydGp+PivG8iARNwtofh=K9p7JWgFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@suse.de>, the arch/x86 maintainers <x86@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, tim.c.chen@linux.intel.com
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 8, 2016 at 10:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Ingo, aside from the fact that Srinivas still has to update patch 6 and
> I just spotted a few niggles, how do you want to merge this?

One thing to note in any case.  This depends on the CPPC changes in this series:

http://marc.info/?l=linux-acpi&m=147276454028371&w=2

which I'm going to apply and which in turn depends on some CPPC stuff
already in my tree.

Thanks,
Rafael
