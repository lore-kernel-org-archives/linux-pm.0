From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Thu, 10 Jan 2019 12:08:22 +0200
Message-ID: <CAHp75Ve2RZqf71tapmGQpZ1YtuKmEHe33k18k9Tg-7RExWQY8w@mail.gmail.com>
References: <20190108175818.705110-1-lkundrak@v3.sk> <CAHp75VcDXmARXAyE1tPouj0cLqg1Ohs5hq+LZ7dsoGY8pJWO2g@mail.gmail.com>
 <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b9c5e7e35ae25316bf4551ebf7ae21238d64f03.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 9, 2019 at 6:37 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
> On Wed, 2019-01-09 at 13:15 +0200, Andy Shevchenko wrote:
> > On Tue, Jan 8, 2019 at 7:58 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> > > Also, the 01/15 patch has been added to allow the module to provide
> > > a
> > > reboot handler. Patch 15/15 depends on it.
> >
> > Isn't it a quite big distance between provider and consumer?
> > Especially taking into consideration concerns about patch 1 which
> > blocks the series.
> > Perhaps you may drop it as a patch 1 and do something on top of patch
> > 15 as feature extension?
>
> Yes, that is a good idea. I'll do so when I submit a new version of the
> set (in few days' time).
>
> I think the battery part can be split from the EC part too. Would that
> be a good idea to send them as separate patch sets next time?

Yes, any independent porions can be send independently. It would speed
up the review and applying process.

> It seems
> to me now that they probably ought to end up going in via different
> trees (linux-power-supply vs linux-platform-drivers-x86).

-- 
With Best Regards,
Andy Shevchenko
