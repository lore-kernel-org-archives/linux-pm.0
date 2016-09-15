From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Power driver patches to avoid lockdep complaints
Date: Thu, 15 Sep 2016 22:41:17 +0200
Message-ID: <CAJZ5v0hMywg5r56=dGA=LcsiUj92gp0ut=Mou55SUBWZBXd6GA@mail.gmail.com>
References: <20160615211344.GA31850@linux.vnet.ibm.com> <20160823004549.b66jru7ogyfifunf@atomide.com>
 <20160823005917.GY3482@linux.vnet.ibm.com> <3368049.VBoKnTMGvK@vostro.rjw.lan>
 <20160823101600.GA3482@linux.vnet.ibm.com> <20160915194129.tq65ieriuo6a3yrf@atomide.com>
 <20160915195240.7lxrrf2s2fkgavwn@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37978 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754889AbcIOUlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Sep 2016 16:41:19 -0400
Received: by mail-wm0-f51.google.com with SMTP id 1so5194072wmz.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Sep 2016 13:41:19 -0700 (PDT)
In-Reply-To: <20160915195240.7lxrrf2s2fkgavwn@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Guenter Roeck <linux@roeck-us.net>, Steven Rostedt <rostedt@goodmis.org>, Linux PM <linux-pm@vger.kernel.org>

On Thu, Sep 15, 2016 at 9:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [160915 12:41]:
>> Rafael, I'm still not seeing these applied, care to check?
>
> Sorry looks like only one of the three fixes is missing from
> current mainline:
>
> 13e698e68f75 ("power: Use _rcuidle for suspend/resume tracepoints")
>
> So I'm still getting warning out of box with omap2plus_defconfig.

It's not been applied, because I was unaware of it.

Care to send it to me as a patch?

Thanks,
Rafael
