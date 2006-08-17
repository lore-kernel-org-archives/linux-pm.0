From: Ikhwan Lee <ikhwan.lee@samsung.com>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Thu, 17 Aug 2006 10:46:10 +0900
Message-ID: <006001c6c19e$ead15a20$4686190c@dsn.sec.samsung.com>
References: <Pine.LNX.4.44L0.0608161127120.7924-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Thanks for your comment.

> > Suppose we have a SoC with an on-chip multimedia codec. The codec can
either
> > be clock-gated or power-gated, and it shares its power domain with a
> > neighboring IP, say a 3D engine. Clock gating can be done by the driver
> > since the clock can be controlled separately. However, the codec driver
can
> > never perform power-gating since it does not know if the 3D engine is
active
> > or not. We would prefer a centralized device power manager in this case.
> > This is a common case for state-of-the-art mobile handsets such as a DMB
> > phone.
>
> In which case a centralized power manager would handle things.  But
> there's no reason that power manager couldn't be part of the kernel's
> infrastructure.  The individual device drivers would tell it when they
> need power, and it would gate off the power when nobody needs any.  In
> this case no userspace API is required.  It's merely a platform-level
> design issue.

We can have the device power manager in the kernel and let the platform
designers hardcode the rules specific to their platform. It is easier to
implement and we can use that scheme right away.

In the future however, I think it is more clear to have a "power/voltage
domain framework, and an extensible framework for system-wide operating (and
non-operating sleep) states," quoting from what David said in his response
to my message.

Ikhwan
