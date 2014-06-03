From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Be friendly towards latency-sensitive
 bursty workloads
Date: Tue, 3 Jun 2014 13:48:46 +0530
Message-ID: <CAKohpokdnHag=79cXuwgNjX-k+JJU9GE3KUBhixcj3PZ6y78GQ@mail.gmail.com>
References: <20140526205337.1100.55275.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53767 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109AbaFCISq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jun 2014 04:18:46 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so5736696obc.33
        for <linux-pm@vger.kernel.org>; Tue, 03 Jun 2014 01:18:46 -0700 (PDT)
In-Reply-To: <20140526205337.1100.55275.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 27 May 2014 02:23, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:

Looks fine, some nits..

> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> -void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
> +void dbs_check_cpu(struct dbs_data *dbs_data, int cpu,
> +                  unsigned int sampling_rate)

We don't need to pass a new argument, we can get all the information from
dbs_data alone. Its already done for multiple routines. Let me know if you
find it difficult to figure out..
