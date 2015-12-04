From: "Simon Arlott" <simon@fire.lp0.eu>
Subject: Re: [PATCH 1/2] regulator: Add brcm,bcm63xx-regulator device tree
 binding
Date: Fri, 4 Dec 2015 12:26:58 -0000
Message-ID: <d7609dc97ddd988876e4efefaec2c18a4b7161bd@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
References: <20151201221615.GY1929@sirena.org.uk>
    <b7ecdc8ebcdf9582620c22b0e8a4a96d24ba67c1@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
    <20151202125325.GI1929@sirena.org.uk>
    <565F53FC.5080309@simon.arlott.org.uk>
    <20151203000631.GM1929@sirena.org.uk>
    <565FF9E9.1090503@simon.arlott.org.uk>
    <20151203150528.GG5727@sirena.org.uk>
    <5660D274.7000402@simon.arlott.org.uk>
    <20151203234548.GJ5727@sirena.org.uk>
    <5660D574.7030803@simon.arlott.org.uk>
    <20151204110018.GU26072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151204110018.GU26072@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jogo@openwrt.org>
List-Id: linux-pm@vger.kernel.org

On Fri, December 4, 2015 11:00, Mark Brown wrote:
> On Thu, Dec 03, 2015 at 11:51:16PM +0000, Simon Arlott wrote:
>> On 03/12/15 23:45, Mark Brown wrote:
>
>> > Are you *sure* these are regulators and not power domains?  These names
>> > look a lot like they could be power domains.
>
>> No, I'm not sure. Some of them are may actually be regulators (the "PHY"
>> ones) while others are almost definitely power domains (like the "FAP"
>> Forwarding Assist Processor).
>
> OK, so the power domains should be being represented and managed as such
> rather than using regulators - it's a better fit (doing things like
> support atomic context) and it also sidesteps this.  For the things that
> you say are clearly regulators should we have more information about
> those?

I'd prefer to handle them all as power domains since it fits better. Even
if some of them are regulators there's no extra control or status interface
and they're used like power domains to disable unused functionality.

-- 
Simon Arlott
