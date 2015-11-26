From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] devfreq for next-RC
Date: Thu, 26 Nov 2015 23:48:11 +0100
Message-ID: <7258636.bTrShIYD0P@vostro.rjw.lan>
References: <1633234957.280321448504078990.JavaMail.weblogic@epmlwas08a> <12501801.eCeCJmHOSo@vostro.rjw.lan> <CAJ0PZbQ2Wh6kEjRjGfHhLLsnTcLcxb_iBn9p9auC2V+WTjgcQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55631 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752850AbbKZWS3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 17:18:29 -0500
In-Reply-To: <CAJ0PZbQ2Wh6kEjRjGfHhLLsnTcLcxb_iBn9p9auC2V+WTjgcQw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: Linux PM list <linux-pm@vger.kernel.org>, rafael.j.wysocki@intel.com, Chanwoo Choi <cw00.choi@samsung.com>

On Thursday, November 26, 2015 10:51:18 PM MyungJoo Ham wrote:
> 6 of the 8 patches are fixes or style-updates.

Style updates are not fixes, are they?

> Other 2 of 8 (PM / devfreq: Set the freq_table of devfreq device,
> MAINTAINERS: Add devfreq-event entry)
> are small updates (the first of the two may be seen as a fix to follow
> the given API semantics though)
> 
> Do you want to pull the 6 clearly-fixes only for the RC?

The only type of material I want to push for -rc4 or later is fixes.  No style
updates now in particular, please.

And generally, if there's anything that can wait for the next merge window,
there's no reason to push it today.

So please let me know which of the commits in your branch are urgent in
your opinion and I'll put them into a separate branch and queue them up
for -rc4.

The rest will wait.

Thanks,
Rafael


> On Thu, Nov 26, 2015 at 10:58 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, November 26, 2015 02:14:40 AM MyungJoo Ham wrote:
> >> Dear Rafael,
> >>
> >> Here goes the pull reqest for next 4.4 RCx.
> >>
> >>
> >> Cheers,
> >> MyungJoo
> >>
> >> The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:
> >>
> >>   Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)
> >>
> >> are available in the git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/pull_req_20151126
> >>
> >> for you to fetch changes up to 38bb853595404cdd2210268dd508ce303ab836e5:
> >>
> >>   MAINTAINERS: Add devfreq-event entry (2015-11-26 10:54:18 +0900)
> >>
> >> ----------------------------------------------------------------
> >> Pull request for Rafael on 2015-11-26. Based on 4.4-rc2
> >>
> >> ----------------------------------------------------------------
> >> Chanwoo Choi (7):
> >>       PM / devfreq: event: Remove the error log of devfreq_event_get_edev_by_phandle()
> >>       PM / devfreq: event: Fix the error and warning from script/checkpatch.pl
> >>       PM / devfreq: Add show_one macro to delete the duplicate code
> >>       PM / devfreq: Set the freq_table of devfreq device
> >>       PM / devfreq: Modify the indentation of trans_stat sysfs for readability
> >>       MAINTAINERS: Add missing git repository and directory for devfreq
> >>       MAINTAINERS: Add devfreq-event entry
> >>
> >> MyungJoo Ham (1):
> >>       PM / devfreq: Do not show statistics if it's not ready.
> >>
> >>  MAINTAINERS                     | 13 +++++++
> >>  drivers/devfreq/devfreq-event.c | 16 +++------
> >>  drivers/devfreq/devfreq.c       | 78 ++++++++++++++++++++++++++++++++---------
> >>  include/linux/devfreq.h         |  2 +-
> >>  4 files changed, 81 insertions(+), 28 deletions(-)
> >
> > Is this really 4.4-rc material?
> >
> > We're quite late in the cycle and I'm not willing to push anything more than
> > fixes to Linus at this point.
> >
> > I can pull this and queue it up for v4.5 if that works for you, though.
> >
> > Thanks,
> > Rafael
> >
> 
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
