From: jacob pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 3/3] PM: Introduce Intel PowerClamp Driver
Date: Wed, 16 Jan 2013 09:09:50 -0800
Message-ID: <20130116090950.00007e90@unknown>
References: <1357297965-17839-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1357297965-17839-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<1358338729.2252.53.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4690 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757135Ab3APRJv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jan 2013 12:09:51 -0500
In-Reply-To: <1358338729.2252.53.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Joe Perches <joe@perches.com>, Rob Landley <rob@landley.net>, Arjan van de Ven <arjan@linux.intel.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Wed, 16 Jan 2013 20:18:49 +0800
Zhang Rui <rui.zhang@intel.com> wrote:

> > +#include <linux/nmi.h>
> > + =20
> drivers/thermal/intel_powerclamp.c: In function =E2=80=98clamp_thread=
=E2=80=99:
> drivers/thermal/intel_powerclamp.c:435:4: error: implicit declaration
> of function =E2=80=98local_touch_nmi=E2=80=99 [-Werror=3Dimplicit-fun=
ction-declaration]
>=20
> changing to=20
> #include <asm/nmi.h>
> fixes the problem.
good catch. I missed this in my .config tests. I had
CONFIG_HARDLOCKUP_DETECTOR on so the problem was not shown. I will send
you an update.

Thanks,

Jacob
