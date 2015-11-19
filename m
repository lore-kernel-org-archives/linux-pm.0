From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] PM / OPP: Parse 'opp-supported-hw' binding
Date: Thu, 19 Nov 2015 08:32:09 +0530
Message-ID: <20151119030209.GN7336@ubuntu>
References: <cover.1447669859.git.viresh.kumar@linaro.org>
 <6d603a73028b40493b280ba7ac9c3fcb51bb2362.1447669859.git.viresh.kumar@linaro.org>
 <20151118225358.GJ32672@codeaurora.org>
 <20151119020023.GL7336@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33046 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbKSDCO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 22:02:14 -0500
Received: by pabfh17 with SMTP id fh17so67321535pab.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 19:02:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151119020023.GL7336@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, nm@ti.com, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Shawn Guo <shawnguo@kernel.org>

On 19-11-15, 07:30, Viresh Kumar wrote:
> -------------------------8<-------------------------
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Tue, 15 Sep 2015 12:53:00 +0530
> Subject: [PATCH] PM / OPP: Parse 'opp-supported-hw' binding
> 
> OPP bindings allow a platform to enable OPPs based on the version of the
> hardware they are used for.
> 
> Add support to the OPP-core to parse these bindings, by introducing
> dev_pm_opp_{set|put}_supported_hw() APIs.

Please ignore this, more corrections required based on 3/3. Will
resend it shortly.

-- 
viresh
