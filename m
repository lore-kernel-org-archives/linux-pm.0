Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75976C4332F
	for <linux-pm@archiver.kernel.org>; Tue, 12 Apr 2022 12:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352916AbiDLMd2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiDLMdS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Apr 2022 08:33:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3306E5A148;
        Tue, 12 Apr 2022 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QpiJQfWHbBnBAAsAw08p4CUh7MIO02xp7lOV7zzMMvs=; b=OiXNRx0CqOS6fYgnuGbrwnOtga
        oTsOVpfVk14kqLP293KTqLwon1/RU1f0V62LbmzjmL7imP82ltol1wjoLfaK5t6/mY7Qs3HYWrjCh
        Z5n+mPYMAE3achGsb0prut357sV8BXJQztUV/snpOSALGUfOOSuJhtjkf8m57kQJsKhHFVlbDpcQk
        lGGfxabNbuS2WgwCRGEByKRCHhJZPawwuQVrl5wRqvyXnYTpdxrbeV45Csqkrv75mKq8zlPQZb0+T
        t2NnmHCc7N3W2eNEryJ2vUHgiBcI/JOUHyTiMW7zMbqcjpb/zO/VtRMyQFBQBvjE8/ERk+9jG/ylS
        VbeeYf+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neF2o-004JiZ-Iz; Tue, 12 Apr 2022 11:50:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6236F3001AE;
        Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3BA8B3017997D; Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Message-ID: <20220412114421.691372568@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Apr 2022 13:44:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/5] ptrace-vs-PREEMPT_RT and freezer rewrite
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Reviving the freezer rewrite that was languishing, reinvigorated by the
recent ptrace-vs-PREEMPT_RT trouble.

The first patch adds additional state to signal/ptrace stop states, this state
is then used to fix the PREEMPT_RT issue (patch #2) and allow the new freezer
to recover the special stop states (patch #5).

I'm not completely happy with the ptrace solution, but I think it solves all
the various issues I found. I still dislike wait_task_inactive() and now we
have a second copy of that :/

Please consider carefully..

---
 drivers/acpi/x86/s2idle.c         |  12 +-
 drivers/android/binder.c          |   4 +-
 drivers/media/pci/pt3/pt3.c       |   4 +-
 drivers/scsi/scsi_transport_spi.c |   7 +-
 fs/cifs/inode.c                   |   4 +-
 fs/cifs/transport.c               |   5 +-
 fs/coredump.c                     |   5 +-
 fs/nfs/file.c                     |   3 +-
 fs/nfs/inode.c                    |  12 +-
 fs/nfs/nfs3proc.c                 |   3 +-
 fs/nfs/nfs4proc.c                 |  14 +--
 fs/nfs/nfs4state.c                |   3 +-
 fs/nfs/pnfs.c                     |   4 +-
 fs/xfs/xfs_trans_ail.c            |   8 +-
 include/linux/completion.h        |   1 +
 include/linux/freezer.h           | 244 ++------------------------------------
 include/linux/sched.h             |  49 ++++----
 include/linux/sched/jobctl.h      |   8 ++
 include/linux/sched/signal.h      |  15 ++-
 include/linux/sunrpc/sched.h      |   7 +-
 include/linux/suspend.h           |   8 +-
 include/linux/umh.h               |   9 +-
 include/linux/wait.h              |  40 ++++++-
 init/do_mounts_initrd.c           |  10 +-
 kernel/cgroup/legacy_freezer.c    |  23 ++--
 kernel/exit.c                     |   4 +-
 kernel/fork.c                     |   5 +-
 kernel/freezer.c                  | 139 ++++++++++++++++------
 kernel/futex/waitwake.c           |   8 +-
 kernel/hung_task.c                |   4 +-
 kernel/power/hibernate.c          |  35 ++++--
 kernel/power/main.c               |  18 +--
 kernel/power/process.c            |  10 +-
 kernel/power/suspend.c            |  12 +-
 kernel/power/user.c               |  24 ++--
 kernel/ptrace.c                   | 185 +++++++++++++++++++++++------
 kernel/sched/completion.c         |   9 ++
 kernel/sched/core.c               |  24 ++--
 kernel/signal.c                   |  23 ++--
 kernel/time/hrtimer.c             |   4 +-
 kernel/umh.c                      |  18 ++-
 mm/khugepaged.c                   |   4 +-
 net/sunrpc/sched.c                |  12 +-
 net/unix/af_unix.c                |   8 +-
 44 files changed, 541 insertions(+), 507 deletions(-)

