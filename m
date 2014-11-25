From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] opp: convert dev_warn() to dev_dbg() for duplicate OPPs
Date: Tue, 25 Nov 2014 12:02:05 +0530
Message-ID: <CAKohponB8-7f345qHKW8+GZaBSr2sj7rG-M7QMaQdA9n0muUZQ@mail.gmail.com>
References: <7017fa592bdaf73c260ad001a2b7abdc8d14f08a.1416211616.git.viresh.kumar@linaro.org>
	<5171628.FRGslOuEb6@vostro.rjw.lan>
	<CAKohpomz_UiRErSsDPLWcmU4e7ocXZZu7bwCF8TvoSJupikd7A@mail.gmail.com>
	<42965945.ST26GKfzPz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:61982 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbaKYGcG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 25 Nov 2014 01:32:06 -0500
Received: by mail-oi0-f51.google.com with SMTP id e131so7803519oig.38
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2014 22:32:05 -0800 (PST)
In-Reply-To: <42965945.ST26GKfzPz@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, Stefan Wahren <stefan.wahren@i2se.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 24 November 2014 at 20:39, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I hope that doesn't happen under rcu_read_lock()?

No. Should it?

> The modification needs to be done under dev_opp_list_lock in the first place

Yeah, its there to protect against other updaters.

> in which case you don't need the _rcu version of list walking, so you simply
> can use list_for_each_entry_safe() here. The mutex is sufficient for the
> synchronization with other writers (if any).  The freeing, though, has to be

Correct.

> deferred until all readers drop their references to the old entry.  You can
> use kfree_rcu() for that.

Cool. I understood the concept atleast. And yes I followed the srcu mail from
paul as well.. Will reply there.
