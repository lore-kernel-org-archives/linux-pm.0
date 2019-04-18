From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG
Date: Thu, 18 Apr 2019 13:03:05 -0700
Message-ID: <CAHQ1cqGNKr0M4KZmX3gG+Wk4N39VezGO15VxEC6rzbLdzHQ-7w@mail.gmail.com>
References: <20190405073020.10361-1-andrew.smirnov@gmail.com> <20190417223708.4irrwrm4q7vig3vh@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417223708.4irrwrm4q7vig3vh@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 17, 2019 at 7:35 PM Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Fri, Apr 05, 2019 at 12:30:20AM -0700, Andrey Smirnov wrote:
> > Fix a similar endless event loop as was done in commit 8dcf32175b4e
> > ("i2c: prevent endless uevent loop with CONFIG_I2C_DEBUG_CORE"):
> >
> >   The culprit is the dev_dbg printk in the i2c uevent handler. If
> >   this is activated (for instance by CONFIG_I2C_DEBUG_CORE) it results
> >   in an endless loop with systemd-journald.
> >
> >   This happens if user-space scans the system log and reads the uevent
> >   file to get information about a newly created device, which seems
> >   fair use to me. Unfortunately reading the "uevent" file uses the
> >   same function that runs for creating the uevent for a new device,
> >   generating the next syslog entry
> >
> > Both CONFIG_I2C_DEBUG_CORE and CONFIG_POWER_SUPPLY_DEBUG were reported
> > in https://bugs.freedesktop.org/show_bug.cgi?id=76886 but only former
> > seems to have been fixed. Change debug prints to use pr_debug insted
> > to resolve the issue.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
>
> I think we should just drop these debug messages, just like I2C did.
> They don't offer any useful information considering the info is already
> exposed to userspace via the uevent.

OK, sounds good, will do in v2.

Thanks,
Andrey Smirnov
