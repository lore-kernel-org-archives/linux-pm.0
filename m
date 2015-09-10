From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 00/17] thermal: add COMPILE_TEST (on drivers)
Date: Thu, 10 Sep 2015 08:23:45 +0200
Message-ID: <CAMuHMdVRztDtqDU6j6UBmGy4Z3Sm=QtCr0rrPwxrV+axTw17iA@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33991 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbIJGXq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 02:23:46 -0400
In-Reply-To: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Eduardo,

On Thu, Sep 10, 2015 at 6:10 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> This is a simple series to add the COMPILE_TEST on thermal drivers.
> The idea is to help compiling and maintaining.

Thanks, good idea!

> Split into smaller patches so people can have their own voices on their drivers.
>
> Let me know if this is a problem.

Have you compile-tested this?
I'm seeing too many failures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
