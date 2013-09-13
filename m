From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config
 and makefile entries
Date: Fri, 13 Sep 2013 18:22:24 +0100
Message-ID: <20130913172224.GB7414@e102568-lin.cambridge.arm.com>
References: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
 <5232FCD4.2070802@free-electrons.com>
 <20130913140125.GA2062@e102568-lin.cambridge.arm.com>
 <87ppscg2yn.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59167 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab3IMRW2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 13:22:28 -0400
In-Reply-To: <87ppscg2yn.fsf@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Sep 13, 2013 at 04:23:44PM +0100, Kevin Hilman wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> 
> > On Fri, Sep 13, 2013 at 12:53:56PM +0100, Gregory CLEMENT wrote:
> >> Hi Lorenzo,
> >> 
> >> On 13/09/2013 13:32, Lorenzo Pieralisi wrote:
> >> > Following the reorganization of CPU idle drivers configurations into an ARM
> >> > specific Kconfig, the existing idle drivers Kconfig entries were renamed and
> >> > moved to the Kconfig.arm file. Makefile entries were updated accordingly.
> >> > 
> >> > This patch renames the entries in Kconfig.arm and makefile to make the newly
> >> > added big.LITTLE CPUidle driver compliant with the new naming convention.
> >> 
> >> Do you also consider to reorder the entries in alphabetic order?
> >> It should help to reduce the merge conflict.
> >
> > Sure, here it is, thanks for pointing that out.
> 
> FYI, updated patches deep inside threads are very likely to be missed.
> I saw this because I was looking for it, but would've easily been
> missed.

Got it, thanks for that.

> Could you resend a v2 with my ack so Daniel can pick up and get it
> merged for v3.12-rc?  Thanks

Done.

Thank you,
Lorenzo

