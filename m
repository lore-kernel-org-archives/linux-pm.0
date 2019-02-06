From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: REGRESSION - System does not resume from suspend
Date: Wed, 6 Feb 2019 23:44:10 +0100
Message-ID: <CAJZ5v0iTu7nq9cR3iDsmf2=Nn7Z8YcvCLjvehKee+zMbV+iA7w@mail.gmail.com>
References: <CAAuoowhNsaXjBSHM9ZGeO_uwGVXprc8TS0SENGA3fKbg1xCWMQ@mail.gmail.com>
 <20190206212023.GA5353@amd> <CAJZ5v0gZmSfN2pk50sKYr-exbJy8m3dY4Xnz6pcKMcbAX92yfA@mail.gmail.com>
 <20190206223231.GA13324@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206223231.GA13324@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?B?0K/RgNC+0YHQu9Cw0LIg0KHQtdC80YfQtdC90LrQvg==?= <ukrkyi@gmail.com>, Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>, Thomas Martitz <kugel@rockbox.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 6, 2019 at 11:32 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Wed 2019-02-06 23:19:18, Rafael J. Wysocki wrote:
> > On Wed, Feb 6, 2019 at 10:20 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > Since kernel version 4.19, my computer is unable to resume from suspend to
> > > > RAM. I've run git bisect and filed bug report at
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=201519
> > > > three months ago, however, I received no reaction. Bug is still present in
> > > > 5.0-rc5 kernel version. Is there any possibility to fix this?
> > >
> > > Thanks for all the work bisecting / etc... Note that you can get patch
> > > reverted if it causes regression, but it needs to be done over
> > > email. (If maintainer does not reply, up-to Linus).
> > >
> > > For the record, patch is:
> > >
> > > git bisect output:
> > > c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 is the first bad commit
> > > commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3
> > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Date:   Tue May 22 13:02:17 2018 +0200
> > >
> > >     PM / core: Fix direct_complete handling for devices with no
> > >     callbacks
> > > ...
> > >     Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
> > >         Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and
> > >         SMART_PREPARE driver flags)
> > >  Reported-by: Thomas Martitz <kugel@rockbox.org>
> > >  Tested-by: Thomas Martitz <kugel@rockbox.org>
> > >                     Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
> > >  Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >  Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > >  Reviewed-by: Johan Hovold <johan@kernel.org>
> > >
> > > And the patch was tagged for stable, which sounds like a lot of fun.
> >
> > Not really.  This just restored previous behavior as the commit log says.
> >
> > If the system breaks after this one, it most likely didn't work before
> > commit 08810a4119aa which was in 4.15 and c62ec4610c40bcc44f2 first
> > appeared in 4.17-rc1.
> >
> > Unfortunately, it cannot be reverted without breaking other systems
> > that used to work before commit 08810a4119aa.
>
> So what is going on there?
>
> If some devices need one behaviour and other devices need second
> behaviour, we can just add the flag for the driver, right?

Yes.

> Because we know that Jaroslav's system can suspend, so this is fixable.
>
> Jaroslav -- can you find out which device has problem?

I have followed up in the BZ, we'll try to find the problematic device.
