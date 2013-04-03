From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: Re: [PATCH v4 4/4] PM: Devfreq: Add Exynos5-bus devfreq driver for
 Exynos5250
Date: Wed, 03 Apr 2013 13:35:18 +0900
Message-ID: <24d701ce3024$a52d5310$ef87f930$%kim@samsung.com>
References: <17352980.268481359965953092.JavaMail.weblogic@epml13>
 <CAM4voakFpXwG7ukO5p4=NKDQZc--rcLDPU8jGag_gB=4ZdvRAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28178 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760338Ab3DCEfV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Apr 2013 00:35:21 -0400
In-reply-to: <CAM4voakFpXwG7ukO5p4=NKDQZc--rcLDPU8jGag_gB=4ZdvRAA@mail.gmail.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Abhilash Kesavan' <kesavan.abhilash@gmail.com>, myungjoo.ham@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, =?ks_c_5601-1987?B?J7nasOa5zic=?= <kyungmin.park@samsung.com>, rjw@sisk.pl, =?ks_c_5601-1987?B?J8PWwb7Iryc=?= <jhbird.choi@samsung.com>

Abhilash Kesavan wrote:

> >> > One concern is that I cannot apply Patch 1/4 directly as the .dts
> file isn't
> >> > available to me.
> >> > Do you intend to apply that patch to another tree and apply the other
> three
> >> > to devfreq tree?
> >> I have been merging the devfreq tree into Kgene's tree for my testing.
> I am not
> >> sure how this should get in, any suggestions ?
> >
> > I'd suggest to send Patch 1/4 to Kgene and get it applied first if that
> patch is preliminary to the other patchset. If it is not, we can go
> seperated and independently.

> Thanks for the suggestion. Kgene is a recipient on patches 1 and 2. I
> am hoping he'll pick it up soon. However, the devfreq patches are not
> dependent on them and can be applied independently.

Just note, as I commented, arch side patches should be re-worked and
current devfreq in mainline won't cause any problems without the arch side.
And I discussed with Abhilash about that, he will finish arch side re-
posting next time.

Thanks.

- Kukjin

