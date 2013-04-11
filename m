From: Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH] thermal: exynos: fix handling of invalid frequency table entries
Date: Thu, 11 Apr 2013 11:40:04 -0700
Message-ID: <CAL1qeaEjmtwTZ4QRaDyD9Mb5Rko39uSN6NrjwyOT7_43NaH+Vw@mail.gmail.com>
References: <1365544758-15245-1-git-send-email-abrestic@chromium.org>
	<1365559613.2183.7.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:55446 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab3DKSkG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 14:40:06 -0400
Received: by mail-bk0-f54.google.com with SMTP id q16so1004486bkw.13
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 11:40:04 -0700 (PDT)
In-Reply-To: <1365559613.2183.7.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

> can you please verify
> commit  fc35b35cbe24ef021ea9acfba21e54da958df747
> commit 57df8106932b57427df1eaaa13871857f75b1194
> at
> http://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/log/?h=thermal
> fixes the problem for you?

It does.  Thanks!

-Andrew
