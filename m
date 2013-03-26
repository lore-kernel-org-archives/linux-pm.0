From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC patch 02/11] cpuidle / arm : a single cpuidle driver
Date: Wed, 27 Mar 2013 00:27:09 +0100
Message-ID: <1586245.ljKAkpksIj@vostro.rjw.lan>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org> <20130326111729.GQ5627@lunn.ch> <51518A22.2040801@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43894 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134Ab3CZXTp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 26 Mar 2013 19:19:45 -0400
In-Reply-To: <51518A22.2040801@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linaro-kernel@lists.linaro.org, kernel@pengutronix.de, linux-pm@vger.kernel.org, nsekhar@ti.com, magnus.damm@gmail.com, rob.herring@calxeda.com, kevin.hilman@linaro.org, horms@verge.net.au, ben-linux@fluff.org, kgene.kim@samsung.com, lenb@kernel.org, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net

On Tuesday, March 26, 2013 12:44:34 PM Daniel Lezcano wrote:
> On 03/26/2013 12:17 PM, Andrew Lunn wrote:
> >>> All above code is completly generic and I would rather create
> >>> some thing like "drivers/cpuidle/generic-idle.c" where it can
> >>> handle all the registration stuff for all arch's rather than
> >>> just ARM. There is nothing ARM specific in above code IMHO.
> >> Yes, it seems generic but it won't be.
> > It very much sounds like you are going in the wrong direction.  You
> > should be moving towards generic code, not away from generic code.
> 
> Well, I am going to the right direction but with an intermediate step :)
> 
> But indeed, I will introduce this init function in the generic code
> directly and rebase the patchset.
> 
> Rafael, is possible to apply the patches 1 - 5 ? Or shall I resend the
> subset ?

Please repost if you can, with all applicable ACKs.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
