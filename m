From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] driver/core: cpu: initialize opp table
Date: Tue, 20 May 2014 08:08:29 +0530
Message-ID: <CAKohponzi0qcA6Zs8u=fPFpYXc4rC_ybV3EKu212mDXYekNKug@mail.gmail.com>
References: <60d825e8bfe01f8a5ff98fffaf51ffbf04c7d175.1400480033.git.viresh.kumar@linaro.org>
	<ca7cc76c49806ce1ac8f9617fa4266cfc29d1ea1.1400480592.git.viresh.kumar@linaro.org>
	<4765191.0FhyvSGyvF@vostro.rjw.lan>
	<1458497.gJ29RmexAd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:49803 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaETCia (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 22:38:30 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so7243355oag.32
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2014 19:38:29 -0700 (PDT)
In-Reply-To: <1458497.gJ29RmexAd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 20 May 2014 02:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Do patches [2-5/5] depend on this one BTW?

Yes.
