From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: Initialize regulator pointer to an error value
Date: Tue, 16 Feb 2016 01:50:31 +0100
Message-ID: <1675907.26pKXjqTm9@vostro.rjw.lan>
References: <1455544758-7718-1-git-send-email-jonathanh@nvidia.com> <CAJZ5v0hEc7730-JgWvNp1Pntzz51kL5GQvk11cR-u8_iQ+ZcKw@mail.gmail.com> <20160216004716.GG6334@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58508 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751491AbcBPAtR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 19:49:17 -0500
In-Reply-To: <20160216004716.GG6334@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, Jon Hunter <jonathanh@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, February 16, 2016 06:17:16 AM Viresh Kumar wrote:
> On 15-02-16, 22:13, Rafael J. Wysocki wrote:
> > That should be something like -ENXIO IMO.
> 
> Thanks for modifying and applying the patch :)

Well, you're welcome.

I wanted it to be fixed in the tomorrow's linux-next so people can boot their
systems again.

Thanks,
Rafael

