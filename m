From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] driver/core: cpu: initialize opp table
Date: Tue, 20 May 2014 08:08:11 +0530
Message-ID: <CAKohpokaBo96h4axsntJz8b6q9VE7Z_GfQvfuQ85HEFi8r4V4w@mail.gmail.com>
References: <60d825e8bfe01f8a5ff98fffaf51ffbf04c7d175.1400480033.git.viresh.kumar@linaro.org>
	<ca7cc76c49806ce1ac8f9617fa4266cfc29d1ea1.1400480592.git.viresh.kumar@linaro.org>
	<4765191.0FhyvSGyvF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:47560 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751103AbaETCiM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 May 2014 22:38:12 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy5so7231775obc.29
        for <linux-pm@vger.kernel.org>; Mon, 19 May 2014 19:38:11 -0700 (PDT)
In-Reply-To: <4765191.0FhyvSGyvF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Ips Gandhi <inderpal.s@samsung.com>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, Chander Kashyap <chander.kashyap@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>

On 20 May 2014 02:43, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What about
>
>         if (error)
>                 return error;
>
> and then you'd save an indentation level?

Yes.

> Anyway, I find adding of_node* stuff directly to the driver core this way
> kind of disgusting as there still are platforms that don't use it.
>
> Can we have a call to a function that will change into an empty stub on such
> platforms here, please?

Okay. But can you explain a bit more about how and where those stubs
would be implemented?
