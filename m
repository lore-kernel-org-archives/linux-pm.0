From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/2] cpufreq: Handle sorted frequency tables more efficiently
Date: Mon, 27 Jun 2016 07:26:01 +0530
Message-ID: <CAOh2x==ZeqVpTXP4j4YnQp+gwuZDW6vS0p9dBVw_HNOfd720_g@mail.gmail.com>
References: <cover.1465295033.git.viresh.kumar@linaro.org> <c80f4bf69bd4eb739038cb0f91392fad9cfde59f.1465295033.git.viresh.kumar@linaro.org>
 <15131722.y1kqigY9Ad@vostro.rjw.lan> <20160626103840.GA32206@ubuntu> <CAJZ5v0jOH1k=FaAHaCLHnp=9MKjUM0v6WJ-HSUFHTy_dsL_KRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33204 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbcF0B41 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 26 Jun 2016 21:56:27 -0400
In-Reply-To: <CAJZ5v0jOH1k=FaAHaCLHnp=9MKjUM0v6WJ-HSUFHTy_dsL_KRg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>

On Mon, Jun 27, 2016 at 5:58 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sun, Jun 26, 2016 at 12:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> So IMO all of the callers should be made clamp the target frequency
> between min and max and those checks should be dropped from the
> low-level helpers.

Okay, so doing this from all these very low level helpers can be avoided
by moving them to cpufreq_frequency_table_target() at least for now.

Later on we can see on how we can update the callers and see how
it works best.

Thanks for the review.

--
viresh
