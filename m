From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] ACPI / Sleep: Check low power idle constraints for
 debug only
Date: Sun, 13 Aug 2017 02:54:56 +0200
Message-ID: <CAJZ5v0hMBCayVfUxGZLBDyHbH3opXkFpr7H4YVZ_0s+bjigXzQ@mail.gmail.com>
References: <1502475835-54818-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <18796717.B6iU8dePCh@aspire.rjw.lan> <1502553556.20268.47.camel@linux.intel.com>
 <CAJZ5v0iDkeCYigzY-jDyUonyDRhVuJtSmKa8qjSk0vdiPvV-EA@mail.gmail.com> <1502582422.20268.53.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36229 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdHMAy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Aug 2017 20:54:57 -0400
In-Reply-To: <1502582422.20268.53.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sun, Aug 13, 2017 at 2:00 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On Sun, 2017-08-13 at 00:37 +0200, Rafael J. Wysocki wrote:
>> On Sat, Aug 12, 2017 at 5:59 PM, Srinivas Pandruvada
>> <srinivas.pandruvada@linux.intel.com> wrote:
>> >
>> > On Sat, 2017-08-12 at 16:27 +0200, Rafael J. Wysocki wrote:
>> > [...]
>> >
>> > >
>> > > >
>> > > > +
>> > > > +struct lpi_constraints {
>> > > > +   char *name;
>> > > > +   int min_dstate;
>> > > If you store the handle here as well, you won't need to
>> > > look it up every time _check_constraints() is called.
>> > The reason I didn't keep handle here, I thought handle can be stale
>> > or
>> > change for PnP device on plug in and out. Is this not true?
>> The handles don't go away on hot remove as a rule.  That may only
>> happen if tables get unloaded, but basically the constraints should
>> not point to anything in a table that may go away.
>
> So we don't need to worry about this case where tables gets unloaded
> and replaced?

I wouldn't. :-)

We generally don't support that case entirely, so why bother?

> This is in a debug path, so additional overhead of path
> to handle conversion may not be significant.

Well, it still is wasted cycles ...
