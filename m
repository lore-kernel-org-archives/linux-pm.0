From: Frans Pop <elendil@planet.nl>
Subject: Re: [RFC][PATCH] PM: Warn if interrupts are enabled
	during suspend-resume of sysdevs
Date: Sun, 5 Apr 2009 00:03:31 +0200
Message-ID: <200904050003.33609.elendil__29279.5365829535$1238882835$gmane$org@planet.nl>
References: <200904042323.19866.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-To: <200904042323.19866.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> @@ -377,6 +381,9 @@ int sysdev_suspend(pm_message_t state)
> =A0=A0=A0=A0=A0=A0=A0=A0if (ret)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> =A0
> +=A0=A0=A0=A0=A0=A0=A0WARN_ONCE(!irqs_disabled(),
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"Interrupts enabled while s=
uspending system devices");
> +

Missing \n ?

> @@ -452,6 +465,9 @@ int sysdev_resume(void)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0struct sysdev_class *cls;
> =A0
> +=A0=A0=A0=A0=A0=A0=A0WARN_ONCE(!irqs_disabled(),
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"Interrupts enabled while r=
esuming system devices");
> +

Again.

Cheers,
FJP
