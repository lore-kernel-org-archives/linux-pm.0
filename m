From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 07/11] cpufreq: Use cpufreq_policy_list for iterating
 over policies
Date: Tue, 20 Aug 2013 12:02:12 +0530
Message-ID: <CAKohpo=5u7ecGLQseyHEe3bFgNLBVexnGwEV3jTs=qcSsndQLA@mail.gmail.com>
References: <cover.1375809311.git.viresh.kumar@linaro.org>
	<e54ce908bb964d643a2bbb945ed4a8dcb3ea00bf.1375809311.git.viresh.kumar@linaro.org>
	<1582060.zfvsylJcxu@vostro.rjw.lan>
	<CAKohponkLac2GzZ5-PRoTzdx8EhuCWT-eafRtYhkJ6cN_WrXSA@mail.gmail.com>
	<CAP245DXKpDBetXHY_C0hSu0UHbeiFkhQ3r7V_3HOjQ+RkuabsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:62916 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941Ab3HTGcN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 02:32:13 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so11688oag.40
        for <linux-pm@vger.kernel.org>; Mon, 19 Aug 2013 23:32:13 -0700 (PDT)
In-Reply-To: <CAP245DXKpDBetXHY_C0hSu0UHbeiFkhQ3r7V_3HOjQ+RkuabsQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Patch Tracking <patches@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Andy Whitcroft <apw@canonical.com>

On 19 August 2013 17:15, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> Why do you create .deb packages to test development kernels? It _is_ slow.
>
> Instead I'd just add a new grub menu entry to /boot/grub/grub.cfg and
> point it to /boot/MyzImage. After a 'make install; make
> modules_install' just link /boot/MyzImage to the installed kernel in
> /boot. And then generate a new initramfs using 'update-initramfs -c -k
> <ver>'

initramfs was fixed automatically for me with make install.. Thanks it saved
lots of my time :)
