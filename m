From: Liam Breck <liam@networkimprov.net>
Subject: Re: [PATCH v1 7/7] power: bq24190_charger: Set bq24190-battery device .type=unknown
Date: Fri, 24 Mar 2017 03:44:51 -0700
Message-ID: <CAKvHMgTVvytGyzxR_ay7v216qwYnekn_c3O72XzdPANhX7zwtQ@mail.gmail.com>
References: <20170321220921.5834-1-liam@networkimprov.net> <20170321220921.5834-8-liam@networkimprov.net>
 <20170323105221.qnyw2m4cgjcb24cl@earth> <CAKvHMgROkDF43sGgvPG8Eb+z=yjuTOL9UXkOREkd=APL47DMvw@mail.gmail.com>
 <20170324093949.rno2olzywz4cds6k@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34935 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753174AbdCXKox (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 06:44:53 -0400
Received: by mail-io0-f195.google.com with SMTP id f103so2329930ioi.2
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 03:44:52 -0700 (PDT)
In-Reply-To: <20170324093949.rno2olzywz4cds6k@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Fri, Mar 24, 2017 at 2:39 AM, Sebastian Reichel <sre@kernel.org> wrote:
>
> Hi,
>
> On Thu, Mar 23, 2017 at 01:47:23PM -0700, Liam Breck wrote:
> > On Thu, Mar 23, 2017 at 3:52 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > > That still leaves the health status reading, though. From
> > > userspace's point-of-view this should be merged into the
> > > battery device, if fuel-gauge can't provide that information.
> >
> > You mean merged into the -charger device? -battery is the one
> > we're dropping.
> >
> > If you did mean -battery, could you elaborate?
>
> I was not talking about bq24190-battery. I meant the battery
> device provided by the fuel-gauge. From userspace's point of
> view a battery device, which is usually derived from the
> fuel-gauge should contain battery related information.

It doesn't sound right to ask every gauge to absorb features from a
specific charger. Userspace apps are already watching both USB and
battery power supply types for a given battery. They'll pick up a
health issue if we merge -battery and -charger health. Isn't that
enough?

> Since the battery health information is battery related it
> should somehow be merged into the data from the fuel-gauge.
> That's what Hans implemented with the function-pointer
> construct and what you suggested to implement in this mail:
>
> http://marc.info/?l=linux-pm&m=149026871313238&w=2

The merge I suggested was of properties from all power drivers into a
single sysfs device. Which I would work on if you are eager to have
it. I realize it would take a while to be merged.
