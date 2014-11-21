From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Question about FIX ME in cpufreq-dt.c
Date: Fri, 21 Nov 2014 09:18:10 +0530
Message-ID: <CAKohpo=k3uTNAak=ejompWe5jW=dTbQS3M2zx=eCwgFJpu_ekw@mail.gmail.com>
References: <546E24CC.2040402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:64970 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbaKUDsL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 22:48:11 -0500
Received: by mail-oi0-f45.google.com with SMTP id a141so3090207oig.18
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2014 19:48:10 -0800 (PST)
In-Reply-To: <546E24CC.2040402@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nick <xerofoify@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 20 November 2014 22:58, nick <xerofoify@gmail.com> wrote:
> Greetings Rafael and the other maintainers,

Hi.

> I am curious about the FIX ME in cpufreq-dt.c about not using a for loop or running this part of the code on all
> CPUs.

In case this isn't enough then the loop should be run for any one CPU
from each cluster.
That will guarantee that we have completed regulator/clk
initialization for all the clusters..
But checking for all CPUs might be fine as well..

> If not can I remove the FIX ME or if it's valid can one of the maintainers send me so advice on to fix it
> as I will write a patch if need be to fix it.

The deal is that we aren't yet sure if we are really required to check
this for all CPUs.
So, we are waiting for the first platform to break and can be fixed
then. So, just leave it
as is for now :)

Thanks for caring for it :)
