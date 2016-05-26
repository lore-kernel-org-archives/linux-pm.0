From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR()
 check
Date: Thu, 26 May 2016 16:15:17 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1605261614570.3786@hadrien>
References: <CGME20160526064612epcas1p4cb0d45fa11deafea51fa84974132afed@epcas1p4.samsung.com> <20160526064541.GA6680@mwanda> <5746AFE3.6030606@samsung.com> <20160526115629.GD10957@mwanda> <CAGTfZH2rqD_91D_Vt8EgXDO4ACJ-OKD5Os9RA4Mk7hg0EHzfcg@mail.gmail.com>
 <20160526135600.GE10957@mwanda> <CAGTfZH31_OOSg-kJ1tp8pCv55nWZbcd6dG2zXrtov8BGh0udcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49561 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753813AbcEZOPV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2016 10:15:21 -0400
In-Reply-To: <CAGTfZH31_OOSg-kJ1tp8pCv55nWZbcd6dG2zXrtov8BGh0udcw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cw00.choi@samsung.com
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <julia.lawall@lip6.fr>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org



On Thu, 26 May 2016, Chanwoo Choi wrote:

> On Thu, May 26, 2016 at 10:56 PM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
> > On Thu, May 26, 2016 at 10:46:26PM +0900, Chanwoo Choi wrote:
> >> On Thu, May 26, 2016 at 8:56 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >> > On Thu, May 26, 2016 at 05:12:19PM +0900, Chanwoo Choi wrote:
> >> >> I don't recommend that you mention the name of engineer on patch description
> >> >> directly.
> >> >
> >> > This really is normal.  I've been mentioned over 100 times in commit
> >> > messages like 7051924f771 (xillybus: Move out of staging).
> >>
> >> I'm still reluctant to use the name on description.
> >
> > I understand that but I don't understand why, though.  Anyway, aren't
> > forwarding this to someone?  You can change it to say whatever you want.
>
> Because if the name without any unique email address is included in
> the description,

I sent a Reviewed-by, so this issue is solved.

julia

> I think that it is not appropriate. Always, the information should
> include the email address.
> So, I just prefer to use the Suggested-by or the different kind of tag
> with [id: explanation].
>
> But, I'll stop about it because it is not critical issue.
> It depend on what is the preferred method to add the information.
>
> Thanks,
> Chanwoo Choi
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
