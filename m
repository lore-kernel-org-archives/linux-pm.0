From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Additional fix : (was [v2]printk: fix delayed
 messages from CPU hotplug events)
Date: Sat, 31 Jul 2010 17:12:16 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6381049__4572.60776679522$1280576625$gmane$org@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E41803@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5E41803@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Kevin Cernekee <cernekee@gmail.com>, King - ARM Linux <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Russell@smtp1.linux-foundation.org" <Russell@smtp1.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Andrew,
> -----Original Message-----
> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> bounces@lists.linux-foundation.org] On Behalf Of Shilimkar, Santosh
> Sent: Thursday, July 01, 2010 9:58 AM
> To: Kevin Cernekee; linux-pm@lists.linux-foundation.org
> Cc: King - ARM Linux; linux-kernel@vger.kernel.org; Russell@smtp1.linux-
> foundation.org
> Subject: Re: [linux-pm] Additional fix : (was [v2]printk: fix delayed
> messages from CPU hotplug events)
> 
> (Adding linux-pm@lists.linux-foundation.org)
> 
> > -----Original Message-----
> > From: Shilimkar, Santosh
> > Sent: Tuesday, June 29, 2010 2:22 PM
> > To: 'Kevin Cernekee'
> > Cc: linux-kernel@vger.kernel.org; Russell King - ARM Linux
> > Subject: Additional fix : (was [v2]printk: fix delayed messages from CPU
> > hotplug events)
> >
> > Hi,
> >
> > I have faced similar issue as what is being described in below with
> > latest kernel.
> >
> > ------------------------------------------------
> > https://patchwork.kernel.org/patch/103347/
> >
> > When a secondary CPU is being brought up, it is not uncommon for
> > printk() to be invoked when cpu_online(smp_processor_id()) == 0.  The
> > case that I witnessed personally was on MIPS:
> >
> > http://lkml.org/lkml/2010/5/30/4
> >
> > If (can_use_console() == 0), printk() will spool its output to log_buf
> > and it will be visible in "dmesg", but that output will NOT be echoed to
> > the console until somebody calls release_console_sem() from a CPU that
> > is online.  Therefore, the boot time messages from the new CPU can get
> > stuck in "limbo" for a long time, and might suddenly appear on the
> > screen when a completely unrelated event (e.g. "eth0: link is down")
> > occurs.
> >
> > This patch modifies the console code so that any pending messages are
> > automatically flushed out to the console whenever a CPU hotplug
> > operation completes successfully or aborts.
> >
> > -----------------------------------------------
> >
> > Above patch fixes only half of the problem. I mean the cpu online
> > path prints are coming on the console.
> >
> > But similar problem also exist if there are prints in the cpu offline
> > path. I got that fixed by adding below patch on top of you patch.
> >
> > diff --git a/kernel/printk.c b/kernel/printk.c
> > index d370b74..f4d7352 100644
> > --- a/kernel/printk.c
> > +++ b/kernel/printk.c
> > @@ -982,6 +982,9 @@ static int __cpuinit console_cpu_notify(struct
> > notifier_bloc
> >         switch (action) {
> >         case CPU_ONLINE:
> >         case CPU_UP_CANCELED:
> > +       case CPU_DEAD:
> > +       case CPU_DYING:
> > +       case CPU_DOWN_FAILED:
> >                 if (try_acquire_console_sem() == 0)
> >                         release_console_sem();
> >         }
> >
> >
Haven't seen any comment on the original patch and this additional fix.
Patch as such is straight forward and useful. Can you please have a look
at it, if its ok.

Regards,
Santosh
