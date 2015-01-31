From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Sat, 31 Jan 2015 06:01:07 +0530
Message-ID: <CAKohpo=xjCGb5Uqw4s2=iemNfcXcpvp2YBm2LJ4CwAO1odfNuw@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
	<4152512.pDYbpiR2EP@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:63857 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719AbbAaAbI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jan 2015 19:31:08 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so5524732obc.8
        for <linux-pm@vger.kernel.org>; Fri, 30 Jan 2015 16:31:07 -0800 (PST)
In-Reply-To: <4152512.pDYbpiR2EP@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, Ethan Zhao <ethan.zhao@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "# 3.13.x" <stable@vger.kernel.org>

On 31 January 2015 at 04:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> No, it isn't.  cpufreq_cpu_data is a pointer and doesn't need any locks to
> protect it.  What the lock does is to guarantee the callers of cpufreq_cpu_get()
> that the policy object won't go away from under them (it is used for some other
> purposes too, but they are unrelated).

Yeah, its not just locking. Otherwise the locking only at the bottom
of this routine
should have fixed it.

> That's almost correct.  In addition to the above (albeit maybe unintentionally)
> the patch also fixes the possible race between two instances of
> __cpufreq_remove_dev_finish() with the same arguments running in parallel with
> each other.  The proof is left as an exercise to the reader. :-)

Two __cpufreq_remove_dev_finish() can't get called in parallel, so it
doesn't fix
any race there :).

> Please try to improve the changelog ...

Yes.
