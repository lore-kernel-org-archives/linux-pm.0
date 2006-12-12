From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 1/3] support powermac G5 CPU hotplug
Date: Tue, 12 Dec 2006 13:09:16 +0000
Message-ID: <20061212130916.GB5190@ucw.cz>
References: <20061211230208.526233000@sipsolutions.net>>
	<20061211230754.380263000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20061211230754.380263000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org, Michael Hanselmann <linux-kernel@hansmi.ch>, Torrance <torrance123@gmail.com>, Michael Buesch <mb@bu3sch.de>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with interrupts hard-disabled, to wake
> them up again we kick them just like when bringing them up.
> =

> Maybe there's some way to actually turn off those CPUs even more?
> =

> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> =



> --- linux-2.6-git.orig/arch/powerpc/kernel/smp.c	2006-12-11 23:34:47.6937=
16759 +0100
> +++ linux-2.6-git/arch/powerpc/kernel/smp.c	2006-12-11 23:37:55.017716759=
 +0100
> @@ -558,6 +558,9 @@ int __devinit start_secondary(void *unus
>  =

>  	local_irq_enable();
>  =

> +	/* who knows what context the processor might have died in... */
> +	task_thread_info(paca[cpu].__current)->preempt_count =3D 0;
> +

?? Context for downing cpu should better be well-defined. Just do this
in cpu_die if it is really required.
							Pavel
-- =

Thanks for all the (sleeping) penguins.
