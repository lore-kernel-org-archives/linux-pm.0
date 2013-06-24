From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s3c2416: fix forgotten driver_data conversions
Date: Mon, 24 Jun 2013 11:23:14 +0530
Message-ID: <CAKohpomy6wbfQDq1JVBw+aUummjaPSOjNAHwFpsd98HUz5hPBA@mail.gmail.com>
References: <201306230108.25639.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:53006 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab3FXFxP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2013 01:53:15 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so11425664oag.28
        for <linux-pm@vger.kernel.org>; Sun, 23 Jun 2013 22:53:14 -0700 (PDT)
In-Reply-To: <201306230108.25639.heiko@sntech.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 23 June 2013 04:38, Heiko St=FCbner <heiko@sntech.de> wrote:
> Commit 5070158804b5 (cpufreq: rename index as driver_data in
> cpufreq_frequency_table) renamed the index field to driver_data.
>
> But it seems some uses in the s3c2416 driver were forgotten.
>
> So convert the last index users to read driver_data.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/cpufreq/s3c2416-cpufreq.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

So sorry for this mistake. Applied.
