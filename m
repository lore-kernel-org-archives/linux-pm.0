From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/8] Fix issues and factorize arm/arm64 capacity
 information code
Date: Thu, 11 May 2017 10:59:52 +0200
Message-ID: <20170511085952.GA6934@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170511084830.rn32pvi6weej2cna@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:56300 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbdEKJAB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2017 05:00:01 -0400
Content-Disposition: inline
In-Reply-To: <20170511084830.rn32pvi6weej2cna@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux@arm.linux.org.uk, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, linux-kernel@vger.kernel.org

On Thu, May 11, 2017 at 09:48:30AM +0100, Juri Lelli wrote:
> Hi Greg,
> 
> I'm not sure what your plans are with this set. Are we targeting 4.12?
> 
> IMHO, if possible, it would be good to have this refactoring in now, so
> that we can base further development on it for the next cycle.

It's way too late for new features that have not been in linux-next for
a few weeks, to get merged into 4.12-rc1, sorry.  I'll review this
patchset after -rc1 is out, and I get a chance to catch up on pending
patches.

thanks,

greg k-h
