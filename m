From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 1/2] thermal: sysfs: Add a new sysfs node emul_temp
Date: Mon, 21 Jan 2013 17:27:30 -0800
Message-ID: <04ce01cdf83f$a7352b00$f59f8100$@samsung.com>
References: <1357517296-31402-1-git-send-email-amit.daniel@samsung.com>
 <1358321601.2252.36.camel@rzhang1-mobl4>
 <CADGdYn4CWscQf0y6dmgYUsKB8u25BOmLYq+T64haBKpwnZ3KBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:57676 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab3AVB1t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jan 2013 20:27:49 -0500
In-reply-to: <CADGdYn4CWscQf0y6dmgYUsKB8u25BOmLYq+T64haBKpwnZ3KBQ@mail.gmail.com>
Content-language: en-us
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'amit kachhap' <amit.kachhap@gmail.com>, 'Zhang Rui' <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, jonghwa3.lee@samsung.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Durgadoss' <durgadoss.r@intel.com>

amit kachhap wrote:
> 
> Hi Rui,
> 
> Thanks for the review comments,
> On Tue, Jan 15, 2013 at 11:33 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> > Hi, Amit,
> >
> > On Sun, 2013-01-06 at 16:08 -0800, Amit Daniel Kachhap wrote:
> >> This patch adds support to set the emulated temperature method in
> >> thermal zone (sensor). After setting this feature thermal zone must
> >> report this temperature and not the actual temperature. The actual
> >> implementation of this emulated temperature is based on sensor
> >> capability or platform specific. This is useful in debugging different
> >> temperature threshold and its associated cooling action. Writing 0 on
> >> this node should disable emulation.
> >
> > Question:
> > will this bring hardware issue? Say, critical temperature reached while
> > in emulation mode?
> No emulation does cause any h/w issue.
> >
> > As this is for debug purpose, I'd prefer to have a seperate Kconfig
> > option for this feature.
> Yes agreed. Will re-submit with kconfig option.
> >
> >> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Hi Zhang,

Once Amit addresses comments from you, I think, this looks good to Exynos
SoCs. And this is _really_ needed.

Feel free to add my ack on this 1st and 2nd patches:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

