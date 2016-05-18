From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 4/6] cpufreq: conservative: Remove declaration of cs_dbs_gov
Date: Wed, 18 May 2016 23:03:18 +0200
Message-ID: <CAJZ5v0gbFaEpRbSXaEr8X5_DjcuWParKdS+mUshmKrLu7xnRTQ@mail.gmail.com>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
	<f51606d0f2c04852b7b5c2f1137238bbc1fe1828.1463574213.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37929 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090AbcERVDU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 May 2016 17:03:20 -0400
In-Reply-To: <f51606d0f2c04852b7b5c2f1137238bbc1fe1828.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, May 18, 2016 at 2:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The code doesn't use 'cs_dbs_gov' anymore before it is defined and the
> extra line for declaring it can be removed.

This sort of conflicts with a patch I've just posted
(https://patchwork.kernel.org/patch/9122121/) and I'd prefer to go
with that one if that's not a big deal.
