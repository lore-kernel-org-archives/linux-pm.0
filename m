From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: [PATCH v5 6/6] PCC: Enable PCC only when needed
Date: Wed, 27 May 2015 09:53:21 -0400
Message-ID: <CAJ5Y-eZe9qtwXTqZ6Kbjv-+POuTRi=LBShCE2pEuaABSeBi0Dg@mail.gmail.com>
References: <1432590731-9194-1-git-send-email-ashwin.chaugule@linaro.org>
	<1432676153.11262.278.camel@spandruv-DESK3.jf.intel.com>
	<2070004.cs8zNmgBiA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36226 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbbE0NxW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 09:53:22 -0400
Received: by oihb142 with SMTP id b142so7723003oih.3
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2015 06:53:21 -0700 (PDT)
In-Reply-To: <2070004.cs8zNmgBiA@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 26 May 2015 at 20:43, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, May 26, 2015 09:37:45 PM Pandruvada, Srinivas wrote:
>> On Mon, 2015-05-25 at 17:52 -0400, Ashwin Chaugule wrote:
>> > CPPC is the first client to make use of the PCC Mailbox channel. So
>> > enable it only when CPPC is also enabled.
>> >
>> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
>> > ---
>> >  drivers/mailbox/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
>> > index 84b0a2d..60c8da6 100644
>> > --- a/drivers/mailbox/Kconfig
>> > +++ b/drivers/mailbox/Kconfig
>> > @@ -45,7 +45,7 @@ config OMAP_MBOX_KFIFO_SIZE
>> >
>> >  config PCC
>> >     bool "Platform Communication Channel Driver"
>> > -   depends on ACPI
>> > +   depends on ACPI && ACPI_CPPC
>> If we add such dependency then we will end up in adding many ..
>> Is there any specific reason, you want to to do this?
>
> The reason is that we want PCC to only be enabled if there's any user of it.
>
> However, it would be better to make (a) PCC default to unset and
> (b) ACPI_CPPC select PCC for this purpose.

I believe I have (b) already. Will make PCC default to unset.

Thanks,
Ashwin.
