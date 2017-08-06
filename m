From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Sun, 6 Aug 2017 15:09:47 -0700
Message-ID: <CALCETrXjqMoa6BGkQ-jhxBR8eg3uuGEbfRS0uJrE-rNbTcQqbQ@mail.gmail.com>
References: <cover.1501601667.git.luto@kernel.org> <20170802074903.GO25574@pali>
 <CALCETrVHGtA7nRaBCy9ZZ48Xu8hTKBgLdoGZeEHnHhPg3tdsxQ@mail.gmail.com> <201708062336.25403@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751345AbdHFWKJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 6 Aug 2017 18:10:09 -0400
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com [209.85.213.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D26922CB3
        for <linux-pm@vger.kernel.org>; Sun,  6 Aug 2017 22:10:09 +0000 (UTC)
Received: by mail-vk0-f43.google.com with SMTP id n125so20287210vke.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Aug 2017 15:10:09 -0700 (PDT)
In-Reply-To: <201708062336.25403@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>

On Sun, Aug 6, 2017 at 2:36 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> On Friday 04 August 2017 17:03:07 Andy Lutomirski wrote:
>> On Wed, Aug 2, 2017 at 12:49 AM, Pali Rohár <pali.rohar@gmail.com>
>> wrote:
>> > On Tuesday 01 August 2017 19:22:32 Darren Hart wrote:
>> >> Pali, how does the "magic number identifier" in the BMOF map to
>> >> the object_id? Have we retained that information in what we
>> >> export today?
>> >
>> > MOF describe C++ like object system and for particular structures
>> > or methods there is GUID and WMI id.
>> >
>> > When you want to call WMI function implemented in ACPI you need to
>> > know: * name of ACPI function
>> > * instance number
>> > * WMI id
>> > * structure of input buffer
>> >
>> > Name of ACPI function is taken from _WDG where is mapping from GUID
>> > to object_id and ACPI function consist of well-known prefix and
>> > object_id as a suffix. GUID is present in MOF. Where to get
>> > correct instance number is still question for me. WMI id and
>> > structure of input buffer is described in MOF.
>>
>> I assume that any user API for making WMI calls will have userspace
>> pass in either the GUID or maybe the MOF method name, not the object
>> id.
>
> So... When calling WMI method of some class it is really needed to
> supply also instance id. On Windows caller needs to specify Instance
> Name, e.g. ACPI\PNP0C14\0_0 which looks like correspondent to instance
> id 0. ACPI\PNP0C14\0_2 is then to instance id 2.
>
> Toshiba has triple (class, method, instance) in their BIOS WMI
> documentation [1].
>
> Therefore userspace would need to know instance count which is stored in
> _WDG for doing WMI call.
>
> Is there already exported instance count via sysfs?

Yes.

>
> [1] - https://aps2.toshiba-tro.de/kb0/TSB3803HR0000R01_TOSHIBA_BIOS_WMI_Interface_Guide_-_13_Rev_1.1.pdf
>
> --
> Pali Rohár
> pali.rohar@gmail.com
