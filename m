From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH] powercap / RAPL: mark rapl_ids array as __initconst
Date: Tue, 31 Mar 2015 07:17:38 +0200
Message-ID: <CA+rthh_CCOQjSB_Y8C=bzSoiR32w+GSUbD0OuwYqcma=vCo7yg@mail.gmail.com>
References: <1427318152-21800-1-git-send-email-minipli@googlemail.com>
	<6448986.08Uv5dyIEs@vostro.rjw.lan>
	<20150330154635.3fb82c23@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38653 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbbCaFRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2015 01:17:40 -0400
Received: by wibgn9 with SMTP id gn9so11288622wib.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2015 22:17:39 -0700 (PDT)
In-Reply-To: <20150330154635.3fb82c23@ultegra>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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

You ACKed "[PATCH] thermal/intel_powerclamp: add __init / __exit
annotations", twice -- not that one ;)


Regards,
Mathias
