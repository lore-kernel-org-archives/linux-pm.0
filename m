Return-Path: <SRS0=OwR8=D5=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11237C388F7
	for <linux-pm@archiver.kernel.org>; Thu, 22 Oct 2020 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968B22463F
	for <linux-pm@archiver.kernel.org>; Thu, 22 Oct 2020 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lechevalier.se header.i=@lechevalier.se header.b="Ao5/OEbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508795AbgJVQBX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 22 Oct 2020 12:01:23 -0400
Received: from mailrelay4-3.pub.mailoutpod1-cph3.one.com ([46.30.212.13]:19407
        "EHLO mailrelay4-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2507643AbgJVQBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:references:
         in-reply-to:message-id:cc:to:from:date:from;
        bh=XRec2U5eYGvILEmLb+y88PRCaN5teKnHukURga4/B+k=;
        b=Ao5/OEbE7FDGb3RZCsiPIywHCoKzQuXvOsrjtf+kvGRB/VGJE7DuLjORhMGHnzCGIsPka3kvB7VLo
         kCTV1DkCXdNcH6y3M41jFA018P94ybVlpfHXkV047ShinzMGBKdBd2v8gmKBbCDenTIWuWArWIHevS
         3pv+DjvhH4MO8H+iz3hJUipXYM7N6WaOVsi1rTOc77/+JTELtCpHeFdRd6XKQQCfokpp01iKkLgz5G
         ddiCqJ5TtFmscdACO7HZgY70It3M+Mu6UNbtKNw5ppGVOjCJkuGRyJ/1vMlgt7AaBFCGY6rvZ8PJb/
         eDT75u4i4JAXDibrdjxTfnEBVPesOBw==
X-HalOne-Cookie: 2816d18605ed82bcd4258802d7e8eb9d56193e05
X-HalOne-ID: 92fca5d1-147d-11eb-bb75-d0431ea8bb10
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 92fca5d1-147d-11eb-bb75-d0431ea8bb10;
        Thu, 22 Oct 2020 15:45:16 +0000 (UTC)
Date:   Thu, 22 Oct 2020 17:45:11 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>
Message-ID: <c232b2.c086afce.17550fc4644@lechevalier.se>
In-Reply-To: <20201022122949.GW2628@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr> <34115486.YmRjPRKJaA@kreacher> <20201022120213.GG2611@hirez.programming.kicks-ass.net> <1790766.jaFeG3T87Z@kreacher> <20201022122949.GW2628@hirez.programming.kicks-ass.net>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle
 core
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



---- From: Peter Zijlstra <peterz@infradead.org> -- Sent: 2020-10-22 - 14:2=
9 ----

> On Thu, Oct 22, 2020 at 02:19:29PM +0200, Rafael J. Wysocki wrote:
>> > However I do want to retire ondemand, conservative and also very much
>> > intel_pstate/active mode.
>>=20
>> I agree in general, but IMO it would not be prudent to do that without m=
aking
>> schedutil provide the same level of performance in all of the relevant u=
se
>> cases.
>=20
> Agreed; I though to have understood we were there already.

Hi,=20


Currently schedutil does not populate all stats like ondemand does, which c=
an be a problem for some monitoring software.=20

On my AMD 3000G CPU with kernel-5.9.1:


grep. /sys/devices/system/cpu/cpufreq/policy0/stats/*

With ondemand:
time_in_state:3900000 145179
time_in_state:1600000 9588482
total_trans:177565
trans_table:   From  :    To
trans_table:         :   3900000   1600000
trans_table:  3900000:         0     88783
trans_table:  1600000:     88782         0

With schedutil only two file exists:
reset:<empty>
total_trans:216609=20


I'd really like to have these stats populated with schedutil, if that's pos=
sible.

Thanks.=20

