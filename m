From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v5 5/5] PM / devfreq: drop comment about thermal setting
 max_freq
Date: Thu, 27 Aug 2015 13:52:43 +0100
Message-ID: <20150827125243.GF5653@e104805>
References: <1457392753.243291440673119677.JavaMail.weblogic@ep2mlwas06c>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:57684 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753627AbbH0Mw4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2015 08:52:56 -0400
Content-Disposition: inline
In-Reply-To: <1457392753.243291440673119677.JavaMail.weblogic@ep2mlwas06c>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>, "rufus.hamade@imgtec.com" <rufus.hamade@imgtec.com>, "edubezval@gmail.com" <edubezval@gmail.com>

On Thu, Aug 27, 2015 at 11:58:39AM +0100, MyungJoo Ham wrote:
> > The thermal infrastructure should use the devfreq cooling device, which
> > uses the OPP library to disable OPPs as necessary.
> > 
> > Fix a couple of typos in the same comment while we are at it.
> > 
> > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> 
> Your patches (1/5, 5/5) are already merged in https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git
> and will be "pull-request"ed with other patches later.
> 
> Do your "V5" patches have updates from last patches?

No they haven't.  I should have based this series on top of your
branch.  I'll do that in the future.

Sorry for that,
Javi
