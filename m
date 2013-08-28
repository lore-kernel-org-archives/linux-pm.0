From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: TC2: CPU idle big.LITTLE driver
Date: Wed, 28 Aug 2013 11:36:24 -0700
Message-ID: <20130828183624.GH8607@quad.lixom.net>
References: <20130812153422.GA6426@e102568-lin.cambridge.arm.com>
 <20130825090848.GA12256@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46161 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab3H1ShE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Aug 2013 14:37:04 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so6632837pad.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Aug 2013 11:37:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130825090848.GA12256@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org

On Sun, Aug 25, 2013 at 10:08:48AM +0100, Lorenzo Pieralisi wrote:
> Hi Olof, Kevin,
> 
> On Mon, Aug 12, 2013 at 04:34:22PM +0100, Lorenzo Pieralisi wrote:
> > Hi Olof, Kevin,
> > 
> > please pull this patch series that provides a CPU idle driver for the vexpress
> > TC2 testchip, and it is a stepping stone towards an ARM unified CPU idle driver
> > based on the MCPM framework.
> > 
> > Series is based against this pull request from Pawel which is a strict
> > dependency and they must be merged in order:
> > 
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/190067.html
> 
> May I ask you please the status of this pull request ? It is to know if
> it is ok as it is or I have to do something on my side, thanks.

This needed a rebase on top of the latest version of the mcpm backend branch,
since it's based on an older version.

I also don't see an ack from any of the cpuidle maintainers, if you want to
take it through arm-soc you need to get them to ack it for that purpose. I see
that you got an informal "It sounds good to me" in
http://www.spinics.net/lists/arm-kernel/msg266442.html, but please be diligent
in collecting these in the future.


So, I've essentially applied the topmost 3 patches in a new branch that's based
on our version of vexpress/mcpm, and merged that in.


-Olof
