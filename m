From: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Subject: Re: "ERROR: "__pm_genpd_add_device" ..... undefined!"
Date: Sat, 14 Nov 2015 18:31:35 +0530
Message-ID: <CANv6ZMYXm2nHr5jJ95fnAt_CGvD7SChR5FmN6sFixjAvOz_kfA@mail.gmail.com>
References: <CANv6ZMbNrzQ75F5q0zCqaTBKFyj-ke0qtghYUYGybJzUDnRCng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34330 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbbKNNBg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 14 Nov 2015 08:01:36 -0500
Received: by igvg19 with SMTP id g19so51568557igv.1
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2015 05:01:35 -0800 (PST)
In-Reply-To: <CANv6ZMbNrzQ75F5q0zCqaTBKFyj-ke0qtghYUYGybJzUDnRCng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org

Hi Rafael,

Please suggest whether 'pm_genpd_add_device' symbol can be exported to
use in a driver which will be a module rather than built-in, as per
below mail.

Thanks,
Maruthi

On Fri, Nov 13, 2015 at 8:52 PM, maruthi srinivas
<maruthi.srinivas.b@gmail.com> wrote:
> Hi,
>
> Iam new to power domain (genpd).
>
> Iam trying to use 'pm_genpd_add_device' in x86 driver built as module.
> When I compile, I get error :
> "ERROR: "__pm_genpd_add_device" ..... undefined!"
>
> Iam trying to add platform devices created using MFD framework to
> generic pm domain within my x86 driver.
>
> I see that symbol is not exported.
> Can we export the symbol for the above purpose? or am I using it in a
> wrong way ?
>
> Regards,
> Maruthi
