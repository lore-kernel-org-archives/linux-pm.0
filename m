From: Simon Arlott <simon@fire.lp0.eu>
Subject: Re: [PATCH 1/2] regulator: Add brcm,bcm63xx-regulator device tree
 binding
Date: Thu, 3 Dec 2015 23:51:16 +0000
Message-ID: <5660D574.7030803@simon.arlott.org.uk>
References: <20151130121043.GX1929@sirena.org.uk>
 <565CB1CF.5040306@simon.arlott.org.uk> <20151201221615.GY1929@sirena.org.uk>
 <b7ecdc8ebcdf9582620c22b0e8a4a96d24ba67c1@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <20151202125325.GI1929@sirena.org.uk> <565F53FC.5080309@simon.arlott.org.uk>
 <20151203000631.GM1929@sirena.org.uk> <565FF9E9.1090503@simon.arlott.org.uk>
 <20151203150528.GG5727@sirena.org.uk> <5660D274.7000402@simon.arlott.org.uk>
 <20151203234548.GJ5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:56230 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbbLCXvY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Dec 2015 18:51:24 -0500
In-Reply-To: <20151203234548.GJ5727@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jogo@openwrt.org>

On 03/12/15 23:45, Mark Brown wrote:
> On Thu, Dec 03, 2015 at 11:38:28PM +0000, Simon Arlott wrote:
> 
>> #define MISC_IDDQ_CTRL_GMAC         (1<<18)
>> #define MISC_IDDQ_CTRL_WLAN_PADS    (1<<13)
>> #define MISC_IDDQ_CTRL_PCIE         (1<<12)
>> #define MISC_IDDQ_CTRL_FAP          (1<<11)
>> #define MISC_IDDQ_CTRL_VDSL_MIPS    (1<<10)
>> #define MISC_IDDQ_CTRL_VDSL_PHY     (1<<9)
>> #define MISC_IDDQ_CTRL_PERIPH       (1<<8)
>> #define MISC_IDDQ_CTRL_PCM          (1<<7)
>> #define MISC_IDDQ_CTRL_ROBOSW       (1<<6)
>> #define MISC_IDDQ_CTRL_USBD         (1<<5)
>> #define MISC_IDDQ_CTRL_USBH         (1<<4)
>> #define MISC_IDDQ_CTRL_DECT         (1<<3)
>> #define MISC_IDDQ_CTRL_MIPS         (1<<2)
>> #define MISC_IDDQ_CTRL_IPSEC        (1<<1)
>> #define MISC_IDDQ_CTRL_SAR          (1<<0)
> 
> Are you *sure* these are regulators and not power domains?  These names
> look a lot like they could be power domains.

No, I'm not sure. Some of them are may actually be regulators (the "PHY"
ones) while others are almost definitely power domains (like the "FAP"
Forwarding Assist Processor).

-- 
Simon Arlott
