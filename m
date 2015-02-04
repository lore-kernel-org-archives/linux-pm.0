From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: Re: ACPI PCC probe failed.
Date: Wed, 4 Feb 2015 09:56:20 -0500
Message-ID: <CAJ5Y-eaBH6q7X5ZC-UgCLnxOO9nXnJPY-kdq417qHhG0M-+obw@mail.gmail.com>
References: <CABwnbUkGNJEZkW5bL9pXvcZwqz4fZKiub_-vTRDLp=FeiQq8cw@mail.gmail.com>
	<3337572.5q6DLI5fhi@vostro.rjw.lan>
	<CABwnbUmOwf1VGwD0i9AW12No6nueHda+M7NnhX87uRLwKzw=aA@mail.gmail.com>
	<158128306.gX9FjqECDu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:35838 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966396AbbBDO4V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Feb 2015 09:56:21 -0500
Received: by mail-we0-f182.google.com with SMTP id l61so2174540wev.13
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2015 06:56:20 -0800 (PST)
In-Reply-To: <158128306.gX9FjqECDu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Cristian <caravena@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Rafael,

On 4 February 2015 at 08:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Tuesday, February 03, 2015 09:44:36 PM Cristian wrote:
>> 2015-02-03 12:11 GMT-03:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> > On Tuesday, February 03, 2015 10:40:00 AM Cristian wrote:
>> >> Hello,
>> >>
>> >> linux 3.19-rc7
>> >> Ubuntu Vivid 14.04 alpha
>> >>
>> >> dmesg:
>> >> [    1.293820] ACPI PCC probe failed.
>> >>
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=92551
>> >
>> > Is that a functional problem or just the message?
>> >
>> >
>> > --
>> > I speak only for myself.
>> > Rafael J. Wysocki, Intel Open Source Technology Center.
>>
>> Apparently one message.
>
> So it looks like you build the PCC mailbox driver which is new in 3.19-rc and
> that driver fails to load, because it doesn't find hardware to work with.
>
> The message is harmless, but it also is not useful.  The driver in question
> seems to be overly verbose to me in general.

Apologies. Looks like leftover from some early "printk" style debugging. :)

>
> The patch below should make the message go away unless the printing of debug
> messages is on.
>
> Ashwin, that whole thing requires cleaning up:
>  - It prints uninteresting debug messages with KERN_ERR or warning priority in
>    *many* places.
>  - The error codes from acpi_pcc_probe() are ignored, so why bother to return
>    any error codes from there?
>  - If platform_create_bundle() fails, the debug message doesn't tell us the
>    reason, so why bother to print it?
>
> I'm not going to consider any users of this for merging before that cleanup
> happens.

In V4 of the CPPC patchset I've simplified the PCC code a lot which
should make many of the prints go away. Can we consider that patch
(I'll add any more pr_debugs to it) or would you prefer having a
separate cleanup patch for this?

Thanks,
Ashwin

>
> Rafael
>
>
> ---
>  drivers/mailbox/pcc.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/mailbox/pcc.c
> ===================================================================
> --- linux-pm.orig/drivers/mailbox/pcc.c
> +++ linux-pm/drivers/mailbox/pcc.c
> @@ -386,7 +386,7 @@ static int __init pcc_init(void)
>         ret = acpi_pcc_probe();
>
>         if (ret) {
> -               pr_err("ACPI PCC probe failed.\n");
> +               pr_debug("ACPI PCC probe failed.\n");
>                 return -ENODEV;
>         }
>
> @@ -394,7 +394,7 @@ static int __init pcc_init(void)
>                         pcc_mbox_probe, NULL, 0, NULL, 0);
>
>         if (!pcc_pdev) {
> -               pr_err("Err creating PCC platform bundle\n");
> +               pr_debug("Err creating PCC platform bundle\n");
>                 return -ENODEV;
>         }
>
>
