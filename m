From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/8] PM / Domains: Allow domain power states to be read
 from DT
Date: Mon, 10 Oct 2016 23:24:55 +0200
Message-ID: <CAPDyKFru7fjqnxWbMdjsYu5ZMQd1j_vduAFXusWkwspVjzCMcw@mail.gmail.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-4-git-send-email-lina.iyer@linaro.org> <CAPDyKFo62XuwsoqqPyFa7FYMutd2ng-xt9f7aFh_2T6ab=vAZg@mail.gmail.com>
 <20161010150301.GA44885@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35852 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbcJJVY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 17:24:57 -0400
Received: by mail-qk0-f174.google.com with SMTP id o68so3988196qkf.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 14:24:57 -0700 (PDT)
In-Reply-To: <20161010150301.GA44885@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Marc Titinger <mtitinger+renesas@baylibre.com>

[...]

>>> +int of_genpd_parse_idle_states(struct device_node *dn,
>>> +                       struct genpd_power_state **states, int *n)
>>
>>
>> Instead of taking **states as a parameter, let's instead return it as
>> a pointer for the allocated struct. In case of failures, let's return
>> ERR_PTR().
>>
> Hmm.. I thought about it. There are 2 return values from this function.
> If we return a pointer to the allocated memory, we still have to return
> the size of it as an argument. I wasn't happy splitting the return
> values in 2 different places.

Ahh, right. So let's keep it as is!

[...]

Kind regards
Uffe
