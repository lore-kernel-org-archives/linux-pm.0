From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Documentation: Add missing optional properties
Date: Mon, 6 Oct 2014 10:34:30 +0530
Message-ID: <CAKohponEgdaDfdqkTgVX=F7nhoF59Tjce-ZsTLO1G=+x=gHROA@mail.gmail.com>
References: <1412454058-17725-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45004 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaJFFEb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 01:04:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id wp4so3405877obc.10
        for <linux-pm@vger.kernel.org>; Sun, 05 Oct 2014 22:04:31 -0700 (PDT)
In-Reply-To: <1412454058-17725-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>

On 5 October 2014 01:50, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The devicetree binding for cpufreq-cpu0 lacks the optional properties
> clocks and cpu-supply. This patch adds them to the documentation.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> index 366690c..bafcaea 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
> @@ -14,6 +14,8 @@ Optional properties:
>  - operating-points: Refer to Documentation/devicetree/bindings/power/opp.txt for
>    details. OPPs *must* be supplied either via DT, i.e. this property, or
>    populated at runtime.
> +- clocks: Specify the CPU clock
> +- cpu-supply: Specify the regulator which feeds the CPU
>  - clock-latency: Specify the possible maximum transition latency for clock,
>    in unit of nanoseconds.
>  - voltage-tolerance: Specify the CPU voltage tolerance in percentage.

The driver doesn't use them directly and so they aren't mentioned here.
They are probably mentioned in cpu's DT properties and that's all I
believe..
