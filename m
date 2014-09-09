From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 9 Sep 2014 20:15:07 +0530
Message-ID: <CAKohpokQ29y05vtJDcEEJK11e=E-voPbMD1GPC3tH=OB4MM2ww@mail.gmail.com>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
	<1410247775.25768.13.camel@x200t>
	<540EEA95.8030208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53277 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaIIOpJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 10:45:09 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so12332807obc.27
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 07:45:08 -0700 (PDT)
In-Reply-To: <540EEA95.8030208@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>

Empty body?

On 9 September 2014 17:25, Prarit Bhargava <prarit@redhat.com> wrote:
>
