From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 03/14] cpufreq: dbx500: use cpufreq_generic_init() routine
Date: Thu, 22 Aug 2013 01:00:59 +0200
Message-ID: <CACRpkdY33h7GC1Q2hQZzBYJiQM9qvSGYBFabaaMJg8wBZG1=TQ@mail.gmail.com>
References: <cover.1377093938.git.viresh.kumar@linaro.org>
	<580c144ac4a85899ddc3d6350e50761c9d69b1fe.1377093938.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:46527 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3HUXBA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Aug 2013 19:01:00 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so2199666oag.29
        for <linux-pm@vger.kernel.org>; Wed, 21 Aug 2013 16:00:59 -0700 (PDT)
In-Reply-To: <580c144ac4a85899ddc3d6350e50761c9d69b1fe.1377093938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 21, 2013 at 4:42 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Use generic cpufreq_generic_init() routine instead of replicating the same code
> here.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
