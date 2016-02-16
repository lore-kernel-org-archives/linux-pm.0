From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 06:17:16 +0530
Message-ID: <20160216004716.GG6334@vireshk-i7>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com>
 <743509d913cbc0e725bea52281be03b009e02bb5.1455553501.git.viresh.kumar@linaro.org>
 <17646703.2nZXD4icYj@wuerfel>
 <CAJZ5v0hEc7730-JgWvNp1Pntzz51kL5GQvk11cR-u8_iQ+ZcKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35360 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbcBPAr1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 19:47:27 -0500
Received: by mail-pf0-f170.google.com with SMTP id c10so96865639pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 16:47:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hEc7730-JgWvNp1Pntzz51kL5GQvk11cR-u8_iQ+ZcKw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jon Hunter <jonathanh@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 15-02-16, 22:13, Rafael J. Wysocki wrote:
> That should be something like -ENXIO IMO.

Thanks for modifying and applying the patch :)

-- 
viresh
