From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/4] soc: dove: Let genpd deal with disabling of unused
 PM domains
Date: Thu, 15 Oct 2015 08:59:54 +0100
Message-ID: <20151015075954.GU32532@n2100.arm.linux.org.uk>
References: <1444134450-17895-1-git-send-email-ulf.hansson@linaro.org>
 <87a8rk36nw.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:37063 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbbJOIAO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 04:00:14 -0400
Content-Disposition: inline
In-Reply-To: <87a8rk36nw.fsf@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Andrew Lunn <andrew@lunn.ch>

On Thu, Oct 15, 2015 at 09:57:55AM +0200, Gregory CLEMENT wrote:
> Hi Ulf and Sebastian,
>  
>  On mar., oct. 06 2015, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> 
> > Genpd tries from a late_initcall to disable unused PM domains, which makes
> > it unnecessary to also manage this from any earlier phase when for example
> > initializing a genpd.
> 
> I can't test it and I didn't follow this part.
> 
> Sebastian could you have a look on this patch?

I'm probably the only one who can test the patch at the moment, having
the vmeta and etnaviv drivers merged in my tree which make use of this.
However, as ever, that tree is based on 4.2 and not 4.3-rc, so I'm
planning to test this _after_ 4.3 is released.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
