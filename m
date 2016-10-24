From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][v12] PM / hibernate: Verify the consistent of e820 memory
 map by md5 digest
Date: Mon, 24 Oct 2016 15:07:24 +0200
Message-ID: <CAJZ5v0hinH8AxarFAyDx_B7-kN_P8VBHCz4hUjTaB1wzqfjxZQ@mail.gmail.com>
References: <1476951292-19619-1-git-send-email-yu.c.chen@intel.com>
 <20161022030302.GB26548@linux-rxt1.site> <20161023080122.GA25889@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34548 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934917AbcJXNH0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Oct 2016 09:07:26 -0400
In-Reply-To: <20161023080122.GA25889@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: joeyli <jlee@suse.com>, Chen Yu <yu.c.chen@intel.com>, Linux PM <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, Len Brown <len.brown@intel.com>, Denys Vlasenko <dvlasenk@redhat.com>, Dan Williams <dan.j.williams@intel.com>

On Sun, Oct 23, 2016 at 10:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> > 2. Another case is, this patch replies on comparing the e820_saved, but
>> >    currently the e820_save might not be strictly the same across
>> >    hibernation, even if BIOS has provided consistent e820 map - In
>> >    theory mptable might modify the BIOS-provided e820_saved dynamically
>> >    in early_reserve_e820_mpc_new, which would allocate a buffer from
>> >    E820_RAM, and marks it from E820_RAM to E820_RESERVED).
>> >    This is a potential and rare case we need to deal with in OS in
>> >    the future.
>> >
>> > Suggested-by: Pavel Machek <pavel@ucw.cz>
>> > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> Rafael, can we get this merged? 12 versions is a bit too much..

We can, if there are no more comments.

It actually doesn't matter how many revisions of the patch there are
as long as it isn't ready ...

Thanks,
Rafael
