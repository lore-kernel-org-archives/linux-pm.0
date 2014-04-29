From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: time_in_state on Ubuntu 13.10
Date: Tue, 29 Apr 2014 13:56:18 +0530
Message-ID: <CAKohponpGMMRUvDivaxj_qz5dQvhxZHiHW4Z19GzpaEJHGStRQ@mail.gmail.com>
References: <535E6906.2090201@unine.ch>
	<CAOh2x==Q_oDn9v4S5ggh_e-3_=vSU_5Ko_89LfWM9ARBS9i=Rg@mail.gmail.com>
	<535F51F7.5090804@unine.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:63643 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbaD2I0S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Apr 2014 04:26:18 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so8370534obb.26
        for <linux-pm@vger.kernel.org>; Tue, 29 Apr 2014 01:26:18 -0700 (PDT)
In-Reply-To: <535F51F7.5090804@unine.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mascha Kurpicz <mascha.kurpicz@unine.ch>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Maxime Colmant <maxime.colmant@inria.fr>

On 29 April 2014 12:47, Mascha Kurpicz <mascha.kurpicz@unine.ch> wrote:
> Sorry for the imprecision.
>
> Works correctly with
> Ubuntu 12.04.3 LTS - kernel 3.2.0-29-generic
> Ubuntu 12.04.3 LTS -  kernel 3.8.0-29
> Ubuntu 13.10 - kernel 3.8.0-29-generic
>
> 0 or very small (e.g. 6) values with
> Ubuntu 13.10 - kernel 3.11.0-20-generic

Can you provide cpufreq-info 's output for the last two cases please?

i.e.
> Ubuntu 13.10 - kernel 3.8.0-29-generic
> Ubuntu 13.10 - kernel 3.11.0-20-generic
