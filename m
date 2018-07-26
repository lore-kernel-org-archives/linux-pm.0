From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
Date: Thu, 26 Jul 2018 10:50:35 +0200
Message-ID: <24724042.UC9DsrE2FJ@aspire.rjw.lan>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com> <CAJZ5v0ifKcipGG0sM0iK0p4K0-V-PyoL-JfTH6uVVWoCA-eXnw@mail.gmail.com> <76C1A830-EEE1-486B-9B06-6C915C269278@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <76C1A830-EEE1-486B-9B06-6C915C269278@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, P HeLiOn <perryhelionsemail@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 26, 2018 10:15:03 AM CEST Kai-Heng Feng wrote:
> 
> > On 2018Jul26, at 16:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > 
> > On Thu, Jul 26, 2018 at 5:46 AM, Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> Hi Rafael,
> >> 
> >>> On 2018Jul24, at 18:36, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> 
> >>> On Tuesday, July 24, 2018 11:13:42 AM CEST Rafael J. Wysocki wrote:
> >>>> On Tuesday, July 24, 2018 10:46:09 AM CEST Kai Heng Feng wrote:
> >>>>> Hi Rafael,
> >>>>> 
> >>>>>> On Jun 13, 2018, at 7:17 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>>>>> 
> >>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>>>> 
> >>>>>> It is reported that commit a192aa923b66a (ACPI / LPSS: Consolidate
> >>>>>> runtime PM and system sleep handling) introduced a system suspend
> >>>>>> regression on some machines, but the only functional change made by
> >>>>>> it was to cause the PM quirks in the LPSS to also be used during
> >>>>>> system suspend and resume.  While that should always work for
> >>>>>> suspend-to-idle, it turns out to be problematic for S3
> >>>>>> (suspend-to-RAM).
> >>>>>> 
> >>>>>> To address that issue restore the previous S3 suspend and resume
> >>>>>> behavior of the LPSS to avoid applying PM quirks then.
> >>>>> 
> >>>>> The users reported that this patch does fix the S3 issue, but the S4 still
> >>>>> fails.
> >>>>> 
> >>>>> Please refer to [1] for more for user's testing result.
> >>>>> 
> >>>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1774950/comments/60
> >>>> 
> >>>> Please ask the users to test the patch below, then, on top of the $subject one.
> >>> 
> >>> There was a mistake in the previous patch I posted, sorry about that.
> >>> 
> >>> Please test this one instead:
> >> 
> >> The result is positive, thanks!
> > 
> > Good, thanks!
> > 
> > I assume that S3 still works with this patch applied too.
> 
> Yes, S3 continues to work with this patch.

OK, thanks!

Let me resend the patch with a proper subject and changelog, then.
