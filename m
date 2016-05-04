From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value
Date: Wed, 04 May 2016 23:20:28 +0200
Message-ID: <13315467.gEDWYxNU10@vostro.rjw.lan>
References: <1461669301-30834-1-git-send-email-james.morse@arm.com> <20160427091434.GA4303@red-moon> <20160428082023.GA10216@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48269 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752541AbcEDVRR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 17:17:17 -0400
In-Reply-To: <20160428082023.GA10216@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, James Morse <james.morse@arm.com>, lina.iyer@linaro.org
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thursday, April 28, 2016 10:20:23 AM Daniel Lezcano wrote:
> On Wed, Apr 27, 2016 at 10:14:34AM +0100, Lorenzo Pieralisi wrote:
> > [+ Lina]
> > 
> > On Tue, Apr 26, 2016 at 09:05:57PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Apr 26, 2016 at 1:31 PM, Lorenzo Pieralisi
> > > <lorenzo.pieralisi@arm.com> wrote:
> > > > On Tue, Apr 26, 2016 at 12:15:01PM +0100, James Morse wrote:
> > > >> arm_cpuidle_suspend() may return -EOPNOTSUPP, or any value returned
> > > >> by the cpu_ops/cpuidle_ops suspend call. arm_enter_idle_state() doesn't
> > > >> update 'ret' with this value, meaning we always signal success to
> > > >> cpuidle_enter_state(), causing it to update the usage counters as if we
> > > >> succeeded.
> > > >>
> > > >> Fixes: 191de17aa3c1 ("ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function")
> > > >> Signed-off-by: James Morse <james.morse@arm.com>
> > > >> ---
> > > >>  drivers/cpuidle/cpuidle-arm.c | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

OK, applied, tagged for -stable (4.1+).

Thanks everybody!

