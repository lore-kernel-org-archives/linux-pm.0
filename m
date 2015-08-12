From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Wed, 12 Aug 2015 08:21:29 +0100
Message-ID: <20150812072129.GD7557@n2100.arm.linux.org.uk>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
 <20150812051659.GI32049@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:53548 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933581AbbHLHVl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 03:21:41 -0400
Content-Disposition: inline
In-Reply-To: <20150812051659.GI32049@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Wed, Aug 12, 2015 at 10:46:59AM +0530, Viresh Kumar wrote:
> On 11-08-15, 18:03, Russell King - ARM Linux wrote:
> > On Tue, May 19, 2015 at 12:05:55AM +0200, Rafael J. Wysocki wrote:
> > > On Monday, May 18, 2015 07:56:45 PM Russell King - ARM Linux wrote:
> > > > On Tue, Dec 16, 2014 at 09:11:53AM +0530, Viresh Kumar wrote:
> > > > > On 16 December 2014 at 04:39, Russell King - ARM Linux
> > > > > <linux@arm.linux.org.uk> wrote:
> > > > > > Well, here's a patch which I'm running on top of 3.18 at the moment,
> > > > > > which is basically what I described in my email, and I'm running with it
> > > > > > and it is without any lockdep complaint.
> > > > > 
> > > > > We need two separate patches now, one for 3.18 and other one for 3.19-rc.
> > > > > 3.19 has see lots of changes in this particular file and so we need to
> > > > > change few things here.
> 
> Was the patch for latest kernel ever circulated ? Probably that's why
> Eduardo never got back to it.

Maybe not - I often lose track of which patches are in what state -
tracking the state of 250+ patches over many months and in some cases
_years_ is not easy.

That's still no reason for Eduardo to _completely_ ignore this thread,
especially when Rafael explicitly tried to get comment from Eduardo.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
