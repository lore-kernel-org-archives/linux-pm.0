From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal management updates for v4.17-rc2
Date: Thu, 26 Apr 2018 10:28:04 -0700
Message-ID: <20180426172802.GA2086@localhost.localdomain>
References: <20180420161834.GA22776@localhost.localdomain>
 <1524576345.2597.31.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1524576345.2597.31.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hey Rui,

On Tue, Apr 24, 2018 at 09:25:45PM +0800, Zhang Rui wrote:
> Hi, Eduardo,
> 
> On 五, 2018-04-20 at 09:18 -0700, Eduardo Valentin wrote:
> > Hello Linus,
> > 
> > Here are a couple of fixes on thermal subsystem.
> > Please consider pulling from
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-
> > thermal fixes
> > 
> > to receive Thermal Management updates for v4.17-rc2 with top-most
> > 
> > e04907dbc25930b88ee2328fe692c776f63ddf2c:
> > 
> >   dt-bindings: thermal: Remove "cooling-{min|max}-level" properties
> > (2018-04-18 07:04:28 -0700)
> > 
> > on top of commit 60cc43fc888428bb2f18f08997432d426a243338:
> > 
> >   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> > 
> As this does not hit 4.17-rc2, and I have some thermal core fixes now,
> would you mind rebase the patches on top of 4.17-rc2, and send the pull
> request to me, including the exynos fixes, so that I can pull and queue
> for next -rc?

Linus already pulled this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=83beed7b2b26f232d782127792dd0cd4362fdc41

But for this week I will rebase the fixes I have and send them to you
first, so you send to Linus a combined one.

> 
> thanks,
> rui

BR,

Eduardo
