From: Alexandre Vicenzi <vicenzi.alexandre@gmail.com>
Subject: Re: Kworker with high cpu usage (~80%)
Date: Thu, 2 Feb 2017 23:22:54 -0200
Message-ID: <CAMHH1fU0Rq7eKvN7O8B1YA5XzsHA1feRtBYanrj5caWC8dYsxw@mail.gmail.com>
References: <CAMHH1fXRbWaBv2U2duKF+v6RRcfKLLKkNf=mb0TYA4foj2i5kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36225 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbdBCBW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2017 20:22:57 -0500
In-Reply-To: <CAMHH1fXRbWaBv2U2duKF+v6RRcfKLLKkNf=mb0TYA4foj2i5kw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

Hi,

Any ideas?

Regards,

Alexandre Vicenzi

2017-01-19 0:13 GMT-02:00 Alexandre Vicenzi <vicenzi.alexandre@gmail.com>:
> Hello,
>
> It has been a while that I noticed that kworker/0:1 eats a lot of CPU
> on my computer, about ~80%.
>
> I never found the real problem, but googling the solution was to
> disable some GPE interrupt, in my case it is
> /sys/firmware/acpi/interrupts/gpe13.
>
> This is a dirty solution, actually, it hides the problem I think. I
> have no idea what is the real problem and I would like to understand
> what is.
>
> I'm using kernel 4.9.0-2 now, but it was present on older versions
> too. I'm running OpenSuse on a Samsung laptop (Intel i5 3rd gen).
>
> If someone could point me in the right direction I'll be happy to
> share more info.
>
> Regards,
>
> Alexandre Vicenzi
