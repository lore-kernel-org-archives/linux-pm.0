From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/2] cpufreq: Track governor-state with 'policy->governor_state'
Date: Tue,  9 Sep 2014 09:46:40 +0530
Message-ID: <0aa5f4741d082889309313ff3d9c70b39ddcb48d.1410235439.git.viresh.kumar@linaro.org>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:62588 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbaIIEQ7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Sep 2014 00:16:59 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so3889900pab.4
        for <linux-pm@vger.kernel.org>; Mon, 08 Sep 2014 21:16:59 -0700 (PDT)
In-Reply-To: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
In-Reply-To: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, robert.schoene@tu-dresden.de, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Even after serializing calls to __cpufreq_governor() there are some rac=
es left.
The races are around doing the invalid operation during some state of c=
pufreq
governors. For example, while the governor is in CPUFREQ_GOV_POLICY_EXI=
T state,
we can't do CPUFREQ_GOV_START without first doing CPUFREQ_GOV_POLICY_IN=
IT.

All these cases weren't handled elegantly in __cpufreq_governor() and s=
o there
were enough chances that things may go wrong when governors are changed=
 with
multiple thread in parallel.

This patch renames an existing field 'policy->governor_enabled' as
'policy->governor_state' which can have values other than 0 & 1 now. It=
s type is
also changed to 'int' from 'bool'.

We maintain the current state of governors for each policy now and reje=
ct any
invalid operation.

Reported-and-tested-by: Robert Sch=C3=B6ne <robert.schoene@tu-dresden.d=
e>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c          | 26 +++++++++++++-------------
 drivers/cpufreq/cpufreq_governor.c |  2 +-
 include/linux/cpufreq.h            |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a7ceae3..c597361 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -935,6 +935,7 @@ static void cpufreq_init_policy(struct cpufreq_poli=
cy *policy)
 	struct cpufreq_policy new_policy;
 	int ret =3D 0;
=20
+	policy->governor_state =3D CPUFREQ_GOV_POLICY_EXIT;
 	memcpy(&new_policy, policy, sizeof(*policy));
=20
 	/* Update governor of new_policy to the governor used before hotplug =
*/
@@ -1976,7 +1977,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 					unsigned int event)
 {
-	int ret;
+	int ret, state;
=20
 	/* Only must be defined when default governor is known to have latenc=
y
 	   restrictions, like e.g. conservative or ondemand.
@@ -2012,19 +2013,21 @@ static int __cpufreq_governor(struct cpufreq_po=
licy *policy,
 		 policy->cpu, event);
=20
 	mutex_lock(&cpufreq_governor_lock);
+	state =3D policy->governor_state;
+
+	/* Check if operation is permitted or not */
 	if (policy->governor_busy
-	    || (policy->governor_enabled && event =3D=3D CPUFREQ_GOV_START)
-	    || (!policy->governor_enabled
-	    && (event =3D=3D CPUFREQ_GOV_LIMITS || event =3D=3D CPUFREQ_GOV_S=
TOP))) {
+	    || (state =3D=3D CPUFREQ_GOV_START && event !=3D CPUFREQ_GOV_LIMI=
TS && event !=3D CPUFREQ_GOV_STOP)
+	    || (state =3D=3D CPUFREQ_GOV_STOP && event !=3D CPUFREQ_GOV_START=
 && event !=3D CPUFREQ_GOV_POLICY_EXIT)
+	    || (state =3D=3D CPUFREQ_GOV_POLICY_INIT && event !=3D CPUFREQ_GO=
V_START && event !=3D CPUFREQ_GOV_POLICY_EXIT)
+	    || (state =3D=3D CPUFREQ_GOV_POLICY_EXIT && event !=3D CPUFREQ_GO=
V_POLICY_INIT)) {
 		mutex_unlock(&cpufreq_governor_lock);
 		return -EBUSY;
 	}
=20
 	policy->governor_busy =3D true;
-	if (event =3D=3D CPUFREQ_GOV_STOP)
-		policy->governor_enabled =3D false;
-	else if (event =3D=3D CPUFREQ_GOV_START)
-		policy->governor_enabled =3D true;
+	if (event !=3D CPUFREQ_GOV_LIMITS)
+		policy->governor_state =3D event;
=20
 	mutex_unlock(&cpufreq_governor_lock);
=20
@@ -2035,13 +2038,10 @@ static int __cpufreq_governor(struct cpufreq_po=
licy *policy,
 			policy->governor->initialized++;
 		else if (event =3D=3D CPUFREQ_GOV_POLICY_EXIT)
 			policy->governor->initialized--;
-	} else {
+	} else if (event !=3D CPUFREQ_GOV_LIMITS) {
 		/* Restore original values */
 		mutex_lock(&cpufreq_governor_lock);
-		if (event =3D=3D CPUFREQ_GOV_STOP)
-			policy->governor_enabled =3D true;
-		else if (event =3D=3D CPUFREQ_GOV_START)
-			policy->governor_enabled =3D false;
+		policy->governor_state =3D state;
 		mutex_unlock(&cpufreq_governor_lock);
 	}
=20
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
index 1b44496..d173181 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -174,7 +174,7 @@ void gov_queue_work(struct dbs_data *dbs_data, stru=
ct cpufreq_policy *policy,
 	int i;
=20
 	mutex_lock(&cpufreq_governor_lock);
-	if (!policy->governor_enabled)
+	if (policy->governor_state !=3D CPUFREQ_GOV_START)
 		goto out_unlock;
=20
 	if (!all_cpus) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c7aa96b..fb20fc5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -81,7 +81,7 @@ struct cpufreq_policy {
 	unsigned int		policy; /* see above */
 	struct cpufreq_governor	*governor; /* see below */
 	void			*governor_data;
-	bool			governor_enabled; /* governor start/stop flag */
+	int			governor_state; /* Governor's current state */
 	bool			governor_busy;
=20
 	struct work_struct	update; /* if update_policy() needs to be
--=20
2.0.3.693.g996b0fd

