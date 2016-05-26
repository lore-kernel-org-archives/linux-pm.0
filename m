From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [patch v2] PM / devfreq: exynos-nocp: Remove incorrect IS_ERR() check
Date: Thu, 26 May 2016 22:46:26 +0900
Message-ID: <CAGTfZH2rqD_91D_Vt8EgXDO4ACJ-OKD5Os9RA4Mk7hg0EHzfcg@mail.gmail.com>
References: <CGME20160526064612epcas1p4cb0d45fa11deafea51fa84974132afed@epcas1p4.samsung.com>
	<20160526064541.GA6680@mwanda>
	<5746AFE3.6030606@samsung.com>
	<20160526115629.GD10957@mwanda>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33892 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbcEZNq1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2016 09:46:27 -0400
In-Reply-To: <20160526115629.GD10957@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thu, May 26, 2016 at 8:56 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Thu, May 26, 2016 at 05:12:19PM +0900, Chanwoo Choi wrote:
>> I don't recommend that you mention the name of engineer on patch description
>> directly.
>
> This really is normal.  I've been mentioned over 100 times in commit
> messages like 7051924f771 (xillybus: Move out of staging).

I'm still reluctant to use the name on description.
How about you use the Suggested-by tag as following?

[julia.lawall : Suggest that it is not necessary to check return value
of platform_get_resource]
Suggested-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks,
Chanwoo Choi
