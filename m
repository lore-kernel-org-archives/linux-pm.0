From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] cpuidle: governors: Move the files to the upper directory
Date: Fri, 21 Oct 2016 14:47:22 +0200
Message-ID: <CAJZ5v0jSqucMXyM7d9K2V0XA_i3kX=cF8ir-41bLgJYKJ27UGQ@mail.gmail.com>
References: <1475652794-4486-1-git-send-email-daniel.lezcano@linaro.org> <1475652794-4486-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35083 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbcJUMrZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Oct 2016 08:47:25 -0400
In-Reply-To: <1475652794-4486-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Oct 5, 2016 at 9:33 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Currently the different governors are stored in the subdir
> 'governors'. That is not a problem.
>
> However, that forces to declare some private structure in the
> include/linux/cpuidle.h header because these governor files
> don't have access to the private 'cpuidle.h' located in
> drivers/cpuidle.
>
> Instead of having the governors in the separate directory, move
> them along with the drivers and prefix them with 'governor-',
> that allows to do a proper cleanup in the cpuidle headers.

While I'm not particularly against this change, I'm sort of wondering
about the reason.

What in particular would be wrong with doing

#include "../cpuidle.h"

in a governor .c file?

Thanks,
Rafael
