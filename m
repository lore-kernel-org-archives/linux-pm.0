From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] thermal: imx: Do not print error message in the
 EPROBE_DEFER case
Date: Thu, 11 Dec 2014 21:18:25 -0200
Message-ID: <CAOMZO5Ao2=wbKj4VtU4bq5FhMfeOaMW5M9kmjf7y7o0vx-WJDA@mail.gmail.com>
References: <1418332300-7859-1-git-send-email-festevam@gmail.com>
	<20141211231405.GA19853@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:51819 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbaLKXS1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Dec 2014 18:18:27 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so5130982lab.24
        for <linux-pm@vger.kernel.org>; Thu, 11 Dec 2014 15:18:25 -0800 (PST)
In-Reply-To: <20141211231405.GA19853@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

Hi Eduardo,

On Thu, Dec 11, 2014 at 9:14 PM, Eduardo Valentin <edubezval@gmail.com> wrote:

> Thanks for your patch. But I am queuing a different patch that does a
> similar job.
>
> https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=fixes&id=0f1be51c358f740fe5183bd0bcd60076fdfb53d0

I am running linux-next 20141211, which has this commit applied.

> Can you please check my -fixes branch? When EPROBE_DEFER happens, we are
> now printing a debug message only.

On linux-next I am still getting the error, so I still needed my patch.

Thanks
