From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: tango: Use generic platdev driver
Date: Mon, 2 May 2016 20:32:52 +0530
Message-ID: <20160502150252.GI2855@vireshk-i7>
References: <5727588D.5090105@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33013 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbcEBPC5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 11:02:57 -0400
Received: by mail-pa0-f46.google.com with SMTP id xk12so3852494pac.0
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2016 08:02:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5727588D.5090105@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm <linux-pm@vger.kernel.org>, arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sebastian Frias <sf84@laposte.net>

On 02-05-16, 15:39, Mason wrote:
> From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> 
> Add tango4 compatible string to the list.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
