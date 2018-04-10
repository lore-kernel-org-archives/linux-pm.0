From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Date: Tue, 10 Apr 2018 13:53:35 +0300
Message-ID: <1523357615.2753.188.camel@gmail.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
         <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2018-04-10 at 12:22 +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 10, 2018 at 12:18 PM, Yu Chen <yu.c.chen@intel.com>
> wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> > 
> > There's a use case during test to only print specific round of
> > loops
> > if --interval is specified, for example, with this patch applied:
> > 
> > turbostat -i 5 --max_loops 4
> > will capture 4 samples with 5 seconds interval.
> 
> Why --max_loops and not just --loops or --iterations?

Or just --count.

Artem.
