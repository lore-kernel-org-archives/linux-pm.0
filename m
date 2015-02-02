From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: Set cpufreq_cpu_data to NULL before
 putting kobject
Date: Mon, 2 Feb 2015 08:54:07 +0530
Message-ID: <CAKohpon10=xemOZkvqMTV2JbdTMXPDiW+-v52Qzm8SsNymN-Kg@mail.gmail.com>
References: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422663249.git.viresh.kumar@linaro.org>
	<54CEECF7.7020504@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33729 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbbBBDYI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 1 Feb 2015 22:24:08 -0500
Received: by mail-ob0-f177.google.com with SMTP id wp18so10935702obc.8
        for <linux-pm@vger.kernel.org>; Sun, 01 Feb 2015 19:24:07 -0800 (PST)
In-Reply-To: <54CEECF7.7020504@oracle.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ethan zhao <ethan.zhao@oracle.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, santosh shilimkar <santosh.shilimkar@oracle.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 2 February 2015 at 08:50, ethan zhao <ethan.zhao@oracle.com> wrote:
>  This seems couldn't prevent all the 'bad thing' from happening, E.G.
>
>
>  Thread A: Workqueue: kacpi_notify
>
>  acpi_processor_notify()
>    acpi_processor_ppc_has_changed()
>          cpufreq_update_policy()
>            cpufreq_cpu_get()

We take cpufreq_driver_lock() here, and so this will
block thread B.

>            beginning the deference of policy        Thread B:
>            ... ... __cpufreq_remove_dev_finish()
> cpufreq_policy_free(policy);
>
>
> Perhaps move policy->rwsem out side the policy structure is a way to avoid
> it completely.
> and you could stopping the PPC thread stepping forward as my patch as
> temporary workaround.

I couldn't understand your problem completely. Apart from giving a detailed
look of what's going on both threads, always specify where the BUG actually
is..
