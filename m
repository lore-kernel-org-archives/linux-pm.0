From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] MAINTAINERS: Reorder maintainer addresses for PM and ACPI
Date: Thu, 20 Mar 2014 08:58:28 +0100
Message-ID: <CAMuHMdXFkf0g15vY=PkeMgxhr4G2=tWhK+jd8ejiqT0bJVaxQQ@mail.gmail.com>
References: <1744772.yf52reTAmC@vostro.rjw.lan>
	<1395282105.8649.55.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1395282105.8649.55.camel@joe-AO722>
Sender: linux-acpi-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi Joe,

On Thu, Mar 20, 2014 at 3:21 AM, Joe Perches <joe@perches.com> wrote:
>>  SUSPEND TO RAM
>> +M:   Rafael J. Wysocki <rjw@rjwysocki.net>
>> -M:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
>
> Please keep the quotes around your name.
>
> It makes it easier for some systems to accept
> names with periods via copy/paste.

While for "git send-email", it's easier if I don't have to remove the one in
the middle manually...

Anyway, scripts/get_maintainer.pl re-adds them.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
