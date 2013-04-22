From: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2 06/15] powerpc/85xx: add support to JOG feature using
 cpufreq interface
Date: Mon, 22 Apr 2013 18:57:28 +0800
Message-ID: <20130422105727.GB32331@localhost.localdomain>
References: <20130419110057.GC29421@localhost.localdomain>
 <1657553.UtlPcXdK4G@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from am1ehsobe004.messaging.microsoft.com ([213.199.154.207]:54158
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204Ab3DVK5u (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2013 06:57:50 -0400
Content-Disposition: inline
In-Reply-To: <1657553.UtlPcXdK4G@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Mon, Apr 22, 2013 at 01:43:29AM +0200, Rafael J. Wysocki wrote:
> On Friday, April 19, 2013 07:00:57 PM Zhao Chenhui wrote:
> > ----- Forwarded message from Zhao Chenhui <chenhui.zhao@freescale.com> -----
> > 
> > Date: Fri, 19 Apr 2013 18:47:39 +0800
> > From: Zhao Chenhui <chenhui.zhao@freescale.com>
> > To: linuxppc-dev@lists.ozlabs.org
> > CC: linux-kernel@vger.kernel.org
> > Subject: [linuxppc-release] [PATCH v2 06/15] powerpc/85xx: add support to JOG feature using cpufreq interface
> > X-Mailer: git-send-email 1.7.3
> > 
> > From: chenhui zhao <chenhui.zhao@freescale.com>
> > 
> > Some 85xx silicons like MPC8536 and P1022 have a JOG feature, which provides
> > a dynamic mechanism to lower or raise the CPU core clock at runtime.
> > 
> > This patch adds the support to change CPU frequency using the standard
> > cpufreq interface. The ratio CORE to CCB can be 1:1(except MPC8536), 3:2,
> > 2:1, 5:2, 3:1, 7:2 and 4:1.
> > 
> > Two CPU cores on P1022 must not in the low power state during the frequency
> > transition. The driver uses a atomic counter to meet the requirement.
> > 
> > The jog mode frequency transition process on the MPC8536 is similar to
> > the deep sleep process. The driver need save the CPU state and restore
> > it after CPU warm reset.
> > 
> > Note:
> >  * The I/O peripherals such as PCIe and eTSEC may lose packets during
> >    the jog mode frequency transition.
> >  * The driver doesn't support MPC8536 Rev 1.0 due to a JOG erratum.
> >    Subsequent revisions of MPC8536 have corrected the erratum.
> > 
> > Signed-off-by: Dave Liu <daveliu@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> > CC: Scott Wood <scottwood@freescale.com>
> 
> Well, I'd like someone from the PowerPC camp to comment on this before I take it.
> 
> Thanks,
> Rafael
> 

OK. Thanks.

-Chenhui

