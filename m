From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH RFC 3/3] ARM: dts: enable power subsystem for i.MX28
Date: Fri, 21 Nov 2014 11:55:29 -0200
Message-ID: <CAOMZO5ALfkFzA7arhx7+gkS8R_eCjM3=2HnaVn2sAhniEL_1ng@mail.gmail.com>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
	<1416514477-19190-4-git-send-email-stefan.wahren@i2se.com>
	<CAOMZO5AWOs8ODsru+ySsLb=R4ezDL19nK_z0zAXdbrDfPT8KhA@mail.gmail.com>
	<1167895673.64469.1416524223868.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:59730 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757904AbaKUNza (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 08:55:30 -0500
In-Reply-To: <1167895673.64469.1416524223868.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Nov 20, 2014 at 8:57 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

>> Or ''fsl,mxs-power' could be used for both?
>
> I think that would be a bad idea. I can't believe that all PMU register of
> i.MX23 and i.MX28 are identical. So in the future we will have to distinguish
> between them. It's better to do it now like most of the mxs driver does.


Ok, sounds good then.
