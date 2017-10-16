From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC PATCH v2 4/8] tick/nohz: keep tick on for a fast idle
Date: Mon, 16 Oct 2017 08:25:35 +0200
Message-ID: <1508135135.8087.17.camel@gmx.de>
References: <1506756034-6340-1-git-send-email-aubrey.li@intel.com>
         <1506756034-6340-5-git-send-email-aubrey.li@intel.com>
         <4523111.uMcC96MW3N@aspire.rjw.lan>
         <5beefd1a-2792-c371-3bb8-8ee2a6574020@linux.intel.com>
         <1508129104.8087.2.camel@gmx.de>
         <c64ed43d-8afe-7317-e31f-a7a5eef914d1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64684 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751382AbdJPG0U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Oct 2017 02:26:20 -0400
In-Reply-To: <c64ed43d-8afe-7317-e31f-a7a5eef914d1@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Li, Aubrey" <aubrey.li@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aubrey Li <aubrey.li@intel.com>
Cc: tglx@linutronix.de, peterz@infradead.org, len.brown@intel.com, ak@linux.intel.com, tim.c.chen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2017-10-16 at 13:34 +0800, Li, Aubrey wrote:
> On 2017/10/16 12:45, Mike Galbraith wrote:
> > On Mon, 2017-10-16 at 11:26 +0800, Li, Aubrey wrote:
> >>
> >> I'll try to move quiet_vmstat() into the normal idle branch if this patch series
> >> are reasonable. Is fast_idle a good indication for it?
> > 
> > see x86_tip 62cb1188ed86 sched/idle: Move quiet_vmstate() into the NOHZ code
> 
> It looks like this commit makes tick stop critical as it can be invoked in interrupt
> exit path?

do_idle() ain't critical?  It is in my book.  Hopefully, you're about
to make that idle_stat.fast_idle thingy liberal enough that we cease
mucking about with the tick on every microscopic idle (and I can then
trash my years old local patch to avoid needlessly eating that cost).

	-Mike
