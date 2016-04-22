From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / OPP: -ENOSYS is applicable only to syscalls
Date: Fri, 22 Apr 2016 14:42:31 +0200
Message-ID: <60895590.AIt8jZZHh3@vostro.rjw.lan>
References: <cover.1461228504.git.viresh.kumar@linaro.org> <a825b531b34b15615791f40610c151e3f1ce2fb4.1461294917.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49347 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752524AbcDVMji (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 08:39:38 -0400
In-Reply-To: <a825b531b34b15615791f40610c151e3f1ce2fb4.1461294917.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On Friday, April 22, 2016 08:46:51 AM Viresh Kumar wrote:
> Some of the routines have use -ENOSYS, which is supposed to be used only
> for syscalls. Replace that with -EINVAL.

-EINVAL specifically means "invalid argument".

What about using -ENXIO instead?

