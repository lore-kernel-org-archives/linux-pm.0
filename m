From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] [RFC] PM / Domains: add multiple states
Date: Thu, 16 Apr 2015 16:00:07 +0200
Message-ID: <CAPDyKFoxCxOqX=eFo_GjSLMkTLL4_j1WQjf7K5MHYhmsGGnssg@mail.gmail.com>
References: <1428507725-12205-1-git-send-email-ahaslam@baylibre.com>
	<1428507725-12205-2-git-send-email-ahaslam@baylibre.com>
	<CAPDyKFoSvY=G7PQ5EnacTDfmuxYw398A0h_TV--6E9exXJv-cg@mail.gmail.com>
	<552B9BAD.9050809@baylibre.com>
	<CAPDyKFrjzF0cmvCXo7PqJ6zhLJ+DPBimtekvANDzoZgLRbuS-Q@mail.gmail.com>
	<552E59F4.4080008@baylibre.com>
	<CAPDyKFo9W=AT3TO4T-Sdc7VTsRocA4o7JQiCep=ZNOPmS0k9cA@mail.gmail.com>
	<552FB9E8.90401@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:34492 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbbDPOAI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2015 10:00:08 -0400
Received: by qcyk17 with SMTP id k17so6549997qcy.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2015 07:00:07 -0700 (PDT)
In-Reply-To: <552FB9E8.90401@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Axel Haslam <ahaslam@baylibre.com>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>

On 16 April 2015 at 15:32, Axel Haslam <ahaslam@baylibre.com> wrote:
> Hi Uffe,
>
>>
>> Correct.
>>
>> So what do you think of always saving and restoring context, would
>> that work for your case?
>
>
> It would work for me, because im not really looking to optimize latency at
> this point.
>
> Would you think it would be possible to add multiple states to genpd
> as a first step, and then maybe discuss about context save/restore
> optimizations?
>
> if yes, i could remove the context save/restore stuff from the multiple
> states patch.

That seems like a good way forward! Keep me posted. :-)

Kind regards
Uffe
