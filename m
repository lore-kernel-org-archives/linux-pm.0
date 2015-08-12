From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: 3.18: lockdep problems in cpufreq
Date: Wed, 12 Aug 2015 10:46:59 +0530
Message-ID: <20150812051659.GI32049@linux>
References: <20141214213655.GA11285@n2100.arm.linux.org.uk>
 <CAKohponhkk9BK6-7ScHeZa4R43iooWQFV8YoPLv6LjO40GNq=A@mail.gmail.com>
 <20150518185645.GA28053@n2100.arm.linux.org.uk>
 <2574268.XBqpdL2VLI@vostro.rjw.lan>
 <20150811170357.GA24529@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33830 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbbHLFRM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 12 Aug 2015 01:17:12 -0400
Received: by pawu10 with SMTP id u10so6469692paw.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 22:17:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811170357.GA24529@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Yadwinder Singh Brar <yadi.brar@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11-08-15, 18:03, Russell King - ARM Linux wrote:
> On Tue, May 19, 2015 at 12:05:55AM +0200, Rafael J. Wysocki wrote:
> > On Monday, May 18, 2015 07:56:45 PM Russell King - ARM Linux wrote:
> > > On Tue, Dec 16, 2014 at 09:11:53AM +0530, Viresh Kumar wrote:
> > > > On 16 December 2014 at 04:39, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > > > Well, here's a patch which I'm running on top of 3.18 at the moment,
> > > > > which is basically what I described in my email, and I'm running with it
> > > > > and it is without any lockdep complaint.
> > > > 
> > > > We need two separate patches now, one for 3.18 and other one for 3.19-rc.
> > > > 3.19 has see lots of changes in this particular file and so we need to
> > > > change few things here.

Was the patch for latest kernel ever circulated ? Probably that's why
Eduardo never got back to it.

-- 
viresh
