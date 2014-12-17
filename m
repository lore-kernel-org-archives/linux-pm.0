From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] cpufreq: Stop BUGing the system
Date: Wed, 17 Dec 2014 11:16:36 -0800
Message-ID: <7hoar29je3.fsf@deeprootsystems.com>
References: <1418831495-26958-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:56765 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaLQTQk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Dec 2014 14:16:40 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so16662710pdb.19
        for <linux-pm@vger.kernel.org>; Wed, 17 Dec 2014 11:16:39 -0800 (PST)
In-Reply-To: <1418831495-26958-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 17 Dec 2014 09:51:35 -0600")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Nishanth Menon <nm@ti.com> writes:

> CPUFRreq subsystem is not a system catastrophic failure point.
> Failures in these cases DONOT need complete system shutdown with BUG.
> just refuse to let cpufreq function should be good enough.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Kevin Hilman <khilman@linaro.org>
