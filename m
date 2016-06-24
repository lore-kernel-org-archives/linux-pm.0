From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / devfreq: Send the DEVFREQ_POSTCHANGE notification when target() is failed
Date: Fri, 24 Jun 2016 15:39:47 +0200
Message-ID: <2239639.FdhMzil69d@vostro.rjw.lan>
References: <1466648323-776-1-git-send-email-cw00.choi@samsung.com> <CGME20160623142439epcas1p445e53890a3f909f08de100dfedb9bd04@epcas1p4.samsung.com> <905715207.45121.1466728089442.JavaMail.weblogic@ep1ml103c>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44748 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751537AbcFXNf1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 09:35:27 -0400
In-Reply-To: <905715207.45121.1466728089442.JavaMail.weblogic@ep1ml103c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, Chanwoo Choi <cwchoi00@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Lin Huang <hl@rock-chips.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, June 24, 2016 12:28:09 AM MyungJoo Ham wrote:
> > Hi,
> > 
> > 2016-06-23 22:40 GMT+09:00 Rafael J. Wysocki <rafael@kernel.org>:
> > > On Thu, Jun 23, 2016 at 4:18 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > >> This patch sends the DEVFREQ_POSTCHANGE notification when
> > >> devfreq->profile->targer() is failed. The PRECHANGE/POSTCHANGE
> > >> should be paired.
> > >>
> > >> Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
> > >> Reported-by: Lin Huang <hl@rock-chips.com>
> > >> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >> ---
> > >
> > > This looks like a fix for a recent regression, so I can apply it directly.
> > >
> > > Do you want me to do that?
> > 
> > Yes. Thanks for picking this patch up.
> > 
> > Regards,
> > Chanwoo Choi
> > 
> > 
> 
> That'd be great. Thanks!

OK, applied.

Thanks!

