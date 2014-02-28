From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 1/3] cpufreq: stats: Remove redundant cpufreq_cpu_get() call
Date: Sat, 01 Mar 2014 00:26:23 +0100
Message-ID: <8945263.cDODqBSQxb@vostro.rjw.lan>
References: <1393552716-9754-1-git-send-email-skannan@codeaurora.org> <CAKohpomjtE7Rtrs-TgxtSo658+4p0AHLzr9niN1GnkkrDqTxTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56418 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751998AbaB1XLT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2014 18:11:19 -0500
In-Reply-To: <CAKohpomjtE7Rtrs-TgxtSo658+4p0AHLzr9niN1GnkkrDqTxTw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Friday, February 28, 2014 09:18:02 AM Viresh Kumar wrote:
> On 28 February 2014 07:28, Saravana Kannan <skannan@codeaurora.org> wrote:
> > __cpufreq_stats_create_table always gets pass the valid and real policy
> > struct. So, there's no need to call cpufreq_cpu_get() to get the policy
> > again.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> All patches look fine now. Rafael you can queue them up as per your
> convenience.
> 
> @Saravana: Though I am quite sure you still need my patches to get
> your initial issue fixed. So, can you please get them tested as early
> as possible, so that we can get them in for 3.14?

That's a bit late ...

> @Srivatsa: Your reviews will also help :)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
