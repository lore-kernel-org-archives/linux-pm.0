From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
Subject: Re: [BUG] Strange 1-second pauses during Resume-from-RAM
Date: Sat, 1 Dec 2007 21:47:47 +0100
Message-ID: <20071201204747.GA6458__23902.7358162732$1196542477$gmane$org@lazybastard.org>
References: <473C825E.3030307@rtr.ca> <20071115193424.GA31691@elte.hu>
	<20071115193612.GA751@elte.hu>
	<20071130125628.GA30773@lazybastard.org>
	<20071130133546.GB29679@elte.hu> <20071130134312.GA32273@elte.hu>
	<20071130183510.GA1570@lazybastard.org>
	<20071130184625.GB9928@elte.hu>
	<20071201151650.GA5031@lazybastard.org>
	<20071201183256.GA14052@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071201183256.GA14052@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: len.brown@intel.com, =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>, linux-kernel@vger.kernel.org, Mark Lord <liml@rtr.ca>, Mark Lord <lkml@rtr.ca>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 1 December 2007 19:32:56 +0100, Ingo Molnar wrote:
> * J=C3=B6rn Engel <joern@logfs.org> wrote:
>=20
> > I have to change my qemu setup a little to see the top of those=20
> > dumps...
>=20
> btw., if you start qemu like this:
>=20
> qemu -cdrom ./cdrom.iso -hda ./hda.img -boot c -full-screen -kernel=20
> ~/bzImage -append "root=3D/dev/hda1 earlyprintk=3Dserial,ttyS0,9600=20
> console=3Dtty console=3DttyS0,9600 enforcing=3D0 debug"
>=20
> you'll get the inner kernel's serial console log to qemu's standard=20
> output. Pretty useful for capturing kernel crashes.

Almost.  "-serial stdio" was missing.  Much better now.

stopped custom tracer.
BUG: spinlock recursion on CPU#0, sh/953
 lock: c030f280, .magic: dead4ead, .owner: sh/953, .owner_cpu: 0
Pid: 953, comm: sh Not tainted 2.6.24-rc3-ge1cca7e8-dirty #2
 [<c0103a04>] show_trace_log_lvl+0x35/0x54
 [<c010450a>] show_trace+0x2c/0x2e
 [<c0104e6d>] dump_stack+0x84/0x8a
 [<c01ded7c>] spin_bug+0xa7/0xae
 [<c01def14>] _raw_spin_lock+0x45/0xfa
 [<c02a02b1>] _spin_lock_irqsave+0x68/0x7a
 [<c01087e7>] pit_read+0x14/0x99
 [<c0130ee9>] get_monotonic_cycles+0xf/0x2d
 [<c013c0ef>] now+0x2a/0x7c
 [<c013c33b>] ____trace+0x4d/0x1e8
 [<c013dbf3>] __mcount+0x95/0xa6
 [<c010d35c>] mcount+0x14/0x18
 [<c0135a44>] lock_acquired+0xe/0x1d7
 [<c02a02b9>] _spin_lock_irqsave+0x70/0x7a
 [<c01087e7>] pit_read+0x14/0x99
 [<c0130791>] update_wall_time+0x23/0x692
 [<c0121756>] do_timer+0x24/0xb1
 [<c01331fe>] tick_periodic+0x49/0x84
 [<c013325b>] tick_handle_periodic+0x22/0x73
 [<c0106315>] timer_interrupt+0x4f/0x56
 [<c013e2c7>] handle_IRQ_event+0x24/0x4f
 [<c013f44a>] handle_edge_irq+0xb8/0x125
 [<c01054ee>] do_IRQ+0x89/0xa3
 [<c01033df>] common_interrupt+0x23/0x28
 [<c015d924>] vfs_write+0xa6/0x14c
 [<c015df6e>] sys_write+0x4c/0x70
 [<c0102a1f>] syscall_call+0x7/0xb
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I assume you have the latency tracer working.  If you could send me your
config, I could do a manual config-bisect and see which part of mine
causes the problem.

J=C3=B6rn

--=20
Admonish your friends privately, but praise them openly.
-- Publilius Syrus
