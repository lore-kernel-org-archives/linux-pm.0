From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another
 node for OPP
Date: Wed, 31 Jul 2013 15:51:15 -0600
Message-ID: <51F986D3.4060501@wwwdotorg.org>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com> <51F80750.8030701@wwwdotorg.org> <51F826A0.2000109@ti.com> <51F8F17B.1020304@arm.com> <51F9234A.6010501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <51F9234A.6010501@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 07/31/2013 08:46 AM, Nishanth Menon wrote:
...
> Let me try to explain since SoCs such as OMAP/AM family dont make life
> trivial :)..
> 
> An legacy example[1][2]
> 
> SoC DM explains that the chip is capable of X opps:
> opp1, 2 - for all devices
> opp1,2, 3 - if efuse bit X@y is set
> opp1,2,3,4 - if efuse bit X@y is set AND Board design meets SoC vendors
> requirements (including additional features A, B is enabled).

Hopefully the text "board design meets SoC vendors requirements" means
something like "the board has a big fan capable of dissipating a lot of
heat" and not "the board manufacturer paid us a lot of money to license
the 'go faster' feature". The former could well be suitable to represent
in DT, the latter not.
