From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
 driver for select intel processors
Date: Fri, 28 May 2010 13:38:24 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005281331510.4045@localhost.localdomain>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<201005271053.31087.trenn@suse.de>
	<alpine.LFD.2.00.1005272131400.24823@localhost.localdomain>
	<201005280946.32981.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201005280946.32981.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: sfr@canb.auug.org.au, linux-pm@lists.linux-foundation.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010, Thomas Renninger wrote:

> On Friday 28 May 2010 03:44:16 Len Brown wrote:
> > On Thu, 27 May 2010, Thomas Renninger wrote:
> ...
> > > > This driver does not yet know about cpu online/offline
> > > > and thus will not yet play well with cpu-hotplug.

> I thought this is also about soft on/offlining.

Right, the driver is ignorant of soft on/offlining,
but doesn't break soft on/offlining.
So rather than un-registering from cpuidle on
an offline event and re-registering on an on-line event,
it just stays registered.

The vast majority of on/offline is suspend to ram,
and this works just fine there.

Soft off-lining is somewhat broken for power management
independent of this driver, of course.  As it uses only C1
it can negatively impact the ability of the online processors
to save power and enter turbo mode...

> > > What means does not play well yet, suspend or manually offlining a
> > > core will eventually (for sure?) hang the machine?
> > 
> > It means less power savings savings than optimal
> > for processors not present at module load time.

> Ok, not really sever...

Agreed, not severe.

> > > If this is known broken, should this already be spread through
> > > linux-next?
> > 
> > If you know somebody with a system that supports CPU hot-add
> > on one of the processors supported by intel_idle, and they
> > are willing to test linux-next, please have them contact me.

> Real CPU hotplug is broken with acpi processor driver as well,
> eventually it got addressed lately. Anyway, not sever...

Yeah, if I had a system with real cpu hotplug, I'd go ahead
and test it -- but I've never even seen one.

thanks,
-Len Brown, Intel Open Source Technology Center
