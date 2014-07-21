From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 12/17] cpuidle: mvebu: make the cpuidle driver capable
 of handling multiple SoCs
Date: Mon, 21 Jul 2014 14:09:17 +0200
Message-ID: <20140721140917.16e71558@free-electrons.com>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<52019695.n2AjkGEsJ7@wuerfel>
	<20140721133534.3415e425@free-electrons.com>
	<5251405.VTrfDi1rj5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52754 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754815AbaGUMJU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jul 2014 08:09:20 -0400
In-Reply-To: <5251405.VTrfDi1rj5@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Dear Arnd Bergmann,

On Mon, 21 Jul 2014 14:00:22 +0200, Arnd Bergmann wrote:

> I don't know, it really depends on what the differences are between
> the SoCs, and I haven't looked at them.
> 
> Using the compatible strings would make it work best if you have one
> driver per variant, and then share some common code, as opposed to
> having one shared driver with a number of exceptions.
> 
> If the differences are just a few parameters, it might be better
> to encode those parameters in DT properties instead.

The differences are in the cpuidle states that are supported, see
patches "cpuidle: mvebu: add Armada 370 support" and "cpuidle: mvebu:
add Armada 38x support" in the series.

I honestly believe that since cpuidle functionality is not described in
the Device Tree and therefore probed using a statically defined
platform_device, the good way to pass these informations is to simply
use platform_data.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
