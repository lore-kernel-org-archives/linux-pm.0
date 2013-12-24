From: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 3/3] fuelgauge: max17042: Seperate available property set
 for different operation.
Date: Mon, 23 Dec 2013 19:02:06 -0800
Message-ID: <20131224030206.GI10223@lizard>
References: <1387338834-4046-1-git-send-email-jonghwa3.lee@samsung.com>
 <1387338834-4046-4-git-send-email-jonghwa3.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:36172 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753864Ab3LXDHV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 22:07:21 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so5811385pdj.4
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2013 19:07:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387338834-4046-4-git-send-email-jonghwa3.lee@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jonghwa Lee <jonghwa3.lee@samsung.com>
Cc: linux-pm@vger.kernel.org, dwmw2@infradead.org, MyungJoo Ham <myungjoo.ham@samsung.com>

On Wed, Dec 18, 2013 at 12:53:54PM +0900, Jonghwa Lee wrote:
> max17042 fuelgauge driver supports various successors based on max17042.
> Some versions use currrent sensor and temperature sensor to increase accuracy,
> while others don't. So this patch makes driver to support seperate property set
> depending on chip implementation.
> 
> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> ---

You'll have to reiterate this patch as patch 1/3 needs to go.

Thanks,

Anton
