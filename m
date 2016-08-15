From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH -next] power: axp288_charger: remove duplicated include
 from axp288_charger.c
Date: Mon, 15 Aug 2016 21:41:21 +0800
Message-ID: <CAGb2v64i4i9tsbpu=KVDYmsuouxE5Eb0hV9BDTV-D76zzxqxQw@mail.gmail.com>
References: <1471079227-9753-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:40314 "EHLO
	smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbcHONlr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Aug 2016 09:41:47 -0400
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com [209.85.223.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 2251E23097
	for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2016 20:45:38 +0800 (CST)
Received: by mail-io0-f174.google.com with SMTP id 38so79708265iol.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Aug 2016 06:41:43 -0700 (PDT)
In-Reply-To: <1471079227-9753-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Chen-Yu Tsai <wens@csie.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>

On Sat, Aug 13, 2016 at 5:07 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> Remove duplicated include.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
