From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/8] opp: Introduce APIs to remove OPPs
Date: Thu, 27 Nov 2014 05:56:21 +0530
Message-ID: <CAKohpomz-kekRU7YD8_TYbeVRRs7WmrqLFT0yALxXwFGjwqNOQ@mail.gmail.com>
References: <cover.1416910766.git.viresh.kumar@linaro.org>
	<CAKohponz3MsgZNtm1i-aLx8kRRjJwUJjL=B3RE96EiivwXbF2A@mail.gmail.com>
	<CAKohpomKym9dqzQDmS-7ipze4jCYDU4_UN4a36VceHuGezoiVw@mail.gmail.com>
	<11530150.5svHxl9OuM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:49803 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752863AbaK0A0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Nov 2014 19:26:22 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so3050582obc.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Nov 2014 16:26:22 -0800 (PST)
In-Reply-To: <11530150.5svHxl9OuM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>

On 27 November 2014 at 04:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> That should work if I'm not mistaken, but I'm wondering if we could
> settle on using one RCU type for this (later, though).

We can convert all call sites to use SRCU then. Once we are sure about it.
