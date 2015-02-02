From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 2 Feb 2015 09:29:54 +0530
Message-ID: <CAKohpom589bFL4-eyR1=qrc6uoRtjck_z_SBHS3XU8dJSc4yFg@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
	<CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
	<54CEF123.5050106@oracle.com>
	<CAKohponOvEnG2Tt5sFPLAHA_bHckHboR7t35-7ey5b_cCKfvKg@mail.gmail.com>
	<54CEF574.6040404@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35645 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939AbbBBD7z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 22:59:55 -0500
Received: by mail-ob0-f180.google.com with SMTP id vb8so14547417obc.11
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2015 19:59:54 -0800 (PST)
In-Reply-To: <54CEF574.6040404@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 2 February 2015 at 09:26, ethan zhao <ethan.zhao@oracle.com> wrote:
>  How to prevent the policy to be freed between
>
> cpufreq_cpu_get()  and cpufreq_cpu_put() ?

kobject_get() increases the reference count of a policy and the policy
will only be freed when this is zero. And it will only be zero once all
cpufreq_cpu_get() are matched with corresponding cpufreq_cpu_put().

> You are maxing up the water with sand ?

:)
