From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v7 REPOST 0/9] CPUs capacity information for heterogeneous
 systems
Date: Mon, 17 Oct 2016 17:39:22 +0100
Message-ID: <66c7bbfd-ec3f-ff43-9a06-ae644d9ee9d9@arm.com>
References: <20161017154650.18779-1-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753126AbcJQQj0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Oct 2016 12:39:26 -0400
In-Reply-To: <20161017154650.18779-1-juri.lelli@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org



On 17/10/16 16:46, Juri Lelli wrote:
> Hi all,
>
> this is a repost of version 7 of "CPUs capacity information for heterogeneous
> systems" patchset [1] (please refer to previous postings to get some context).
> I only added Juno r1 dts, as discussed off-line with Sudeep meanwhile (no code
> changes at all, so that's why I'm saying this is a repost).
>
> I'm reposting as I didn't receive any comment (despite pinging people) on the
> original v7 posting (apart from Vincent acking patches 2 and 4, thanks!). I
> then waited until merge window for 4.9 was closed.
>
> I'm thus now assuming that everybody is OK with the patches and that they can
> be queued for 4.10 (we certainly need this plumbing at this point). Please
> speak if my assumption is wrong (and provide feedback! :).
> Otherwise I'm going to:
>
>  - use Russell's patching system for patches 2 and 8
>  - ask Sudeep to pull patches 3,5,6 and 7

I have applied 3 to [1] and 5,6,7 to [2]. Let me know if things change
and you want me to drop them with some cosmetic subject change and
updated changelog.

-- 
Regards,
Sudeep

[1] git.kernel.org/sudeep.holla/linux/h/vexpress-dt/for-next
[2] git.kernel.org/sudeep.holla/linux/h/juno-dt/for-next
