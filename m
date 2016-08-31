From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][v8] PM / hibernate: Verify the consistent of e820 memory
 map by md5 value
Date: Wed, 31 Aug 2016 13:54:04 +0200
Message-ID: <CAJZ5v0gOg-UygD6VmCEX4PHSbPvxcZ4bb-oiVSWAp5SyfJdqeQ@mail.gmail.com>
References: <1472402140-959-1-git-send-email-yu.c.chen@intel.com>
 <4324101.BrknapGkIi@vostro.rjw.lan> <20160831110731.GC12296@amd> <20160831114341.GA14890@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:35786 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbcHaLyG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Aug 2016 07:54:06 -0400
In-Reply-To: <20160831114341.GA14890@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lee@vger.kernel.org, Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>

On Wed, Aug 31, 2016 at 1:43 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On Wed 2016-08-31 13:07:31, Pavel Machek wrote:
>> On Wed 2016-08-31 02:27:53, Rafael J. Wysocki wrote:
>> > On Monday, August 29, 2016 12:35:40 AM Chen Yu wrote:

[cut]

>> > >
>> > > +#define MD5_DIGEST_SIZE 16
>> > > +
>> > >  struct restore_data_record {
>> > >   unsigned long jump_address;
>> > >   unsigned long jump_address_phys;
>> > >   unsigned long cr3;
>> > >   unsigned long magic;
>> > > + u8 e820_digest[MD5_DIGEST_SIZE];
>> > >  };
>> > >
>> > >  #define RESTORE_MAGIC    0x123456789ABCDEF0UL
>> >
>> > You're changing the image header format, so RESTORE_MAGIC needs to be updated
>> > too.
>>
>> With !CONFIG_HIBERNATION_CHECK_E820, magic nothing changes in on-disk
>> format. (Unused space is now used).
>>
>> If there's hibernation kernel is CONFIG_HIBERNATION_CHECK_E820, and
>> restore kernel is !CONFIG_HIBERNATION_CHECK_E820, we won't check the
>> E820, and that should be acceptable.
>>
>> If there's hibernation kernel is !CONFIG_HIBERNATION_CHECK_E820, and
>> restore kernel is CONFIG_HIBERNATION_CHECK_E820, we'll fail the E820
>> check, and refuse to resume. That is also acceptable (and similar
>> result we'd get with RESTORE_MAGIC).. but the message will be
>> confusing.
>>
>> Ok, so I guess we should change the magic.
>
> Actually, no, simply changing the magic is not enough. I guess we
> should change the magic, and either add "e820_digest_available" field,
> or specify that e820_digest == {0,} means that no digest is
> available. We should either ignore the digest in
> CONFIG_HIBERNATION_CHECK_E820 case if it is not available, or fail
> with different message.

Something like that.

Kernels with the same RESTORE_MAGIC have to use the same header format
and interpret all of the fields in it in the same way.

Thanks,
Rafael
