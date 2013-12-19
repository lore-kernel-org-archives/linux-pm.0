From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V3 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
Date: Thu, 19 Dec 2013 00:30:15 -0200
Message-ID: <CAOMZO5DzKbOovk=k0ryWsdUzwdx4y_3JSytNY7LiWhhq3AhtHw@mail.gmail.com>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
	<CAOMZO5DCGOkUtWmEok-uEFsUpGLF+93Vhm9XFs02yH9Z+eV0uQ@mail.gmail.com>
	<ADD49D66-30FE-4D87-88D6-F8AE07376F3F@freescale.com>
	<112fab48e08c43749c0797328b1f1ee1@DM2PR03MB317.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34747 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab3LSCaQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 21:30:16 -0500
In-Reply-To: <112fab48e08c43749c0797328b1f1ee1@DM2PR03MB317.namprd03.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Anson.Huang@freescale.com" <Anson.Huang@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, Dec 19, 2013 at 12:13 AM, Anson.Huang@freescale.com
<Anson.Huang@freescale.com> wrote:
> After re-consideration, I think below should be better:
> arm-supply: regulator node supplying arm.
> pu-supply: regulator node supplying pu.
> soc-supply: regulator node supplying soc.

Yes, this looks better.

Regards,

Fabio Estevam
