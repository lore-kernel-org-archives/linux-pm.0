From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 07/39] Annotate hardware config module parameters in drivers/cpufreq/
Date: Thu, 01 Dec 2016 14:19:29 +0000
Message-ID: <24569.1480601969@warthog.procyon.org.uk>
References: <CAJZ5v0h+Vfva+xB5_p8383hmoFntjGtSa7hZm0wOne-5x1wRJQ@mail.gmail.com> <148059537897.31612.9461043954611464597.stgit@warthog.procyon.org.uk> <148059543222.31612.3648801189087582676.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755026AbcLAOTc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 1 Dec 2016 09:19:32 -0500
In-Reply-To: <CAJZ5v0h+Vfva+xB5_p8383hmoFntjGtSa7hZm0wOne-5x1wRJQ@mail.gmail.com>
Content-ID: <24568.1480601969.1@warthog.procyon.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: dhowells@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, gnomes@lxorguk.ukuu.org.uk, minyard@acm.org, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> wrote:

> Whom do you expect to apply this?

I can try bearding Linus.  All of the second+ patches depend on the first, so
if nothing else, I need to get that one in the next merge window and then
send the patches to individual maintainers.

David
