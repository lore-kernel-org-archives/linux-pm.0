From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH V3 0/2] Thermal: cpufreq cooling fix
Date: Fri, 15 Mar 2013 16:44:03 +0530
Message-ID: <CADGdYn4qzhv=SV+CMHJUguJm5rgULgo3qUdBtLd2e=PBYeU1TQ@mail.gmail.com>
References: <177643.168791363345666297.JavaMail.weblogic@epml10>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:64825 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809Ab3COLOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 07:14:07 -0400
Received: by mail-ia0-f174.google.com with SMTP id k38so3098770iah.33
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 04:14:06 -0700 (PDT)
In-Reply-To: <177643.168791363345666297.JavaMail.weblogic@epml10>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, Gu1 <gu1@aeroxteam.fr>, Hongbo Zhang <hongbo.zhang@linaro.org>, amit kachhap <amit.kachhap@gmail.com>

Hi Rui,

For both the patches,
Acked by: Amit Daniel kachhap <amit.daniel@samsung.com>

Thanks,
Amit Daniel

On Fri, Mar 15, 2013 at 4:37 PM, AMIT DANIEL KACHHAP
<amit.daniel@samsung.com> wrote:
>
>
> ------- Original Message -------
> Sender : Zhang Rui<rui.zhang@intel.com>
> Date   : Mar 12, 2013 00:33 (GMT+09:00)
> Title  : [PATCH V3 0/2] Thermal: cpufreq cooling fix
>
> cpufreq cooling uses different frequencies as different cooling states.
>
> But the per_cpu cpufreq_frequency_table may contain duplicate,
> invalid entries, and it may be in either ascending or descending order.
> And currently, code for parsing the per_cpu cpufreq_frequency_table
> is used in several places and inconsistent.
>
> To fix this,
> New code is introduce in Patch 1/2, which contains the logic
> of parsing per_cpu cpufreq_frequency_table, and this piece of
> code can be used to:
> 1. get the maximum cooling states
> 2. translate cpu frequency to cooling state
> 3. translate cooling state to cpu frequency
>
> Patch 2/2 converts exynos_thermal driver to use the new code
> introduced in Patch 1/2.
>
> History:
> V3: fix wrong return value of get_cpu_frequency().
>     fix wrong return value of get_property() when property equals GET_MAXL.
>
> V2: remove cpu cooling table to avoid extra memory allocation.
>
> V1: introduce code to convert per_cpu cpufreq_frequency_table
>     to clean cpu cooling table (no invalid entry,
>     no duplicate entry, in descending order).
>
> I just run build test here. It would be great that some of you
> can test it on exynos.
> any comments?
>
> thanks,
> rui
> <p>&nbsp;</p><p>&nbsp;</p>
