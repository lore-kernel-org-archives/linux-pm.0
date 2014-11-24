From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Mon, 24 Nov 2014 16:10:00 +0530
Message-ID: <CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
	<1714555.tu97zMrOn0@vostro.rjw.lan>
	<CAKohpoknu=V_wscVPWLdZO8xEGY6CVMNXuP4F76GNABnm9K4dQ@mail.gmail.com>
	<5171628.FRGslOuEb6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:50916 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbaKXKkB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 05:40:01 -0500
Received: by mail-oi0-f47.google.com with SMTP id v63so6464174oia.34
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 02:40:00 -0800 (PST)
In-Reply-To: <5171628.FRGslOuEb6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 21 November 2014 at 21:28, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> What about @dynamic instead of @from_dt?  That may apply to more use cases if
> need be.

@Paul: I am stuck at a point and need help on RCUs :)

File: drivers/base/power/opp.c

We are trying to remove OPPs created from static data present in DT on
cpufreq driver's removal (when configured as module).

opp core uses RCUs internally and it looks like I need to implement:
list_for_each_entry_safe_rcu()

But, I am not sure because of these:
http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-10/6280.html
http://patchwork.ozlabs.org/patch/48989/

So, wanted to ask you if I really need that or the OPP code is
buggy somewhere.

The code removing OPPs is:

        list_for_each_entry_rcu(opp, &dev_opp->opp_list, node) {
                srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_REMOVE, opp);
                list_del_rcu(&opp->node);

                kfree(opp);
        }

Because we are freeing opp at the end, list_for_each_entry_rcu()
is trying to read the already freed opp to find opp->node.next
and that results in a crash.

What am I doing wrong ?

--
viresh
