From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe drivers
Date: Thu, 04 Dec 2014 00:27:44 +0100
Message-ID: <10370402.U4mHofmuxH@vostro.rjw.lan>
References: <1417551543-15009-1-git-send-email-jsarha@ti.com> <3160452.2AXUHE51NB@vostro.rjw.lan> <547EBFA7.2060005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59817 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751877AbaLCXGV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 18:06:21 -0500
In-Reply-To: <547EBFA7.2060005@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com

On Wednesday, December 03, 2014 09:45:43 AM Tomi Valkeinen wrote:
> 
> --pNvmjWc6tlSGwtKdGsBmAsBWQX9kn2ndC
> Content-Type: text/plain; charset=utf-8
> Content-Transfer-Encoding: quoted-printable
> 
> On 03/12/14 01:11, Rafael J. Wysocki wrote:
> 
> > Second, what if the parent sets its irq_safe after the child does?
> 
> Then the behavior becomes the same as it is currently.
> 
> But isn't the probe of the parent always ran before the child? And the
> only sane place (?) to set irq_safe is in probe, after
> pm_runtime_enable. If so, it should never happen in practice that the
> parent's irq_safe is called after the child's.

Probably not, but that's an additional assumption that we don't have to make
today.

> >> If the thing I am doing somehow fundamentally flawed, I 	apologize.=20
> >> However, this was an RFC patch after all and the problem I am trying t=
> o=20
> >> solve is real.
> >=20
> > Well, the whole irq_safe concept if somewhat rough and fragile (for exa=
> mple,
> > it doesn't play well with bus type callbacks that may sleep) and I'm no=
> t
> 
> I don't know enough of the PM to understand what you mean with above,
> but isn't it a bug to set a device irq-safe if it may need sleeping
> callbacks? Or do you mean that the device driver may not know if such
> sleeping callbacks happen or not?

The latter.

For example, if the device lands in the ACPI PM domain, irq_safe should not
be set for it, but whether or not that happens depends on the configuration
of the system.

> > sure if making it more fragile is a good idea.
> 
> Is there something we can do to fix it? Conceptually I don't see any
> issues with it, but I'm probably only looking at it from the platform
> device point of view.

I'm sure it is fixable, but I'm not sure what's the best way to fix it.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
