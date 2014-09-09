From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Tue, 9 Sep 2014 13:05:59 +0530
Message-ID: <CAKohpomN_4R5vt+_BfsVGTCVDrUhkens_=ptSMOOdJQaRPc-aw@mail.gmail.com>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
	<1410247775.25768.13.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:52166 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155AbaIIHgD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 03:36:03 -0400
Received: by mail-ob0-f179.google.com with SMTP id uz6so11722375obc.38
        for <linux-pm@vger.kernel.org>; Tue, 09 Sep 2014 00:36:00 -0700 (PDT)
In-Reply-To: <1410247775.25768.13.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 9 September 2014 12:59, Robert Sch=C3=B6ne <robert.schoene@tu-dresde=
n.de> wrote:
> Even though the test fixed my initital problem, my test system (which
> runs the kernel with this patch applied) just crashed when changing

Only this patch ? or both 1/2 & 2/2 ??

> frequencies. This might be connected to the patch.
>
> I'll have another look into it and let you know.

Hmm, that's strange. Probably some other (existing) bug woken up with
this change.. Also this patch will come into picture while changing gov=
ernor
tunables and not during frequency switches.. So they looked a bit unrel=
ated
to me..

Yeah, please let us know if this breaks anything.
