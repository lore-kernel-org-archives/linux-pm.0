From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] intel_powerclamp: Fix cstate counter detection.
Date: Thu, 02 Jan 2014 11:03:32 +0800
Message-ID: <1388631812.3739.75.camel@rzhang1-mobl4>
References: <1384758395-5074-1-git-send-email-yshuiv7@gmail.com>
	 <528A3EC9.8060301@linux.intel.com>
	 <CAGqt0zw2wEM_4SqMA8tqzABe0M1-ZXxM6X3rh4OezfnS9-eXJg@mail.gmail.com>
	 <528B74C9.3010902@linux.intel.com>
	 <CAGqt0zzZpXpL7MfvfFWrxbChBfu30i_tcyCoavzMJsrPmg5AAw@mail.gmail.com>
	 <20131119103818.2cccaa93@ultegra>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:5779 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaABDDh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jan 2014 22:03:37 -0500
In-Reply-To: <20131119103818.2cccaa93@ultegra>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Yuxuan Shui <yshuiv7@gmail.com>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm@vger.kernel.org

On Tue, 2013-11-19 at 10:38 -0800, Jacob Pan wrote:
> On Wed, 20 Nov 2013 02:09:12 +0800
> Yuxuan Shui <yshuiv7@gmail.com> wrote:
> 
> > On Tue, Nov 19, 2013 at 10:25 PM, Arjan van de Ven
> > <arjan@linux.intel.com> wrote:
> > > On 11/18/2013 9:29 PM, Yuxuan Shui wrote:
> > >>
> > >> On Tue, Nov 19, 2013 at 12:22 AM, Arjan van de Ven
> > >> <arjan@linux.intel.com> wrote:
> > >>>
> > >>> On 11/17/2013 11:06 PM, Yuxuan Shui wrote:
> > >>>>
> > >>>>
> > >>>> Having all zero cstate count doesn't necesserily mean the cstate
> > >>>> counter is no functional.
> > >>>>
> > >>>
> > >>> ... but it does mean that powerclamp will be non-functional
> > >>>
> > >>> but you had a reason to make this patch.
> > >>> Can you expand a little bit on what you were seeing that made you
> > >>> decide this patch was needed ?
> > >>>
> > >> There are possibilities that the system is busy from boot so that
> > >> it doesn't enter C-state at all, right? In that situation
> > >> powerclamp won't work.
> > >
> > >
> > >
> > > that is... extremely unlikely. Have you seen that happen?
> > 
> > Sure I've seen this, that's why I wrote this patch in the first place.
> > It's my (rather old) laptop. After boot powertop show zero percent in
> > C3 and C6, and powerclamp complaining pkg cstate counter is not
> > functional.
> > 
> I see, this is indeed a corner case where the sanity check by powerclamp
> driver is too strict and refused to load. I am OK with your patch and
> perhaps add a sanity check later while idle injection is in action?
> 
so do you want me to include this patch for 3.14?

thanks,
rui

> > >
> > >>
> > >> Also, pkg_state_counter is used to calculate a cstate ratio, and I
> > >> can't find any reason why powerclamp will be non-funtional when
> > >> that ratio is zero.
> > >
> > >
> > > if the counters we use are zero.. we can't use them in our control
> > > loop
> > 
> > I skimmed through the code. pkg_state_counter is called twice (except
> > that once in start_power_clamp). Once in poll_pkg_cstate to calculate
> > pkg_cstate_ratio_cur which is used for sysfs. The other time is in
> > powerclamp_adjust_controls, which is used to calculate a ratio which
> > is stored in a global variable current_ratio.
> > 
> > The current_ratio is also used twice. Once in the same function, to
> > check if we have done enough idle injection. The other is in
> > adjust_compensation, where it's used to calculate a delta. In neither
> > case current_ratio being zero will matter.
> > 
> > Also, I'm using this patch myself, and it seems to be totally
> > functional.
> > 
> > So I failed to see why the counter can't be zero. If I made any
> > mistakes, can you point them out?
> > 
> 
> > >
> > > again, what were you actually seeing?
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> [Jacob Pan]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


