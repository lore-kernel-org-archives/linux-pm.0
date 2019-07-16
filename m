Return-Path: <SRS0=uSiu=VN=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714DC7618F
	for <linux-pm@archiver.kernel.org>; Tue, 16 Jul 2019 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB45520693
	for <linux-pm@archiver.kernel.org>; Tue, 16 Jul 2019 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egoUIDoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfGPPqb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Jul 2019 11:46:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44312 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPPqb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2019 11:46:31 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so19997438qtg.11
        for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2019 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ARwvly3xwsWlnW4nq8Tw39sGQhiStpDzdFKHa3jqRs8=;
        b=egoUIDoKaQ93O5g9QejhvqI+xj0QAvO5onVphqrCu4SMfp8U3Sr27VVDTyRAwcR6ld
         3FQZj0AoySjmNrVQ/PD1ImxXC5uaUR5OtDSQIOjt48tVwbeyGUBseT565/CduKweSiEo
         6UQjdoxM23yWidB52wzrkA+XIqoGJk138512dI3P9yiPq3qbMW2ujFo840r2cch6OoTK
         VUVdzt3qQiyQwrw5G1zl6Mq0pTz6ufM+NzClNaVD7lmwH/FDMf9bjUe3vUtbUJGiNQUd
         fBBs6UpGGJjClHsVxrfguvJFVGG0aA392M0qyVUlPEwANAwOGWOxjh+AcI/Cq0rueOyw
         sKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ARwvly3xwsWlnW4nq8Tw39sGQhiStpDzdFKHa3jqRs8=;
        b=d22LCDuSb3yV/rdsar7HB+7Gpv/2HX90JK4hV9T5vMgQLxAr5IffOda1uWqQKW/pFD
         veVY/AtvO4d4TmlFtZf6qW0FLoVN4UFgW6fnDt7MMKAHsvq77GRejb5aThboSQzsAqJm
         35uLAPJcKn2RQHo0lGFfeDZj008PnSmTY3RH4YPyErA0EwHFRShlCw1qidNI5MkMWKzf
         Rw+0jTMncVTb8AHGNdgUVRpotUt4i53KB3lCrGtZyCZKerYvzvXpN5CG21Cs4yTV2OFi
         qZGdK7idxt+gnj/7qqjj8n62r6WAk93WHEWjdalrM9l69faA6xiSaH+RYuiTSuby+ykS
         HNaQ==
X-Gm-Message-State: APjAAAW5Bi3GqAUa9KnR/IsqSdh/Jcz9NWjaIW3NBqtlgZRh/KaJ6Zmt
        KVctkR1e0Yf8jmKG4Z07F+pPNrQMx56BxuXaHKTfxw==
X-Google-Smtp-Source: APXvYqx7ncg9fJXPFvCeBrUIgiO59CEIH6MvSOVe7zAEsTSMKRSqHsewoTSZmKg5qnQAdnwIQVmfxPBSZYFysY0IEDo=
X-Received: by 2002:aed:21f0:: with SMTP id m45mr23344348qtc.391.1563291989631;
 Tue, 16 Jul 2019 08:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190708084357.12944-1-patrick.bellasi@arm.com>
 <20190708084357.12944-4-patrick.bellasi@arm.com> <20190715164226.GA30262@blackbody.suse.cz>
 <20190716143417.us3xhksrsaxsl2ok@e110439-lin>
In-Reply-To: <20190716143417.us3xhksrsaxsl2ok@e110439-lin>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 16 Jul 2019 11:46:18 -0400
Message-ID: <CAJWu+opGqXG0shybpLvt5fXOe_UdoiXU-tNWjkWSrHmO+wtavw@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] sched/core: uclamp: Propagate system defaults to
 root group
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 16, 2019 at 10:34 AM Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
>
> On 15-Jul 18:42, Michal Koutn=C3=BD wrote:
> > On Mon, Jul 08, 2019 at 09:43:55AM +0100, Patrick Bellasi <patrick.bell=
asi@arm.com> wrote:
> > > +static void uclamp_update_root_tg(void)
> > > +{
> > > +   struct task_group *tg =3D &root_task_group;
> > > +
> > > +   uclamp_se_set(&tg->uclamp_req[UCLAMP_MIN],
> > > +                 sysctl_sched_uclamp_util_min, false);
> > > +   uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
> > > +                 sysctl_sched_uclamp_util_max, false);
> > > +
> > > +   cpu_util_update_eff(&root_task_group.css);
> > > +}
> > cpu_util_update_eff internally calls css_for_each_descendant_pre() so
> > this should be protected with rcu_read_lock().
>
> Right, good catch! Will add in v12.
>

Hopefully these can catch it in the near future!
https://lore.kernel.org/rcu/20190715143705.117908-1-joel@joelfernandes.org/=
T/#t
