From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/6] PM / core: Add LEAVE_SUSPENDED driver flag
Date: Sat, 11 Nov 2017 02:36:41 +0100
Message-ID: <CAJZ5v0g3sruE4mFgHitz5O5Hv-AHmtOVji2QMKthwqvYVEonpQ@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <16592954.7Zo1mAdIIH@aspire.rjw.lan>
 <6330680.LdxjlP4uri@aspire.rjw.lan> <2932219.eEdIVn6WWf@aspire.rjw.lan>
 <CAPDyKFrbnLjBzY3yE1OyXOpG3--K+C-1BCWQtyL9S6zQ5cmdhw@mail.gmail.com> <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0i4yFGyqAZ6QqG7q1_xNfjMNHkPk3o0WuBvwKFeM2nXeg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Nov 11, 2017 at 12:45 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Nov 10, 2017 at 10:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 8 November 2017 at 14:25, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

[cut]

>> Moreover, you should check the return value from
>> pm_runtime_set_suspended().
>
> This is in "noirq", so failures of that are meaningless here.

They *should* be meaningless, but __pm_runtime_set_status() is sort of
buggy and checks child_count regardless of whether or not runtime PM
is enabled for the children (but when changing the status to "active"
it actually checks if runtime PM is enabled for the parent before
returning -EBUSY, so it is not event consistent internally).  Oh well.

>> Then I wonder, what should you do when it fails here?
>>
>> Perhaps a better idea is to do this in the noirq suspend phase,
>> because it allows you to bail out in case pm_runtime_set_suspended()
>> fails.
>
> This doesn't make sense, sorry.

Not for the above reason, but that would allow the bug in
__pm_runtime_set_status() to be sort of worked around by setting the
status to "suspended" for children before doing that for their
parents.

Moreover, stuff with nonzero usage_counts cannot be left in suspend regardless.

Thanks,
Rafael
