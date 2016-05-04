From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / sleep: Remove unused `info' variable
Date: Wed, 04 May 2016 23:23:29 +0200
Message-ID: <5134227.oTSuCEzm8k@vostro.rjw.lan>
References: <1461847354-11486-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44894 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753176AbcEDVUS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 17:20:18 -0400
In-Reply-To: <1461847354-11486-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@linux.intel.com>

On Thursday, April 28, 2016 02:42:34 PM Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Commit 32e8d689dc12 ("PM / sleep: trace_device_pm_callback coverage in
> dpm_prepare/complete") removed all users of this variable but forgot to
> remove the variable itself.
> 
> Cc: Todd Brandt <todd.e.brandt@linux.intel.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Applied, thanks!

