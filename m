From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4] PM / OPP: Add debugfs support
Date: Sat, 07 Nov 2015 02:07:42 +0100
Message-ID: <3137221.AHWQu5xXpc@vostro.rjw.lan>
References: <6775c5c7c2e87b68f999870bdd70de3f77e8a660.1446715747.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50732 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753278AbbKGAia (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 19:38:30 -0500
In-Reply-To: <6775c5c7c2e87b68f999870bdd70de3f77e8a660.1446715747.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>

On Thursday, November 05, 2015 03:02:50 PM Viresh Kumar wrote:
> This patch adds debugfs support to OPP layer to export OPPs and their
> properties for all the devices.
> 
> This creates a top level directory: /sys/kernel/debug/opp and then
> device specific directories (based on device names) inside it. For
> example: 'cpu0', 'cpu1', etc..
> 
> If multiple devices share the OPP table, then the real directory is
> created only for the first device. For all others, links are created to
> the real directory.
> 
> Inside the device specific directory, a separate directory is created
> for each OPP. And within that files per opp property.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Hi Rafael,
> 
> This was applied to pm/linux-next earlier, but then we dropped it citing
> few merge conflicts with driver-core changes. i.e. debugfs_create_bool()
> and debugfs_create_ulong() changes.
> 
> All that is merged by Linus and so we can get this merged back again,
> once you are comfortable.
> 
> @Stephen: I have dropped your Reviewed by tag as there were minor
> changes here, please give it again :)

So I'll wait for the response from Stephen and then I'll queue up this one
for v4.5.

Thanks,
Rafael

