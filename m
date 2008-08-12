From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Remove WARN_ON from device_pm_add
Date: Tue, 12 Aug 2008 16:29:52 +0200
Message-ID: <200808121629.53425.rjw__3286.00571160695$1218551456$gmane$org@sisk.pl>
References: <200808090105.14770.rjw@sisk.pl>
	<20080812125902.GB13910@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080812125902.GB13910@cs181140183.pp.htv.fi>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Adrian Bunk <bunk@kernel.org>
Cc: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 12 of August 2008, Adrian Bunk wrote:
> On Sat, Aug 09, 2008 at 01:05:13AM +0200, Rafael J. Wysocki wrote:
> > PM: Remove WARN_ON from device_pm_add
> > 
> > Fix message in device_pm_add() saying that the device will not be
> > added to dpm_list, although in fact the device is going to be added
> > to the list regardless of the ordering violation.
> > 
> > Remove the WARN_ON(true) triggered in that situation, because it is
> > hit by USB very often and spams the users' logs.
> > 
> > This patch fixes bug #11263
> 
> Michael Tsirkin said in #11284 (which is marked as a duplicate of #11263):
> 
> <--  snip  -->
> 
> > What exactly is this instability?
> 
> X often crashes on resume, sometimes ACPI seems to stop working
> after resume. I am trying to figure exact way to reproduce first,
> or get some relevant logs, then I'll report.
> 
> > Does 2.6.26 work fine?
> 
> yes
> 
> <--  snip  -->
> 
> 
> Is this a separate regression or did the WARN_ON different from the 
> first assumption indicate a functional regression?

No, it doesn't indicate a functional regression.

In 2.6.26 the WARN_ON() was artificially silenced by USB, but that stopped
working after the PM core had changed in 2.6.27-rc.

Thanks,
Rafael
