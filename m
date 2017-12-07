From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: RE: [PATCH] PM / devfreq: Fix potential NULL pointer dereference in
 governor_store
Date: Thu, 07 Dec 2017 02:41:44 +0000
Message-ID: <20171207024144epcms1p4d7e1a981c7c307190a85e8c35174d983@epcms1p4>
References: <20171206202015.GA15636@embeddedor.com>
        <CGME20171206202020epcas3p4fe9a9fb5346f2d413199ed71d1d0f19f@epcms1p4>
Reply-To: myungjoo.ham@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:28159 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdLGCmF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Dec 2017 21:42:05 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20171207024203epoutp0383ec6e0cb0e9b27c3c090b929ff74b7f~94uU0x6OT1341413414epoutp03Q
        for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2017 02:42:03 +0000 (GMT)
In-Reply-To: <20171206202015.GA15636@embeddedor.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

> df->governor is being dereferenced before it is null checked,
> hence there is a potential null pointer dereference.
> 
> Notice that df->governor is being null checked at line 1004:
> if (df->governor) {, which implies it might be null.
> 
> Fix this by null checking df->governor before dereferencing it.
> 
> Addresses-Coverity-ID: 1401988 ("Dereference before null check")
> Fixes: bcf23c79c4e4 ("PM / devfreq: Fix available_governor sysfs")
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo

> ---
>  drivers/devfreq/devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 78fb496..14fe76b 100644
