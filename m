Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAAF3A1D0C;
	Tue,  7 Apr 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554544; cv=none; b=dRGgCGMBT5H8Riizh5YFLpm9paVa+oo0+XIu64Plo3t3w2SyQeFUH1+WGhFdCAOvtobwVimk95OwPc7vwIxPyr7TTzRVWY1VORf90w5xJqWk2q87gFATk33Bq5NF08W/7SmfNL2TiOLAf7HaM9ee+SAXDOd1E1nOgWQox1eb7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554544; c=relaxed/simple;
	bh=55Rg4HxoAv/fQpLPjrTICE4dtTMumrz67bsujKUvo10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQIZ9ToTZB9R0jar7aMfOiP4DM8FGa6KTeZq5GNpD4idgQkqrnpdsNIkw4QpaYDkX7uuJ2r/OCH/b82GVU0J6ezLDjOKr3uGDKSSRe2En/399z2xwI2A+KzBOvG7Dr9f/uGxOVXdxAihzGcosgml6PABymr7nGoWabol6TkzFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: A9p7J5sEQeGeLTKIyplOSQ==
X-CSE-MsgGUID: dHAxzjt1SrOc9dc9ziYuag==
X-IronPort-AV: E=Sophos;i="6.23,165,1770566400"; 
   d="scan'208";a="145860607"
From: Tianxiang Chen <nanmu@xiaomi.com>
To: <rafael@kernel.org>
CC: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lingyue@xiaomi.com>, Tianxiang Chen
	<nanmu@xiaomi.com>
Subject: [PATCH] cpufreq: Fix race between suspend/resume and CPU hotplug
Date: Tue, 7 Apr 2026 17:35:29 +0800
Message-ID: <20260407093529.4527-1-nanmu@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BJ-MBX19.mioffice.cn (10.237.8.139) To YZ-MBX05.mioffice.cn
 (10.237.88.125)

CPU hotplug operations can race with cpufreq_suspend()
and cpufreq_resume(), leading to null pointer dereferences
when accessing governor data. This occurs because there is
no synchronization between suspend/resume operations and
CPU hotplug, allowing concurrent access to
policy->governor_data while it is being freed or initialized.

Detailed race condition scenario:

1. Thread A (cpufreq_suspend) starts execution:
   - Iterates through active policies
   - Calls cpufreq_stop_governor(policy) for each policy
   - Sets cpufreq_suspended =3D true

2. Thread B (CPU hotplug) executes concurrently:
   - Calls cpu_down(cpu)
   - Calls cpuhp_cpufreq_offline(cpu)
   - Calls cpufreq_offline(cpu)
   - Inside cpufreq_offline():
     * Stops governor: policy->governor->stop(policy)
     * Exits governor: policy->governor->exit(policy)
     * Frees governor_data: kfree(policy->governor_data)
     * Sets policy->governor_data =3D NULL

3. Race window between step 1 and step 2:
   - Thread A is iterating policies and stopping governors
   - Thread B is concurrently executing CPU offline
   - Both threads may access the same policy->governor_data
   - Thread B frees governor_data while Thread A is still using it
   - Thread A accesses freed governor_data =E2=86=92 null pointer dereferen=
ce

Similarly, cpufreq_resume() can race with CPU hotplug where governor_data
is being initialized while hotplug is trying to access it, leading to
accessing uninitialized data.

Signed-off-by: Tianxiang Chen <nanmu@xiaomi.com>
---
 drivers/cpufreq/cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1f794524a1d9..8b03785764fa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1979,6 +1979,7 @@ void cpufreq_suspend(void)
        if (!cpufreq_driver)
                return;

+       cpus_read_lock();
        if (!has_target() && !cpufreq_driver->suspend)
                goto suspend;

@@ -1998,6 +1999,7 @@ void cpufreq_suspend(void)

 suspend:
        cpufreq_suspended =3D true;
+       cpus_read_unlock();
 }

 /**
@@ -2017,10 +2019,11 @@ void cpufreq_resume(void)
        if (unlikely(!cpufreq_suspended))
                return;

+       cpus_read_lock();
        cpufreq_suspended =3D false;

        if (!has_target() && !cpufreq_driver->resume)
-               return;
+               goto out;

        pr_debug("%s: Resuming Governors\n", __func__);

@@ -2038,6 +2041,9 @@ void cpufreq_resume(void)
                                       __func__, policy->cpu);
                }
        }
+
+out:
+       cpus_read_unlock();
 }

 /**
--
2.34.1

#/******=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=
=90=AB=E6=9C=89=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=
=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=
=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=E6=AD=
=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=
=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=
=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=
=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=E6=95=A3=
=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=
=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=
=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=
=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=
=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=81 This =
e-mail and its attachments contain confidential information from XIAOMI, wh=
ich is intended only for the person or entity whose address is listed above=
. Any use of the information contained herein in any way (including, but no=
t limited to, total or partial disclosure, reproduction, or dissemination) =
by persons other than the intended recipient(s) is prohibited. If you recei=
ve this e-mail in error, please notify the sender by phone or email immedia=
tely and delete it!******/#
