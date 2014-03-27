From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: don't print value of .driver_data from core
Date: Thu, 27 Mar 2014 16:29:37 +0530
Message-ID: <CAKohpombz9jzAs-_mpBNJyTJrrvvXVQ1L0V8fyKmB1vXpSPjmQ@mail.gmail.com>
References: <2490cd0aaeaaeb88131c8089d491c485f08da5da.1395914766.git.viresh.kumar@linaro.org>
	<20140327104842.GB27777@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41949 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755443AbaC0K7i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Mar 2014 06:59:38 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so4003914obc.19
        for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 03:59:38 -0700 (PDT)
In-Reply-To: <20140327104842.GB27777@in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>

On 27 March 2014 16:18, Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
> So after this patch, driver_data is only going to be used by drivers
> which want an "unsigned int" value to be saved along with the
> frequency in the frequency_table and for those who want to overload
> its interpretation to indicate BOOST.
>
> From the core's stand point, it is useful only for determining whether
> a frequency is BOOST frequency or not.

Yes.

> So, wouldn't it be logical to allow drivers maintain their own driver
> data since the core is anyway not interested in it, and change this
> .driver_data to "flags" or some such which can indicate boost ?

We can add another field .flags in case Rafael doesn't accept the
other proposal I sent for fixing BOOST issue.

But the point behind keeping .driver_data field here was: many drivers
have some information attached to each frequency and they are closely
bound to each other. And so it made more sense to keep them together.
This is still used by many drivers and I wouldn't like them to maintain
separate arrays for keeping this information. They are so much bound
to the frequencies at the same index, that keeping them separately
wouldn't be a good idea.
