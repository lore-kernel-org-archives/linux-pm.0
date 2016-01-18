From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Mon, 18 Jan 2016 11:25:41 -0800
Message-ID: <569D3C35.5070703@linaro.org>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org> <20160118151316.GD7159@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34552 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932282AbcARTZo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jan 2016 14:25:44 -0500
Received: by mail-pa0-f48.google.com with SMTP id uo6so424094778pac.1
        for <linux-pm@vger.kernel.org>; Mon, 18 Jan 2016 11:25:44 -0800 (PST)
In-Reply-To: <20160118151316.GD7159@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org

On 01/18/2016 07:13 AM, Juri Lelli wrote:
>> DT solves these issues and would be the perfect place for this - we are
>> > defining the compute capacity of a CPU which is a property of the
>> > hardware. However there are a couple things forcing us to compromise.
>> > One is that the amount and detail of information required to adequately
>> > capture the computational abilities of a CPU across all possible
>> > workloads seem onerous to collect and enumerate. The second is that even
>> > if we were willing to undertake that, CPU vendors probably won't be
>> > forthcoming with that information.
>> > 
>
> You mean because they won't publish performance data of their hw?

More specific things like IPC and other architectural details that could
comprise a precise physical definition of a CPU that would meet the
ideal goals of a device tree definition.

> But we already use per platform normalized values (as you are proposing
> below). So that a platform to platform comparison doesn't make sense.

Yeah I'm just advocating for that strategy here.

cheers,
Steve
