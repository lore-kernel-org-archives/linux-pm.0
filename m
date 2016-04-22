From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PM / OPP: -ENOSYS is applicable only to syscalls
Date: Fri, 22 Apr 2016 15:59:41 +0100
Message-ID: <20160422155941.23e1d05b@lxorguk.ukuu.org.uk>
References: <cover.1461228504.git.viresh.kumar@linaro.org>
	<a825b531b34b15615791f40610c151e3f1ce2fb4.1461294917.git.viresh.kumar@linaro.org>
	<60895590.AIt8jZZHh3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:48992 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcDVPAO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Apr 2016 11:00:14 -0400
In-Reply-To: <60895590.AIt8jZZHh3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, andrew@lunn.ch, gregory.clement@free-electrons.com, jason@lakedaemon.net, sebastian.hesselbarth@gmail.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org

On Fri, 22 Apr 2016 14:42:31 +0200
"Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:

> On Friday, April 22, 2016 08:46:51 AM Viresh Kumar wrote:
> > Some of the routines have use -ENOSYS, which is supposed to be used only
> > for syscalls. Replace that with -EINVAL.  
> 
> -EINVAL specifically means "invalid argument".
> 
> What about using -ENXIO instead?

That specifically means "device not present", but might be reasonable.
Quite a bit of the kernel uses EOPNOTSUPP (operation not supported).

Before you change it though please check how existing userspace does
error handling. It's nice to use more "correct" error codes, but that's
not sufficient reason if it turns out that existing user space checks for
ENOSYS for example.

Alan
