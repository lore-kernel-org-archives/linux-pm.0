From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
Date: Thu, 20 Feb 2014 13:41:20 +0000
Message-ID: <20140220134118.GT25765@pburton-linux.le.imgtec.org>
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com>
 <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
 <53060496.6000303@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:46471 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218AbaBTNlW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Feb 2014 08:41:22 -0500
Content-Disposition: inline
In-Reply-To: <53060496.6000303@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
> On 01/15/2014 02:55 PM, Paul Burton wrote:
> >Declaring this allows drivers which need to initialise each struct
> >cpuidle_device at initialisation time to make use of the structures
> >already defined in cpuidle.c, rather than having to wastefully defin=
e
> >their own.
> >
> >Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> >Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> >Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> >Cc: linux-pm@vger.kernel.org
> >---
> >  include/linux/cpuidle.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> >diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> >index 50fcbb0..bab4f33 100644
> >--- a/include/linux/cpuidle.h
> >+++ b/include/linux/cpuidle.h
> >@@ -84,6 +84,7 @@ struct cpuidle_device {
> >  };
> >
> >  DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> >+DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>=20
>=20
> Nak. When a device is registered, it is assigned to the cpuidle_devic=
es
> pointer and the backend driver should use it.
>=20

Yes, but then if the driver needs to initialise the coupled_cpus mask
then it cannot do so until after the device has been registered. During
registration the cpuidle_coupled_register_device will then see the empt=
y
coupled_cpus mask & do nothing. The only other ways around this would b=
e
for the driver to define its own per-cpu struct cpuidle_device (which a=
s
I state in the commit message seems wasteful when cpuidle already
defined them), or for cpuidle_coupled_register_device to be called late=
r
after the driver had a chance to modify devices via the cpuidle_devices
pointers.

Paul

>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20

