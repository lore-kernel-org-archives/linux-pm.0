From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Date: Tue, 1 Jan 2019 16:51:25 -0800
Message-ID: <20190102005121.GB7944@localhost.localdomain>
References: <20190101160503.GA3306@localhost.localdomain>
 <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
 <20190101231526.GA7944@localhost.localdomain>
 <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 01, 2019 at 03:32:50PM -0800, Linus Torvalds wrote:
> On Tue, Jan 1, 2019 at 3:16 PM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > > It doesn't even build cleanly.
> > >
> >
> > Do you still have have a copy of the build error?
> 
> A plain "make allmodconfig" shows a warning.

I see. I am afraid I really did not catch this. I supposed you are
referring to the warning like this:

    thermal_hwmon.h:29:1: warning: ‘thermal_remove_hwmon_sysfs’ defined but not used [-Wunused-function]

I am sending out a patch for this on thermal_hwmon.h  and will be resending the pull request
once the CIs report back.


> 
> And I refuse to add new warnings.

Fair enough. I would not expect anything different. Thanks for reporting.

> 
>                  Linus
