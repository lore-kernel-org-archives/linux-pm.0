From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH v2 0/2] PM / QoS: Device resume latency framework fix
Date: Tue, 07 Nov 2017 02:08:21 +0100
Message-ID: <2157585.74BgekV60d@aspire.rjw.lan>
References: <5770848.Kdi5IjVKeE@aspire.rjw.lan> <2520927.XkLgALY3I0@aspire.rjw.lan> <CAMuHMdU-BMmznrtR6S+uppWdsiXjWZKwQYemb+_q89r852KFjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU-BMmznrtR6S+uppWdsiXjWZKwQYemb+_q89r852KFjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Reinette Chatre <reinette.chatre@intel.com>, Ramesh Thomas <ramesh.thomas@intel.com>, Alex Shi <alex.shi@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Monday, November 6, 2017 2:46:48 PM CET Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Fri, Nov 3, 2017 at 12:42 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Thursday, November 2, 2017 12:00:27 AM CET Rafael J. Wysocki wrote:
> >> This series is a replacement for commit 0cc2b4e5a020 (PM / QoS: Fix device
> >> resume latency PM QoS) that had to be reverted due to problems introduced by it.
> >>
> >> This time the genpd PM QoS governor is first updated to be more consistent
> >> and the PM QoS changes are made on top of that which simplifies the second
> >> patch quite a bit.
> >>
> >> This is based on the linux-next branch from linux-pm.git as of now (should
> >> also apply to the current mainline just fine).
> >>
> >> Please test if you can or let me know if you have any comments.
> >
> > The v2 removes a couple of redundant checks from the first patch (and add
> > comments to explain why the checks are not needed) and fixes up the
> > "no constraint" value collision with a valid constraint multiplied by
> > NSEC_PER_USEC in the second patch.
> >
> > Please test if possible and let me know about any issues.
> 
> With this series, the 3 issues I reported before do not happen.
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thank you.

Thanks!

Rafael
