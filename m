From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 07/18] thermal: exynos: Modify exynos thermal code to
 use device tree for cpu cooling configuration
Date: Wed, 21 Jan 2015 11:09:30 +0100
Message-ID: <20150121110930.3254fc29@amdc2363>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
 <1421666462-7606-8-git-send-email-l.majewski@samsung.com>
 <20150121093304.7ac02a27@amdc2363>
 <CAKohpomgDrBu1Ug0uk233dSVTTDo4rixJiBEsbnJLRF3PDg0QA@mail.gmail.com>
 <20150121104719.69f20ca8@amdc2363>
 <CAKohpo=1i2Ted4jSovGZr7bVstRiUkKgZ+cJNbEkzqAh644_Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36787 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbAUKJk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 05:09:40 -0500
In-reply-to: <CAKohpo=1i2Ted4jSovGZr7bVstRiUkKgZ+cJNbEkzqAh644_Ow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Viresh,

> On 21 January 2015 at 15:17, Lukasz Majewski <l.majewski@samsung.com>
> wrote:
> > In previous versions I've only checked for cpu 0.
> >
> > If you think that it is enough to explicitly check only for cpu 0
> > and forget about above "fail safe" code (when. e.g. CPU3 has defined
> > cooling-cells), then I'm fine with it.
> 
> I don't know what bindings are you following, but cpufreq-dt's
> bindings say that it has to be present in cpu0. Anyway, this driver
> isn't for a multi-cluster system and so cpu0 should be fine.

Ok.

> 
> > As I've mention - it would be maintainer's call if one trades
> > potential regression for patch separation.
> 
> I am just asking it to split into a separate patch, not that I will
> get it through
> cpufreq. Eduardo can take it, but it should be a separate patch.

Lets do it in this way :-).

Thanks.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
