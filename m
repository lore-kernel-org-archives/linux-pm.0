From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 9 Mar 2015 09:36:06 +0530
Message-ID: <CAKohponwTNuSpt_i2V=i5ZgfVrNgaFwo17AUFX=CT=pcEwoDVw@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
	<CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
	<54CEF123.5050106@oracle.com>
	<CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
	<54CEF574.6040404@oracle.com>
	<CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
	<54CEF7AA.80401@oracle.com>
	<CAKohponfkJVYFTsj6ijy0iY3t-R=zN=M0ZkoDmYa-WYTzPuvmw@mail.gmail.com>
	<54CEFA23.7040705@oracle.com>
	<CAKohpomBcBVXLW-RW1VXAtkTw-BKd7tHmeFJgmf9CM3vi1Ki-Q@mail.gmail.com>
	<54CF0106.5050601@oracle.com>
	<CAKohpomYpEAeQeaB7HVT0cBT5H_P8QQ-e+FQ5OqUoOvfz2ZnOQ@mail.gmail.com>
	<54CF9209.1050403@oracle.com>
	<CABawtvPtd2Ln6ghYRHhPy5SbUZqe2yncyeOta2CLt7fV1=504A@mail.gmail.com>
	<54ED50F5.5080603@linaro.org>
	<CABawtvPQNY91jS7gUWVVUZ87SG9zjtXDmTYsi0Q7hLbH_dPYng@mail.gmail.com>
	<54EDF8FC.8060204@oracle.com>
	<CABawtvPAA2f9vv6WN98OvP3JR1UCApHtGoREpZnVkWSZGWS=kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:43971 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbbCIEGH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Mar 2015 00:06:07 -0400
Received: by obcvb8 with SMTP id vb8so27096682obc.10
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2015 21:06:07 -0700 (PDT)
In-Reply-To: <CABawtvPAA2f9vv6WN98OvP3JR1UCApHtGoREpZnVkWSZGWS=kQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ethan Zhao <ethan.kernel@gmail.com>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, ethan zhao <ethan.zhao@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, guangyu.sun@oracle.com, "sriharsha.devdas@oracle.com" <sriharsha.devdas@oracle.com>

On 9 March 2015 at 07:04, Ethan Zhao <ethan.kernel@gmail.com> wrote:
> Viresh,
>     Got that box and did some debug, found the policy->kobj is not initialized.
> So the race happened between cpufreq_cpu_get() and
> __cpufreq_add_dev(), and verified 'this' race could be fixed by commit
>
> 6d4e81e cpufreq: Ref the policy object sooner
>
>     I have reboot the box with crond for more than 12 hours, no warning found.

Oh, great. Thanks for your work Ethan. You want this to be pushed for 3.18
stable kernel, right? I will see what I can do.
