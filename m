From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH][v6] PM / hibernate: Print the possible panic reason
 when resuming with inconsistent e820 map
Date: Sun, 28 Aug 2016 13:08:02 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE64028789552@shsmsx102.ccr.corp.intel.com>
References: <1445404900-29702-1-git-send-email-yu.c.chen@intel.com>
 <20160823094527.GG7276@linux-rxt1.site> <20160823100155.GA12738@sharon>
 <20160824013610.GA26119@linux-rxt1.site> <20160825110748.GA22104@sharon>
 <20160826195654.GD21442@amd> <20160828020710.GB5941@sharon>
 <20160828124738.GA10562@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18479 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755261AbcH1NIH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Aug 2016 09:08:07 -0400
In-Reply-To: <20160828124738.GA10562@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: joeyli <jlee@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: Pavel Machek [mailto:pavel@ucw.cz]
> Sent: Sunday, August 28, 2016 8:48 PM
> To: Chen, Yu C
> Cc: joeyli; Rafael J. Wysocki; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH][v6] PM / hibernate: Print the possible panic reason when
> resuming with inconsistent e820 map
> 
> On Sun 2016-08-28 10:07:10, Chen Yu wrote:
> > Hi,
> > On Fri, Aug 26, 2016 at 09:56:54PM +0200, Pavel Machek wrote:
> > > Hi!
> > >
> > > > > > > What's the progress of this patch? Looks already have experts
> review it.
> > > > > > > Why this patch didn't accept?
> > > > > > This patch is a little overkilled, and I have saved another
> > > > > > simpler version to only check the md5 hash (as people suggested) for
> it. I can post it later.
> > > > > >
> > > > >
> > > > > I am happy to test and review it.
> > > > >
> > > > Here it is. As Rafael is on travel, it would be grateful if you
> > > > can give some advance on this, thanks!
> > >
> > > Better than last one.
> > >
> > > > +		return -ENOMEM;
> > > > +
> > > > +	req = ahash_request_alloc(tfm, GFP_ATOMIC);
> > >
> > > what context is this called from? GFP_ATOMIC allocations like to fail...
> > >
> > It is in normal process context, OK, I'll change it to GFP_KERNEL.
> > > > +static int hibernation_e820_check(void *buf) {
> > > > +	int ret;
> > > > +	char result[MD5_HASH_SIZE] = {0};
> > > > +
> > > > +	ret = get_e820_md5(&e820_saved, result);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	if (memcmp(result, buf, MD5_HASH_SIZE))
> > > > +		e820_conflict = true;
> > >
> > > Passing return value using global variable is ugly. Can you just
> > > print the warning and kill the box here?
> > Do you mean get rid of the panic hooker and just print the warning
> > here?
> 
> Yep, I'd do that... (And you probably want to rise the severity).
Sometime the users might not be able to see the warning during resume(too fast)
and got a system panic later, so I was thinking if it might help user to see the warning
in panic too, how about this:

if (memcmp(result, buf, MD5_DIGEST_SIZE)) {
	pr_err("PM: e820 map conflict detected!\n");
	register_die_notifier(&hibernation_die_notifier);
} 
So we can print warning in hibernation_die_notifier without introducing a global variable?

Thanks,
Yu
