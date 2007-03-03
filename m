From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] KVM: T60 resume fix
Date: Sat, 3 Mar 2007 03:57:42 -0800
Message-ID: <20070303035742.72eed3df.akpm@linux-foundation.org>
References: <20070227103407.GA17819@elte.hu> <20070227105922.GD2250@kernel.dk>
	<20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu>
	<20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu>
	<Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org>
	<20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu>
	<20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
	<45E93012.4000100@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <45E93012.4000100@qumranet.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Avi Kivity <avi@qumranet.com>
Cc: Jens Axboe <jens.axboe@oracle.com>, Daniel Walker <dwalker@mvista.com>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Pavel@smtp.osdl.org, linux-pm@lists.osdl.org, List <linux-kernel@vger.kernel.org>, Len@smtp.osdl.org, Adrian Bunk <bunk@stusta.de>, Machek <pavel@ucw.cz>, Linux@smtp.osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, 03 Mar 2007 10:21:38 +0200 Avi Kivity <avi@qumranet.com> wrote:

> Ingo Molnar wrote:
> > Subject: [patch] KVM: T60 resume fix
> > From: Ingo Molnar <mingo@elte.hu>
> >
> > my T60 laptop does not resume correctly due to KVM attempting to send a=
n =

> > IPI to a CPU that might be down (or not up yet). (Doing so also trigger=
s =

> > the send_IPI_mask_bitmask() warning in arch/i386/kernel/smp.c, line =

> > 732.)
> >
> > with this fix applied my laptop does not hang during resume.
> >
> > [ KVM will have to disable/enable virtualization on the CPU itself that
> >   goes down / comes up, not via an IPI sent from the requesting CPU. ]
> >
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> > ---
> >  drivers/kvm/kvm_main.c |    6 ------
> >  1 file changed, 6 deletions(-)
> >
> > Index: linux/drivers/kvm/kvm_main.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux.orig/drivers/kvm/kvm_main.c
> > +++ linux/drivers/kvm/kvm_main.c
> > @@ -2083,12 +2083,6 @@ static int kvm_cpu_hotplug(struct notifi
> >  	case CPU_DEAD:
> >  	case CPU_UP_CANCELED:
> >  		decache_vcpus_on_cpu(cpu);
> > -		smp_call_function_single(cpu, kvm_arch_ops->hardware_disable,
> > -					 NULL, 0, 1);
> > -		break;
> > -	case CPU_UP_PREPARE:
> > -		smp_call_function_single(cpu, kvm_arch_ops->hardware_enable,
> > -					 NULL, 0, 1);
> >  		break;
> >  	}
> >  	return NOTIFY_OK;
> >   =

> =

> That is already CPU_ONLINE in my tree

I noticed ;)

So this mean that Ingo's bug should already be fixed there.  And in rc2-mm1.

> (and in the pull request sent to =

> Linus a couple of days ago).

Resend, please.
