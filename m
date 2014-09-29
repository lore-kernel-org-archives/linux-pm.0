From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Mon, 29 Sep 2014 02:50:48 -0700
Message-ID: <CAKohponApVw0ssVjxSkYqRmmmGYTKtYzjLR41Oqtm-CZg-OsaQ@mail.gmail.com>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
	<1478598.DgG2vI5Y04@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:41906 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaI2Jut (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 05:50:49 -0400
Received: by mail-qg0-f53.google.com with SMTP id a108so427524qge.26
        for <linux-pm@vger.kernel.org>; Mon, 29 Sep 2014 02:50:49 -0700 (PDT)
In-Reply-To: <1478598.DgG2vI5Y04@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 24 September 2014 16:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What's the current status of this series?

Started working again after two weeks today only and so it might
take some days for things to get stable at my end. Should be able
to test things after that..
