From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Tue, 10 Apr 2018 20:19:49 +0800
Message-ID: <20180410121949.GA29464@yu-chen.sh.intel.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
 <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Artem Bityutskiy <artem.bityutskiy@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 10, 2018 at 12:22:16PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 10, 2018 at 12:18 PM, Yu Chen <yu.c.chen@intel.com> wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> >
> > There's a use case during test to only print specific round of loops
> > if --interval is specified, for example, with this patch applied:
> >
> > turbostat -i 5 --max_loops 4
> > will capture 4 samples with 5 seconds interval.
> 
> Why --max_loops and not just --loops or --iterations?
>
I thought -l has been used already. OK, changed to --interation and
-t respectively.

Thanks!
