From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/5] opp: handle allocation of device_opp in a separate routine
Date: Thu, 11 Dec 2014 08:45:22 +0530
Message-ID: <CAKohpoktdrOX8TDwqd-co+mNERS_NjewitDXguXDZO9bEWdFFA@mail.gmail.com>
References: <0a31e317c90f601f77cc21b80455633928c70c96.1418184737.git.viresh.kumar@linaro.org>
	<b759d2563caee1189b543d7a3acb222d316d81a1.1418184737.git.viresh.kumar@linaro.org>
	<3480697.K2MkBymPAS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:38346 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933642AbaLKDPX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Dec 2014 22:15:23 -0500
Received: by mail-ob0-f171.google.com with SMTP id uz6so1116258obc.2
        for <linux-pm@vger.kernel.org>; Wed, 10 Dec 2014 19:15:22 -0800 (PST)
In-Reply-To: <3480697.K2MkBymPAS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11 December 2014 at 03:31, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I've lost patches [1-2/5] somehow, but never mind.  I can get them from Patchwork.

Strange, you were always in --to for them ..

> In this one I'm wondering about the printk removal mentioned above.  Did
> checkpatch complain about the printk?

commit ebfdc40969f24fc0cdd1349835d36e8ebae05374
Author: Joe Perches <joe@perches.com>
Date:   Wed Aug 6 16:10:27 2014 -0700

    checkpatch: attempt to find unnecessary 'out of memory' messages

    Logging messages that show some type of "out of memory" error are
    generally unnecessary as there is a generic message and a stack dump
    done by the memory subsystem.

    These messages generally increase kernel size without much added value.

    Emit a warning on these types of messages.

    This test looks for any inserted message function, then looks at the
    previous line for an "if (!foo)" or "if (foo == NULL)" test and then
    looks at the preceding statement for an allocation function like "foo =
    kmalloc()"

    ie: this code matches:

        foo = kmalloc();
        if (foo == NULL) {
                printk("Out of memory\n");
                return -ENOMEM;
        }

    This test is very crude and incomplete.

    This test can miss quite a lot of of OOM messages that do not have this
    specific form.

    ie: this code does not match:

        foo = kmalloc();
        if (!foo) {
                rtn = -ENOMEM;
                printk("Out of memory!\n");
                goto out;
        }

    This test could also be a false positive when the logging message itself
    does not specify anything about memory, but I did not find any false
    positives in my limited testing.

    spatch could be a better solution but correctness seems non-trivial for
    that tool too.
