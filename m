From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [GIT PULL] PM / AVS changes for v3.18 - v2
Date: Fri, 26 Sep 2014 08:42:38 -0700
Message-ID: <CAMAWPa9E-HY8tbMU3y8EHv0XhCHynTopSMupDHF4R2wBvLEOSg@mail.gmail.com>
References: <7ha95nikqh.fsf@linaro.org>
	<20140926081534.GA27755@sirena.org.uk>
	<7hmw9m795y.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:41230 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753803AbaIZPmn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Sep 2014 11:42:43 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8151A202BE
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 15:42:42 +0000 (UTC)
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 5E20020270
	for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 15:42:41 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id k14so9988334wgh.12
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 08:42:38 -0700 (PDT)
In-Reply-To: <7hmw9m795y.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>, Douglas Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>

On Fri, Sep 26, 2014 at 7:23 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Mark Brown <broonie@kernel.org> writes:
>
>> On Thu, Sep 25, 2014 at 12:05:42PM -0700, Kevin Hilman wrote:
>>
>>> The first pull request was missing a dependency on a feature that went
>>> in through Mark Brown's regulator tree, so it wouldn't actually compile
>>> properly by itself.  This version pulls in that topic branch from Marks
>>> tree (topic/voltage-ev branch, already part of -next), and now compiles fine.
>>
>> Please in future don't pull anything in from my tree without a signed
>> tag (speak to me if there isn't one).
>
> Sorry about that.
>
> Had there been more than one patch in this topic branch, or it wasn't
> based directly on an -rc tag, I would've waited for confirmation about
> it being stable, but since it was a single patch, based directly on an
> -rc tag, I assumed it was stable.
>
> In the future, I'll be sure to request a signed tag.

Hmm, turns out there actually was a signed tag[1] (I thought I
remembered you saying it was stable), but I still made the mistake of
pulling the branch and not the tag.

Kevin

[1] https://lkml.org/lkml/2014/8/29/182
