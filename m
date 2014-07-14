From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] Cpufreq: ARM IMX6Q: Select PM_OPP
Date: Mon, 14 Jul 2014 09:43:36 -0300
Message-ID: <20140714124336.GA1763@arch.cereza>
References: <1405288740-3986-1-git-send-email-ndel314@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:50460 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbaGNMo2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 08:44:28 -0400
Received: by mail-yh0-f46.google.com with SMTP id a41so193816yho.5
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2014 05:44:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405288740-3986-1-git-send-email-ndel314@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Del Piano <ndel314@gmail.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Nico,

On 13 Jul 06:59 PM, Nicolas Del Piano wrote:
> PM_OPP is a library used by several of the existing cpufreq drivers.
> ARM IMX6Q cpufreq driver uses this library for its functionality.
> Thus, it should be selected in Kconfig.
> 
> Reported-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> Signed-off-by: Nicolas Del Piano <ndel314@gmail.com>

Thanks for the patch. I have just a very minor nitpick to comment;
if you run a git log, you'll see the subject should be:

"cpufreq: imx6q: Select PM_OPP"

In general, it's better to see the recent commits to find out how to write
the commit title; each driver can have its own style.
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
