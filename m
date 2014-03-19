From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC v3] cpufreq: Make sure frequency transitions are serialized
Date: Wed, 19 Mar 2014 19:05:45 +0530
Message-ID: <CAKohpomQjvkAaty-nBSb=Qyxvk0RhvkwNXC9194gmYr6Vpw5WA@mail.gmail.com>
References: <2efc621827cbd96a05a3d34075154974b4816ecd.1394782795.git.viresh.kumar@linaro.org>
	<532840FD.308@linux.vnet.ibm.com>
	<CAKohpomhTJa06a1LSi9tK1+=6Y2MyidJSbYWuffAsU5KxVf7zw@mail.gmail.com>
	<53296870.5010505@linux.vnet.ibm.com>
	<CAKohpomr1s3SLs-K8+-BKguX4PyfHvSjyzd5PFjM4mJeyTj3-A@mail.gmail.com>
	<53298A7D.3080400@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:61200 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804AbaCSNfq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 09:35:46 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so3261366qcr.11
        for <linux-pm@vger.kernel.org>; Wed, 19 Mar 2014 06:35:46 -0700 (PDT)
In-Reply-To: <53298A7D.3080400@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Daniel <amit.daniel@samsung.com>

On 19 March 2014 17:45, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> +       bool                    transition_ongoing; /* Tracks transition status */
> +       struct mutex            transition_lock;
> +       wait_queue_head_t       transition_wait;

Similar to what I have done in my last version, why do you need
transition_ongoing and transition_wait? Simply work with
transition_lock? i.e. Acquire it for the complete transition sequence.
