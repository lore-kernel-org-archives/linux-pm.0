From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] ARM: tango: add Suspend-to-RAM support
Date: Thu, 07 Jul 2016 16:01:55 +0200
Message-ID: <3357484.uFrtXQllNK@wuerfel>
References: <5773D3FB.4030101@sigmadesigns.com> <577A25F8.80702@sigmadesigns.com> <577E543E.80401@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60107 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbcGGN7S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2016 09:59:18 -0400
In-Reply-To: <577E543E.80401@sigmadesigns.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>, Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-pm <linux-pm@vger.kernel.org>, Mason <slash.tmp@free.fr>, Sudeep Holla <sudeep.holla@arm.com>, Robin Murphy <robin.murphy@arm.com>

On Thursday, July 7, 2016 3:08:14 PM CEST Marc Gonzalez wrote:
> Ask firmware to put RAM in self-refresh mode and power system down.
> 
>     echo mem > /sys/power/state
> 
> See Documentation/power/states.txt
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
> v3 is identical to v2 minus the RFC tag
> Olof, if still possible, please merge for v4.8

Applied to next/soc, thanks!

	Arnd

