From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/3] platform/wmi: Expose the raw WDG data in sysfs
Date: Tue, 1 Aug 2017 16:51:40 -0700
Message-ID: <CALCETrXFySnB3jq_EAn+NDTb6jsp__4Dc=0ipdFqCbaZEPSOfg@mail.gmail.com>
References: <cover.1501601667.git.luto@kernel.org> <e6df9d038af0a0ce4d4119395aaea58366ade26d.1501601667.git.luto@kernel.org>
 <20170801200313.GC3110@fury> <CALCETrX0zqq3xQgNBx41R9ZCT3_bB4EoXGrY3jWLK0e0Koo=EQ@mail.gmail.com>
 <20170801204040.GH25574@pali> <20170801211702.GF3110@fury>
 <20170801213112.GK25574@pali> <20170801223947.GH3110@fury>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751748AbdHAXwC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Aug 2017 19:52:02 -0400
Received: from mail-ua0-f176.google.com (mail-ua0-f176.google.com [209.85.217.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A539922DA9
        for <linux-pm@vger.kernel.org>; Tue,  1 Aug 2017 23:52:01 +0000 (UTC)
Received: by mail-ua0-f176.google.com with SMTP id q25so13965424uah.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Aug 2017 16:52:01 -0700 (PDT)
In-Reply-To: <20170801223947.GH3110@fury>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>

On Tue, Aug 1, 2017 at 3:39 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Tue, Aug 01, 2017 at 11:31:12PM +0200, Pali Rohár wrote:
>> On Tuesday 01 August 2017 14:17:02 Darren Hart wrote:
> ...
>> > My understanding of the BMOF data is that it provided us "with a description of
>> > all data blocks, WMI methods, and events for the device" [1].
>> >
>> > If that's accurate, why do we need the _WDG? This just seems contrary to what
>> > the BMOF data is supposed to be for.
>>
>> BMOF provides mapping from human class and method names to WMI GUID. WDG
>> then provides mapping from WMI GUID to ACPI function names.
>>
>> Therefore if you upper layer in MOF world say that it want to call
>> method M of class C and you want to know which ACPI function is called,
>> you need to parse both BMOF and WDG to get mapping from MOF to ACPI.
>> Same for WMI events.
>>
>> > > Ideally ability to create dump of BMOF and WDG on one computer and then
>> > > parse those data on another.
>> > >
>> > > Having original BMOF and WDG structures is a good for debugging and
>> > > development purpose.
>
> OK, I went and reviewed the MOF docs, our previous discussions, and your bmf2moc
> code (awesome by the way). So, agreed - we need easy access to _WDG and BMOF for
> development purposes.
>
> Having the kernel expose a guid/class/method interface should provide the
> abstraction Rafael called for.
>
> The question then, is should these two things be in sysfs, where they become
> more or less permanent, or are they better off in debugfs, where they can be
> used by developers as needed, but are not present on production systems, and
> we are not bound to the representation we use from now until forever.
>
> Seems to me:
>
> /debug/wmi/<GUID>/bmof

I can imagine a real production userspace app that parses BMOF data.
Imagine you write a thingy that calls some laptop method foo(1) where
foo is defined in the MOF.  You could hardcode the mapping to the
GUID, but you could also parse the BMOF.

> /debug/wmi/<GUID>/_wdg

More like /debug/wmi/<bus name>/_wdg, but yes.  I wish there was a
standard way to make a debugfs directory corresponding to a sysfs
path.  Maybe this exists -- I'll look.

FWIW, almost all the _WDG data is already there in sysfs in Linus'
tree.  See, for example, cat
/sys/devices/platform/PNP0C14:01/wmi_bus/wmi_bus-PNP0C14:01/05901221-D566-11D1-B2F0-00A0C9062910/object_id

--Andy

>
> would be the most appropriate location for these.
>
> --
> Darren Hart
> VMware Open Source Technology Center
