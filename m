From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Fri, 4 Dec 2015 13:53:39 +0530
Message-ID: <20151204082339.GH3430@ubuntu>
References: <cover.1447904566.git.viresh.kumar@linaro.org>
 <4341a83dc6591364cd9deb3dfa8343961b8605d6.1447904566.git.viresh.kumar@linaro.org>
 <20151125205147.GE11298@codeaurora.org>
 <20151127044517.GU3869@ubuntu>
 <20151201065252.GD4459@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35717 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbbLDIXn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2015 03:23:43 -0500
Received: by pfu207 with SMTP id 207so22889787pfu.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Dec 2015 00:23:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151201065252.GD4459@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, nm@ti.com, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 01-12-15, 12:22, Viresh Kumar wrote:
> Since these functions are *only* going to be called before any OPPs
> are added for the device, and hence ruling out any concurrent readers,
> maybe we can guarantee that with this:

@Rafael: Stephen has gone for vacations until end of year :(, can you
please help with some reviews ?

-- 
viresh
