From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH -next] power: axp288_fuel_gauge: remove duplicated include
 from axp288_fuel_gauge.c
Date: Mon, 15 Aug 2016 21:41:35 +0800
Message-ID: <CAGb2v64pUv4F-Q5du5ki_OWv47LyW1fkP1bh8Fhq9g=_WnxEFw@mail.gmail.com>
References: <1471079207-9668-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40336 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151AbcHONmF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2016 09:42:05 -0400
Received: from mail-io0-f176.google.com (mail-io0-f176.google.com [209.85.223.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 64D77230B5
	for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2016 20:45:52 +0800 (CST)
Received: by mail-io0-f176.google.com with SMTP id b62so79560098iod.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2016 06:41:57 -0700 (PDT)
In-Reply-To: <1471079207-9668-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Chen-Yu Tsai <wens@csie.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Sat, Aug 13, 2016 at 5:06 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> Remove duplicated include.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
