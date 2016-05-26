From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR()
 check
Date: Thu, 26 May 2016 15:54:43 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1605261548390.3786@hadrien>
References: <CGME20160526064612epcas1p4cb0d45fa11deafea51fa84974132afed@epcas1p4.samsung.com> <20160526064541.GA6680@mwanda> <5746AFE3.6030606@samsung.com> <20160526115629.GD10957@mwanda> <CAGTfZH2rqD_91D_Vt8EgXDO4ACJ-OKD5Os9RA4Mk7hg0EHzfcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <CAGTfZH2rqD_91D_Vt8EgXDO4ACJ-OKD5Os9RA4Mk7hg0EHzfcg@mail.gmail.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Julia Lawall <julia.lawall@lip6.fr>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On Thu, 26 May 2016, Chanwoo Choi wrote:

> On Thu, May 26, 2016 at 8:56 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > On Thu, May 26, 2016 at 05:12:19PM +0900, Chanwoo Choi wrote:
> >> I don't recommend that you mention the name of engineer on patch description
> >> directly.
> >
> > This really is normal.  I've been mentioned over 100 times in commit
> > messages like 7051924f771 (xillybus: Move out of staging).
>
> I'm still reluctant to use the name on description.
> How about you use the Suggested-by tag as following?
>
> [julia.lawall : Suggest that it is not necessary to check return value
> of platform_get_resource]
> Suggested-by: Julia Lawall <julia.lawall@lip6.fr>

Like Dan, I really don't see the problem.  The text in [ ] looks ugly.  A
suggested by by itself would not be appropriate, since I didn't identify
the original issue.  There are ther patches that refer to peoples'
comments in a similar way.  Example:
d8aacd87180141ff6b812b53de77a4336e87c91a

julia
