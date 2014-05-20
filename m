From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: discard duplicate OPPs
Date: Tue, 20 May 2014 18:59:45 +0530
Message-ID: <CAKohpokkPjgruJGam3p0vc9xHThpDiTMRoiEG5y5PB_RDZSHLQ@mail.gmail.com>
References: <1400230809-11401-1-git-send-email-chander.kashyap@linaro.org>
	<CAKohponAx=Hi_Ywgg4hXxrpmmaqy5=pYnb3nSBNUP3KtADTEeA@mail.gmail.com>
	<CAKohpomKvPcioNmfzvx7vqJHqs_TrhnHH6yYb5w_0f+YvA5hvA@mail.gmail.com>
	<2638341.ymNLNAMmAG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50999 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbaETN3q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 May 2014 09:29:46 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so484208obc.5
        for <linux-pm@vger.kernel.org>; Tue, 20 May 2014 06:29:46 -0700 (PDT)
In-Reply-To: <2638341.ymNLNAMmAG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 20 May 2014 18:15, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>                 int ret = new_opp->u_volt == opp->u_volt ? -EEXIST : 0;
>
> would be slightly simpler IMO.

Much better :)
