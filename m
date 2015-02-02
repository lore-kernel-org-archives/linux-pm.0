From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Mon, 2 Feb 2015 08:50:14 +0530
Message-ID: <CAKohpokG7Oyi2B6zFjE7TkLdSTO5i5fTHboKK2fKcuhB-kQ0aQ@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
	<54CADEAE.2090305@oracle.com>
	<CAKohpo=uFZ0BwZ1FLSBpht3Yi1B73LpHDu00Rqk2P3TbzCYsoQ@mail.gmail.com>
	<54CAE80C.4060406@oracle.com>
	<CAKohponF_fqoDj_g4kZuoYa=gz9G_yRn67eJoWT6mnPkejWkjw@mail.gmail.com>
	<54CAEABB.4060508@oracle.com>
	<CAKohpomdf1eZveqw+GCzcuPJnW4BpMYqGebhRR5=mc0ome0vFg@mail.gmail.com>
	<54CAFE88.2080508@oracle.com>
	<CAKohpokstCHezi0-Vp=-WJn4Zrpnj0oELjw6jzkY_0976h3V8w@mail.gmail.com>
	<54CED8CF.9060407@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:37409 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbbBBDUP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 22:20:15 -0500
Received: by mail-oi0-f44.google.com with SMTP id a3so42300324oib.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2015 19:20:15 -0800 (PST)
In-Reply-To: <54CED8CF.9060407@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>

On 2 February 2015 at 07:24, ethan zhao <ethan.zhao@oracle.com> wrote:
>  Policy will be freed only when that's last CPU shutting down, how does it
>  happen when system booting ?

I couldn't understand what you are asking here. Though policy will be allocated
for the first CPU of every policy during boot..

>  The description of the patch would be wrong (the Xen_bus call stack) --
>  Did the xen_bus shut down every CPU till the last during booting ?

I don't know about that..
