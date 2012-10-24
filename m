From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: fix warning when compile
Date: Wed, 24 Oct 2012 23:03:18 +0200
Message-ID: <4386557.NfbZYeZWxd@vostro.rjw.lan>
References: <1351046728-10965-1-git-send-email-youquan.song@intel.com> <4092469.vxd3uL7amA@vostro.rjw.lan> <70A3B115BE79814398B8E4E7C4AE18EE13A10B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35400 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161180Ab2JXU7b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 24 Oct 2012 16:59:31 -0400
In-Reply-To: <70A3B115BE79814398B8E4E7C4AE18EE13A10B@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Song, Youquan" <youquan.song@intel.com>
Cc: "Wu, Fengguang" <fengguang.wu@intel.com>, "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>, Rik van Riel <riel@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Youquan Song <youquan.song@linux.intel.com>

On Wednesday 24 of October 2012 02:14:13 Song, Youquan wrote:
> >>  	int64_t thresh = LLONG_MAX; /* Discard outliers above this value. */
> 
> >Shouldn't this one be uint64_t too?
> 
> Thanks Rafael!  Fenggung also asked me the similar question. 
> But I think, the compile only complains about do_div() at SH 32bit
> architecture, the above int64_t definition should be OK and I do not
> find any issue without changing it to uint64_t. 

OK

I fixed up the original patch.

Thanks,
Rafael


> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
> Sent: Wednesday, October 24, 2012 8:28 AM
> To: Song, Youquan
> Cc: Wu, Fengguang; yuanhan.liu@linux.intel.com; Rik van Riel; linux-pm@vger.kernel.org; Youquan Song
> Subject: Re: [PATCH] cpuidle: fix warning when compile
> 
> On Tuesday 23 of October 2012 22:45:28 Youquan Song wrote:
> > Fix the warning complain when compile the kernel.
> > 
> > drivers/cpuidle/governors/menu.c: In function 'get_typical_interval':
> > drivers/cpuidle/governors/menu.c:268:2: warning: comparison of 
> > distinct pointer types lacks a cast [enabled by default]
> > drivers/cpuidle/governors/menu.c:277:2: warning: comparison of 
> > distinct pointer types lacks a cast [enabled by default]
> > 
> > Signed-off-by: Youquan Song <youquan.song@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/governors/menu.c 
> > b/drivers/cpuidle/governors/menu.c
> > index 26d5667..2efee27 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -248,7 +248,7 @@ static enum hrtimer_restart 
> > menu_hrtimer_notify(struct hrtimer *hrtimer)  static u32 
> > get_typical_interval(struct menu_device *data)  {
> >  	int i = 0, divisor = 0;
> > -	int64_t max = 0, avg = 0, stddev = 0;
> > +	uint64_t max = 0, avg = 0, stddev = 0;
> >  	int64_t thresh = LLONG_MAX; /* Discard outliers above this value. */
> 
> Shouldn't this one be uint64_t too?
> 
> >  	unsigned int ret = 0;

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
