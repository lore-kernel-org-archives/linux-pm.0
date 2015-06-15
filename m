From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: cancel the synchronous restriction of pm-trace
Date: Tue, 16 Jun 2015 01:05:54 +0200
Message-ID: <2891939.OHrpPqfymO@vostro.rjw.lan>
References: <554A297C.2040305@linux.intel.com> <556729A9.7010105@linux.intel.com> <557E6350.6080207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65452 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750826AbbFOWj5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 18:39:57 -0400
In-Reply-To: <557E6350.6080207@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Cc: len.brown@intel.com, pavel@ucw.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Monday, June 15, 2015 01:32:00 PM Fu, Zhonghui wrote:
> 
> On 2015/5/28 22:43, Fu, Zhonghui wrote:
> >
> > On 2015/5/21 9:16, Rafael J. Wysocki wrote:
> >> On Wednesday, May 20, 2015 04:50:13 PM Fu, Zhonghui wrote:
> >>> On 2015/5/16 8:45, Rafael J. Wysocki wrote:

[cut]

> >>>> Won't this serialize the whole thing again?
> >>> Yes, this mutex lock will ultimately serialize all PM operations. But, all device's PM operations are asynchronous each other at first. So, the PM operation order of all devices will vary in multiple suspend/resume. This can be similar to real to an extreme, and helpful to debugging.
> >> I see.  You're saying that callbacks will be serialized, but if they originally
> >> would be asynchronous with respect to each other (they may run in parallel IOW),
> >> their respective ordering may vary between suspend-resume cycles.
> >>
> >> The class of bugs you can catch this way is quite limited and the change is
> >> rather intrusive, so I'm with Pavel on that.
> > Sorry for late reply.
> >
> > Although the improvement to PM-trace is limited, I still think it is helpful for debugging some special suspend/resume bugs.
> 
> Hi Rafael,
> 
> This patch will not be merged into mainline kernel, right?

No, it won't.

At least for now, the case for it is not convincing enough.

Thanks,
Rafael

