From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] PM / devfreq: fix Kconfig indent style
Date: Fri, 26 Aug 2016 10:45:22 +0800
Message-ID: <20160826104522.488dc6ba@xhacker>
References: <CGME20160825121110epcas1p4e388645a033341ce2a85e39115e9bb57@epcas1p4.samsung.com>
        <20160825120614.511-1-jszhang@marvell.com>
        <1824322979.63358.1472179325464.JavaMail.weblogic@ep2ml101a>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60034 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752559AbcHZCt4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Aug 2016 22:49:56 -0400
In-Reply-To: <1824322979.63358.1472179325464.JavaMail.weblogic@ep2ml101a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi MyungJoo, Chanwoo,

On Fri, 26 Aug 2016 02:42:05 +0000 MyungJoo Ham wrote:

> > Hi Jisheng,
> > 
> > Looks good to me. But, you need to rebase it
> > on latest devfreq.git because the related patch
> > is already merged[1] for COMPILE_TEST.
> > So, the merge conflict may happen.
> > 
> > [1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit/?h=for-rc&id=c2f9bf4e49c12a3d9fcbee2cd48c9f5d769d8cc8
> > 
> > If you resend it with rebase on devfreq.git,
> > Feel free to add my reviewed-by tag:
> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>  
> 
> Don't worry.
> 
> It is already rebased and queued up at
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-rc
> 

thanks so much!
