Return-Path: <SRS0=LDln=2B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10682C43603
	for <linux-pm@archiver.kernel.org>; Wed, 11 Dec 2019 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73922053B
	for <linux-pm@archiver.kernel.org>; Wed, 11 Dec 2019 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576057957;
	bh=/Q8K9m7bLUS1Wl9b0/6U6Vy+QE8BOUQfzq7CUqu+0wQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jUOSDesaK+6MZv2F2fkMcgTng/7XNqMMnJUzzmzg8Wl9MDwDDt1Edr0eVya+GobGR
	 zQdvc4qe1LwydjGCAU8yhddSxgwzI7LXQHXkmHE8PNy3TvgsJzv1IFA5APWK+I3Btp
	 63yKJ8HpEht/xqjgs3TFaMsQLpaV9OBtCmQIoUaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfLKJwh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:52:37 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39649 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbfLKJwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 04:52:37 -0500
Received: by mail-ot1-f41.google.com with SMTP id 77so18254737oty.6
        for <linux-pm@vger.kernel.org>; Wed, 11 Dec 2019 01:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VYbMrpAPVUP++42+if6/sOAJ6aqp54klXfwh9b8UiI=;
        b=JhmXtbTosb5/lPM2cAaY9bbnCVnDdII1BtL2kVU+5D56v8XT/OpAdXAf77DBCufnfw
         qxqm4xCpYvJ+hJ+lZmiUE/LmC/9DKHRFPgIXMPudf66d/pZBPsSBCMjUXN1x0ZfYXj4f
         cVu7i9Zc/5hDizQShi9PbnFyiszBLsmGHnxq0qXqh1szPIVO5w4AalD4nT5z96KARzMH
         GATwm3kKsvRjMXTH/1JkzQdbnUQGGPUQw3fQrGSDrLA0Uesyag4D5p1UVSIMYOuTD/5e
         Ro/guvTj29uFZWSo5uRTpeSfQbvpD3XOGErA+oQ+4UvBVr5Rq1CuAUkcnzOufdk2tWBl
         YxfQ==
X-Gm-Message-State: APjAAAWW1ukGjULeMljLDARKhKpzNkXAmEY2WHi552vQbI9mP+jEYCM3
        4UOSGqG8Q3kZSqUXxQFveh6swlDB+Xf+MkKO9Cc=
X-Google-Smtp-Source: APXvYqwbjdUhbVprV8OnOXcs2lz0eNVF/OUlpcMJfeS0wLIcQtsYz8p02cguUyXF8K0MAMlsL3Mzh1cJrsG4neMvnM4=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr1688428otd.266.1576057956020;
 Wed, 11 Dec 2019 01:52:36 -0800 (PST)
MIME-Version: 1.0
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916C7E77C885343B2B961CFF55B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <5310126.hg2rr5Fjtk@kreacher> <7233060.oySJ2cjCuV@kreacher>
 <AM0PR04MB4481EDA9EB0374E698A6754C885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <CAJZ5v0g15AupBe05kN5Mp8NRQYgTEwd80QoJ3kTajnnfD51O6w@mail.gmail.com> <AM0PR04MB4481ACE3187E2698145A7784885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4481ACE3187E2698145A7784885A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 Dec 2019 10:52:24 +0100
Message-ID: <CAJZ5v0iZj+J=HonFqyThPHgPz=Eifw4Cbuws8r6F4ZA3Svf5Lw@mail.gmail.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 11, 2019 at 10:43 AM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
> >
> > On Wed, Dec 11, 2019 at 9:59 AM Peng Fan <peng.fan@nxp.com> wrote:

[cut]

> > But preventing CPUs with NULL cpufreq_update_util_data pointers from
> > running cpufreq utilization update code at all (like in the last
> > patch) should be sufficient to address this problem entirely.  At least I don't
> > see why not.
>
> I just think the scheduler want to inject irq_work on the cpu even during the
> cpu offlining process, but we not inject irq work with your patch. Is this right?

Yes, but that means that we just avoid a cross-update which would be
discarded due to the policy->cpus mask check without
dvfs_possible_from_any_cpu.

The target online CPU will run this update by itself eventually anyway.
