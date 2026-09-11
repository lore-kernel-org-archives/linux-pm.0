Received: from mta0.migadu.com (out-137.mta0.migadu.com [91.218.175.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D642F5A0E
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113753; cv=none; b=D9UwD5v5aXrGYG0iBRfXNkmuWkXhedSDFzTLBL0aFfmdMOUkjQLzAE2c9D44jJTKYctJISj0CqNY8Es10Yv8Q9rOq3uPkQ3JPX8U3j1g2K7nAzwqCSLdqaxXqok8+nwNSu2rFE1QmeflzXNdffnGqbIMKT3SszO63s1s5LkRbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113753; c=relaxed/simple;
	bh=DT3XFpe3pacIAc5YAypwgMYEhUAkDdTmk92G+6zy28I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJUWkShPje7MqZAz+xEc0X4kk44cPpwBOnbK/6LzGRUIASM6GAtaAByTDRJ/aGRzSotk9y6dJBMl5iG5GZUcAfX1s69oJV+BeHS98wWhtJ34BaK5p3Kyqz8z6wmi2puN9EfffHXCCJIMQbzU+kRq9DbJ359CHyXJxK6VBDFU/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SgMrp5Wz; arc=none smtp.client-ip=91.218.175.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SgMrp5Wz"
X-Envelope-To: linux-pm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DT3XFpe3pacIAc5YAypwgMYEhUAkDdTmk92G+6zy28I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789113748; v=1; x=1789718548;
 b=SgMrp5WztCwHb1fG1N8Vhc5ctMl0J3oIm2SdYjqGE+ScoLRW244MZpkqKztQdlfYbTpysTIr
 Nn9IUigpgHljHXNIjnQt6Rl8KxGjd+prBbZfZS/9SnAzMBEAsUH0E9ZY6sozMuHFOTA6Dc7hTmw
 b9lYRoLdA5VB0Rbhhwqns+z4=
X-Envelope-To: linux-pm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7ddc78a39b3151cc;
	Fri, 11 Sep 2026 08:02:28 +0000
X-Mizu-Trace-ID: 7ddc78a39b3151cc
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	SJ Park <sj@kernel.org>,
	peterz@infradead.org,
	paulmck@kernel.org,
	mingo@redhat.com,
	rostedt@goodmis.org,
	jpoimboe@kernel.org,
	mic@digikod.net,
	oleg@redhat.com,
	tglx@kernel.org,
	david@kernel.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	rafael@kernel.org,
	gnoack3000@gmail.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	will@kernel.org,
	boqun@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	x86@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pavel@kernel.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	longman@redhat.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	mark.rutland@arm.com,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 14/15] lib: convert process iterator to for_each_process_rculock
Date: Fri, 11 Sep 2026 15:57:59 +0800
Message-Id: <20260911075800.491472-15-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260911075800.491472-1-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
with for_each_process() loop in lib/ with for_each_process_rculock(),
which scopes the RCU read lock to the loop body via scoped_guard(rcu).

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: SJ Park <sj@kernel.org>
---
Changes in v2:
  - Rename *_rcu to *_rculock
 lib/is_single_threaded.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/is_single_threaded.c b/lib/is_single_threaded.c
index 8c98b20bfc41..4e7fe85454ab 100644
--- a/lib/is_single_threaded.c
+++ b/lib/is_single_threaded.c
@@ -26,8 +26,7 @@ bool current_is_single_threaded(void)
 		return true;
 
 	ret = false;
-	rcu_read_lock();
-	for_each_process(p) {
+	for_each_process_rculock(p) {
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		if (unlikely(p == task->group_leader))
@@ -48,7 +47,5 @@ bool current_is_single_threaded(void)
 	}
 	ret = true;
 found:
-	rcu_read_unlock();
-
 	return ret;
 }
-- 
2.25.1

