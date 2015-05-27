From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] cpupower: mperf monitor: fix output in MAX_FREQ_SYSFS mode
Date: Wed, 27 May 2015 15:24:56 +0200
Message-ID: <3575658.uqSK43yRpj@skinner>
References: <1431354935-7538-1-git-send-email-herton@redhat.com> <20150511154022.GA3390@localhost.localdomain> <31826905.dNXxBhfo7A@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44063 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbbE0NY6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 27 May 2015 09:24:58 -0400
In-Reply-To: <31826905.dNXxBhfo7A@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Herton R. Krzesinski" <herton@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

and sorry for the late answer, this had not highest prio...

On Wednesday, May 20, 2015 02:26:47 AM Rafael J. Wysocki wrote:
> On Monday, May 11, 2015 12:40:22 PM Herton R. Krzesinski wrote:
> > On Mon, May 11, 2015 at 11:35:35AM -0300, Herton R. Krzesinski wrote:
> > > There is clearly wrong output when mperf monitor runs in MAX_FREQ_SYSFS
> > > mode: average frequency shows in kHz unit (despite the intended output
> > > to be in MHz), and percentages for C state information are all wrong
> > > (including high/negative values shown).
> > > 
> > > The problem is that the max_frequency read on initialization isn't used
> > > where it should have been used on mperf_get_count_percent (to estimate
> > > the number of ticks in the given time period), and the value we read
> > > from sysfs is in kHz, so we must divide it to get the MHz value to use
> > > in current calculations.
> > > 
> > > While at it, also I fixed another small issues in the debug output of
> > > max_frequency value in mperf_get_count_freq.
> > > 
> > > Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
> > > ---
> > > 
> > >  tools/power/cpupower/utils/idle_monitor/mperf_monitor.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > Actually please consider v2 patch below, just a minor change in the debug
> > output, which isn't a percentage...
> 
> Thomas, any comments?

I tried to find fitting HW without much success.
The MAX_FREQ_SYSFS is used only on rare HW and it may never got a proper test.

Patch looks sane. Even I cannot add a Tested-by:
you may add:

Acked-by: Thomas Renninger <trenn@suse.de>

and add it.

Thanks,

       Thomas
