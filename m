From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH v5 14/14] ARM: mvebu: register the cpuidle driver for the
 Armada XP SoCs
Date: Wed, 26 Mar 2014 07:30:25 -0300
Message-ID: <20140326103025.GD941@arch.cereza>
References: <1395787705-31061-1-git-send-email-gregory.clement@free-electrons.com>
 <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52141 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751137AbaCZKar (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 06:30:47 -0400
Content-Disposition: inline
In-Reply-To: <1395787705-31061-15-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-kernel@vger.kernel.org

Hi Gregory,

On Mar 25, Gregory CLEMENT wrote:
> @@ -285,4 +290,21 @@ static struct notifier_block armada_370_xp_cpu_p=
m_notifier =3D {
>  	.notifier_call =3D armada_370_xp_cpu_pm_notify,
>  };
> =20
> +int __init armada_370_xp_cpu_pm_init(void)
> +{
> +	if (!((of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-p=
msu") ||
> +				of_find_compatible_node(NULL, NULL, "marvell,armada-370-pmsu"))
> +			&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"=
)
> +			&& of_machine_is_compatible("marvell,armadaxp")))
> +		return 0;
> +

of_find_compatible_node() gets the returned node, so you should put it
after using it. How about something along this pseudo-code?

pmsu =3D of_find_compatible_node(pmsu);
coherency_fabric =3D of_find_compatible_node(coherency_fabric);

if (pmsu && coherency_fabric && of_machine_is_compatible(armadaxp)) {
	/* Do your thing ... */
}

of_node_put(pmsu);
of_node_put(coherency_fabric);

And you also gain some readability, as a side effect.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
