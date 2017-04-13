From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Thu, 13 Apr 2017 09:09:19 -0700
Message-ID: <20170413160919.GC2064@fury>
References: <20170412230854.GA11963@fury>
 <20170413073228.GB1462@ozzy.nask.waw.pl>
 <CALCETrXkx2QqDtKmajywpvtxqCXzrQ3nuW0aOeY6+Uxa-LOXiQ@mail.gmail.com>
 <201704131739.57956@pali>
 <CALCETrWQY28h87_4oPGP=TMj8BEOrtC-+2rr2Q6qKb1H3W07tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:43967 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbdDMQJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Apr 2017 12:09:22 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrWQY28h87_4oPGP=TMj8BEOrtC-+2rr2Q6qKb1H3W07tw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Apr 13, 2017 at 08:44:28AM -0700, Andy Lutomirski wrote:
> On Thu, Apr 13, 2017 at 8:39 AM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > On Thursday 13 April 2017 17:32:48 Andy Lutomirski wrote:
> >> On Thu, Apr 13, 2017 at 12:32 AM, Michał Kępień <kernel@kempniu.pl>
> >> wrote:
> >> > What we still need, though, is an open source version of
> >> > wmiofck.exe.  I am unaware of anything like that existing and
> >> > installing the Windows Driver Kit just to run one command which
> >> > spits out a single *.h file is not something I would describe as
> >> > convenient (been there).
> >>
> >> I haven't tried to see whether they do what's needed, but there's
> >> OpenWBEM and OpenPegasus.
> >>
> >> Anyway, if such a tool exists, it would be handy to expose the binary
> >> MOF data to userspace so the tool could be used to help get WMI
> >> working on new platforms.
> >
> > In this case, when WMI stay in kernel, MOF data could be exported via
> > debugfs? I think there is no need to have them in sysfs stable ABI. As
> > above usage (get WMI working on new platforms) looks like for debugging
> > purpose.
> >
> 
> That's a reasonable point.
> 

Also agreed.

-- 
Darren Hart
VMware Open Source Technology Center
