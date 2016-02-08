From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 4/6] arm64: Enable dynamic CPU capacity initialization
Date: Mon, 8 Feb 2016 13:41:25 +0000
Message-ID: <56B89B05.4090207@arm.com>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-5-git-send-email-juri.lelli@arm.com> <56B889F7.306@arm.com>
 <20160208131320.GA7265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60839 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbcBHNl3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 8 Feb 2016 08:41:29 -0500
In-Reply-To: <20160208131320.GA7265@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com

On 08/02/16 13:13, Mark Brown wrote:
> On Mon, Feb 08, 2016 at 12:28:39PM +0000, Dietmar Eggemann wrote:
>> On 03/02/16 11:59, Juri Lelli wrote:
> 
>>> +bool arch_wants_init_cpu_capacity(void)
>>> +{
>>> +	return true;
> 
>> Isn't this a little bit too simple? Not every ARM/ARM64 platform is a
>> heterogeneous one.
> 
> Does it matter?  Is there any problem with doing the callibration and
> having it say that all the CPUs performs very similarly?  My
> understanding was that this was simply saying it was worth checking to
> see if there was some asymmetry.
> 

No, the calibration would work on any platform. I can see your point,
you want to have this feature not depend on dt.

