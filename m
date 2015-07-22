From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 2/4] PM / devfreq: cache the last call to
 get_dev_status()
Date: Wed, 22 Jul 2015 16:04:48 +0100
Message-ID: <20150722150448.GA973@e104805>
References: <319181187.26291437107498063.JavaMail.weblogic@epmlwas08c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:35244 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932206AbbGVPEz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 11:04:55 -0400
Content-Disposition: inline
In-Reply-To: <319181187.26291437107498063.JavaMail.weblogic@epmlwas08c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, Orjan Eide <Orjan.Eide@arm.com>, Punit Agrawal <Punit.Agrawal@arm.com>

Hi MyungJoo,

On Fri, Jul 17, 2015 at 05:31:38AM +0100, MyungJoo Ham wrote:
> > The return value of get_dev_status() can be reused.  Cache it so that
> > other parts of the kernel can reuse it instead of having to call the
> > same function again.
> > 
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> > ---
> > 
> > This patch tries to let multiple components.  To summarize the
> > discussion in v1[1] I can think of three alternatives:
> > 
> >   1) Change get_dev_status() to return absolute values for busy_time
> >      and total_time
> >   2) Make core devfreq call get_dev_status() periodically (for
> >      example, before calling the governor) and all the entities that
> >      want access can do so via a pointer in devfreq
> >   3) Make the simple ondemand governor call get_dev_status()
> >      periodically and cache it, forcing all the other entities to
> >      rely on that governor being active
> > 
> > [1] http://thread.gmane.org/gmane.linux.power-management.general/61936/focus=61993
> > 
> > This patch implements option 3)
> > 
> >  drivers/devfreq/devfreq.c                 |  5 +++++
> >  drivers/devfreq/governor_simpleondemand.c | 33 +++++++++++++++++--------------
> >  include/linux/devfreq.h                   |  7 +++++++
> >  3 files changed, 30 insertions(+), 15 deletions(-)
> > 
> 
> Another question has risen as seeing Chanwoo's RFC patches,
> which have a similar objective to different devices with
> much less intervention:
> 
> [RFC PATCH 0/2] thermal: Add generic devfreq cooling device
> https://lkml.org/lkml/2015/7/16/334
> (This patch set also requires updates as it appears not
> to use opp notifiers properly, but it shows the direction
> on how to implement thermal/qos inputs to devfreq devices)
> 
> Can't you simply use OPP's disable/enable functions and
> let devfreq automatically update itself accordingly?
> It simplifies your codes as well especially if you put
> your possible frequencies to DT.

Ok, we can use OPP enable/disable to modify the available OPPs and let
devfreq take the appropriate decision. I'll send a v3 next week.

Still, the question of how to let multiple components access
get_dev_status() is still open.  Have you had time to consider it?

Cheers,
Javi
