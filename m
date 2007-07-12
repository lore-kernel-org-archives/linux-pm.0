From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec
	base	hibernation
Date: Thu, 12 Jul 2007 17:18:03 +0000
Message-ID: <1184260683.9346.91.camel__27797.83442752$1184232063$gmane$org@caritas-dev.intel.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<1184251423.9346.55.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707112345250.28090@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707112345250.28090@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thu, 2007-07-12 at 00:03 -0700, david@lang.hm wrote:
> >
> > The kexec jump is the first step, maybe the simplest step. There are
> > many other issues to be resolved, at least the following ones.
> >
> > 1. Separate device suspend from device hibernate.
> 

Maybe my usage of terminology has some problem. But, the "device
hibernate" here means put device into quiescent state and save the
device state, but do not put device into low power state. 

> > 6. Reduce the boot-up time of kexec kernel. Maybe the kexec kernel can
> > be hibernate/resume by the normal kernel too. This way, a real
> > kexec/boot-up is only needed for the first time.
> 
> the hibernate kernel shouldn't need a lot of the features of the standard 
> kerneel (does it really need sound for example), and if tailored even 
> tighter could be configured to only have the drivers actually used for the 
> save and restore, makeing a _very_ minimal kernel (no USB, no network, 
> only simple video drivers, etc) greatly speeding up the boot

There is no need for two kernel. Most drivers and optional features are
compiled as modules, as that of most desktop distributions. So just
"insmod" needed modules only in hibernate kernel is sufficient.

Best Regards,
Huang Ying
