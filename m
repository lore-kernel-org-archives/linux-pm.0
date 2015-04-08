From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH] powercap / RAPL: mark rapl_ids array as __initconst
Date: Wed, 8 Apr 2015 20:41:30 +0200
Message-ID: <CA+rthh-TU_a3=fBdQRR_koebeUFGJnfhqaFBdTrTRQnd9axR6g@mail.gmail.com>
References: <1427318152-21800-1-git-send-email-minipli@googlemail.com>
	<6448986.08Uv5dyIEs@vostro.rjw.lan>
	<20150330154635.3fb82c23@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36607 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbbDHSlc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2015 14:41:32 -0400
Received: by wizk4 with SMTP id k4so65782769wiz.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2015 11:41:30 -0700 (PDT)
In-Reply-To: <20150330154635.3fb82c23@ultegra>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 31 March 2015 at 00:46, Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> On Mon, 30 Mar 2015 21:17:02 +0200
> Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
>> On Wednesday, March 25, 2015 10:15:52 PM Mathias Krause wrote:
>> > The RAPL ids are only tested in rapl_init() which is itself an
>> > __init function. For the MODULE_DEVICE_TABLE() file2alias doesn't
>> > care about the section, just about the symbol name. Therefore it's
>> > safe to mark the rapl_ids[] array as __initconst so its memory can
>> > be released after initialization is done.
>> >
>> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> > Signed-off-by: Mathias Krause <minipli@googlemail.com>
>>
>> Jacob, any comments?
>>
> looks good to me, though i did ack last week perhaps something wrong
> with my email.
>> > ---
>> >  drivers/powercap/intel_rapl.c |    2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/powercap/intel_rapl.c
>> > b/drivers/powercap/intel_rapl.c index 63d4033eb683..62f9b322fde0
>> > 100644 --- a/drivers/powercap/intel_rapl.c
>> > +++ b/drivers/powercap/intel_rapl.c
>> > @@ -1054,7 +1054,7 @@ static const struct rapl_defaults
>> > rapl_defaults_atom = { .driver_data = (kernel_ulong_t)&_ops,
>> > \ }
>> >
>> > -static const struct x86_cpu_id rapl_ids[] = {
>> > +static const struct x86_cpu_id rapl_ids[] __initconst = {
>> >     RAPL_CPU(0x2a, rapl_defaults_core),/* Sandy Bridge */
>> >     RAPL_CPU(0x2d, rapl_defaults_core),/* Sandy Bridge EP */
>> >     RAPL_CPU(0x37, rapl_defaults_atom),/* Valleyview */
>> >
>>
>> --

Ping. Rafael, any objections?

Mathias
