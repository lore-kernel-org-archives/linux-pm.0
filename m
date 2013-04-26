From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ARM: s3c64xx: cpuidle: use init/exit common routine
Date: Fri, 26 Apr 2013 14:03:56 +0200
Message-ID: <2024174.Hoa4RbDIF3@vostro.rjw.lan>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org> <5178F8E0.6010606@linaro.org> <51794C35.6070400@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44945 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab3DZLzu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Apr 2013 07:55:50 -0400
In-Reply-To: <51794C35.6070400@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, lethal@linux-sh.org, ben-linux@fluff.org, horms+renesas@verge.net.au, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, April 26, 2013 12:31:01 AM Kukjin Kim wrote:
> On 04/25/13 18:35, Daniel Lezcano wrote:
> > On 04/23/2013 04:41 PM, Daniel Lezcano wrote:
> >> Remove the duplicated code and use the cpuidle common code for initialization.
> >>
> >> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
> >> ---
> >
> > Hi Kim and Ben,
> >
> > It is the last patch in the series which was not acked-by.
> > Rafael is willing to take it in its tree if you ack it.
> >
> > Are you ok if this patch ?
> >
> Looks OK to me, please go ahead with my ack if you want:
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Applied.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
