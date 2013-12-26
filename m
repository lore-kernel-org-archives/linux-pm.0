From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: try to resume policies which failed on last resume
Date: Thu, 26 Dec 2013 08:17:48 +0530
Message-ID: <CAKohponHBaGG1e5e+Wmg6rqMB-nbRx1e=F+u5AoaNb=mxfQL6A@mail.gmail.com>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
	<5562479.pVWRuDL0y6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:61436 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3LZCrt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Dec 2013 21:47:49 -0500
Received: by mail-ob0-f179.google.com with SMTP id wm4so7826727obc.24
        for <linux-pm@vger.kernel.org>; Wed, 25 Dec 2013 18:47:48 -0800 (PST)
In-Reply-To: <5562479.pVWRuDL0y6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 26 December 2013 06:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Clean up after a failing light-weight initializatio=
n
>
> If cpufreq_policy_restore() returns NULL during system resume,
> __cpufreq_add_dev() should just fall back to the full initialization
> instead of returning an error, because that may actually make things
> work.  Moreover, it should not leave stale fallback data behind after
> it has failed to restore a previously existing policy.
>
> This change is based on Viresh Kumar's work.
>
> Reported-by: Bj=F8rn Mork <bjorn@mork.no>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
