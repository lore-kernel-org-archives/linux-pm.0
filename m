From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/7] cpu_cooling: Don't match min/max frequencies for all
 CPUs on cooling register
Date: Fri, 28 Nov 2014 14:49:10 +0530
Message-ID: <CAKohpo=zBD2tWWE_dZOBpu0woHv3+VTv9D+TJ+tRN6cy_ELikQ@mail.gmail.com>
References: <cover.1416980447.git.viresh.kumar@linaro.org>
	<4bb7d02f8267ad9efd4dab070d72c2f2659bc752.1416980448.git.viresh.kumar@linaro.org>
	<20141127153547.GB22851@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:36175 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbaK1JTL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:19:11 -0500
Received: by mail-oi0-f48.google.com with SMTP id u20so4427769oif.21
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:19:11 -0800 (PST)
In-Reply-To: <20141127153547.GB22851@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>

On 27 November 2014 at 21:05, Eduardo Valentin <edubezval@gmail.com> wrote:
> Shall we also review the users of this API then? Simple to double check
> if they are passing the correct value?

They weren't :).. Fixed them, patches would follow.
