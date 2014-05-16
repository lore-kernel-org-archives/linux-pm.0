From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: fix incorrect OPP count handling in of_init_opp_table
Date: Fri, 16 May 2014 16:43:31 +0530
Message-ID: <CAKohpomYMcisB-UHp7TOEdxvQ9-1VzyRshQh=P-dQqYOuBz-5g@mail.gmail.com>
References: <1400237477-24831-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:51536 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713AbaEPLNc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 07:13:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so2769039obc.23
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 04:13:32 -0700 (PDT)
In-Reply-To: <1400237477-24831-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 16 May 2014 16:21, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> In of_init_opp_table function, if a failure to add an OPP is
> detected, the count of OPPs, yet to be added is not updated.
> Fix this by decrementing this count on failure as well.
>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> ---
>  drivers/base/power/opp.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
