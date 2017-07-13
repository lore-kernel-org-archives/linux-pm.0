From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI target state during S4 quiesce phase
Date: Thu, 13 Jul 2017 13:54:45 +0200
Message-ID: <CAJZ5v0ipt03TMn2YWn4pCJvPfXNUa0QjcD_JKFZhO=Rq==cAnw@mail.gmail.com>
References: <20170712191009.pylvv4kpjmyi7lny@ideak-desk.fi.intel.com>
 <CAJZ5v0g=c3FL3X-_SuYp-=pds+r7VtaQpZESSNzNht9i0o94kw@mail.gmail.com> <20170713103019.7qvfkcmaoufyk4ln@ideak-desk.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:36376 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdGMLyq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 07:54:46 -0400
Received: by mail-it0-f44.google.com with SMTP id m68so36630372ith.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2017 04:54:46 -0700 (PDT)
In-Reply-To: <20170713103019.7qvfkcmaoufyk4ln@ideak-desk.fi.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Imre Deak <imre.deak@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Jul 13, 2017 at 12:30 PM, Imre Deak <imre.deak@intel.com> wrote:
> On Wed, Jul 12, 2017 at 10:40:31PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Jul 12, 2017 at 9:10 PM, Imre Deak <imre.deak@intel.com> wrote:
>> > Hi,
>> >
>> > I noticed that acpi_target_system_state() returns ACPI_STATE_S0
>> > when called from a dev pm->freeze hook before restoring the hibernation
>> > image (PMSG_QUIESCE). Is this on purpose?
>>
>> Yes, it is.
>
> Ok.
>
>> After all, the platform is not going to change the power state, is it?
>
> No it won't, so yes S0 is the proper target state in that sense.
>
>>
>> > One could argue that it should
>> > be ACPI_STATE_S4, matching the target state before creating the
>> > hibernation image (PMSG_FREEZE).
>>
>> And what would the argument be then?
>
> To me it makes sense to resume a device in pm->restore from the same
> device power state pm->freeze/PMSG_FREEZE suspended it to.

No, you can't do that.

The restore kernel may be a different kernel *version* even, let alone
a different set of drivers.  Effectively, you can get a device in the
very state in which the platform firmware (aka BIOS) left it.

> This device power state can in turn depend on the platform target state and this
> latter state will be different in pm->freeze/PMSG_QUIESCE wrt.
> pm->freeze/PMSG_FREEZE.
>
> A driver could also just use a fixed device power state in pm->freeze
> independent of the platform target state. So I'm not saying
> acpi_target_system_state() is incorrect, just wanted to understand the
> logic behind it and how a driver can use it.

So really ->restore means no assumptions on the device state at all
and the target platform state is S0 (or equivalent).

That's one of the reasons why ->restore is a special callback. :-)

Thanks,
Rafael
