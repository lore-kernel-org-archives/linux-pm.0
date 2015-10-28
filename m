From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 0/4] OPP: Some cleanups
Date: Wed, 28 Oct 2015 14:10:07 +0530
Message-ID: <20151028084007.GH30039@ubuntu>
References: <cover.1444925400.git.viresh.kumar@linaro.org>
 <4505357.GlHGRX62zQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33674 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159AbbJ1IkL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 04:40:11 -0400
Received: by pabla5 with SMTP id la5so680737pab.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 01:40:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4505357.GlHGRX62zQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, nm@ti.com

On 28-10-15, 09:25, Rafael J. Wysocki wrote:
> On Thursday, October 15, 2015 09:42:42 PM Viresh Kumar wrote:
> > Rafael,
> > 
> > These are some random cleanups, which were part of the multi-regulator
> > series earlier. Sending them separately to make that series a bit light
> > weight.
> > 
> > V1->V2:
> > - Just sending them separately.
> > 
> > Viresh Kumar (4):
> >   PM / OPP: Improve debug print messages with pr_fmt
> >   PM / OPP: Rename routines specific to old bindings with _v1
> >   PM / OPP: Parse all power-supply related bindings together
> >   PM / OPP: Create separate structure for regulator/supplies
> > 
> >  drivers/base/power/opp/core.c | 78 +++++++++++++++++++++++++++----------------
> >  drivers/base/power/opp/cpu.c  |  3 ++
> >  drivers/base/power/opp/opp.h  | 29 +++++++++++-----
> >  3 files changed, 73 insertions(+), 37 deletions(-)
> 
> I'd like to receive an ACK from someone like Stephen on this one.

He isn't around probably, I couldn't find him on IRC for last few
days. I have just asked you (in another reply) to drop the fourth
patch for now.

Apart from that things are really trivial, renaming/moving code
around. Please see if those can be included without waiting for
Stephen to return.

-- 
viresh
