Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C15219FA66;
	Tue, 13 Aug 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560247; cv=none; b=WmuDlj3FBLzF1+iKuTPBOzLc7Nyon/lLFUkA9+iaeiK+zX7iQlcuLaqlb3Wrz0T0TQjUCSnAEQ7F48JzMVB60YFtXzGhwpMw/NVQs0T5UzUfyoJOQgV+xFBwvcfEeHVa2XVI+JC8Z7Y37tOEjZcKH9M5fHtHdF2elkEGFWijl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560247; c=relaxed/simple;
	bh=8IhLL3z1xEqON4wCm82bS0eL6LCxkYo48zoGlA4JFsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FY/EJESacVAtjkdTnjvUHBYgqfQ67kvJKdTK89gVkp/tm9EpM3ENt7sh2xauJ644eqcjPhl7R4mzvAmdmAPmA1TsKaqjvVOc+hgPBwrXhTj81ClIpPsl/ppdIamHPGKty9UsVqcvoX+zfE6HJgZJjborL07/NAj7VRgkkL+DPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 757981688;
	Tue, 13 Aug 2024 07:44:30 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.84.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 078953F58B;
	Tue, 13 Aug 2024 07:44:01 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: vincent.guittot@linaro.org,
	qyousef@layalina.io,
	peterz@infradead.org,
	daniel.lezcano@linaro.org,
	rostedt@goodmis.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/4] sched/deadline: Clarify nanoseconds in uapi
Date: Tue, 13 Aug 2024 15:43:46 +0100
Message-Id: <20240813144348.1180344-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813144348.1180344-1-christian.loehle@arm.com>
References: <20240813144348.1180344-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify the time values of the deadline parameters of deadline,
runtime, and period as being in nanoseconds explicitly as they always
have been.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 include/uapi/linux/sched/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index 90662385689b..bf6e9ae031c1 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -58,9 +58,9 @@
  *
  * This is reflected by the following fields of the sched_attr structure:
  *
- *  @sched_deadline	representative of the task's deadline
- *  @sched_runtime	representative of the task's runtime
- *  @sched_period	representative of the task's period
+ *  @sched_deadline	representative of the task's deadline in nanoseconds
+ *  @sched_runtime	representative of the task's runtime in nanoseconds
+ *  @sched_period	representative of the task's period in nanoseconds
  *
  * Given this task model, there are a multiplicity of scheduling algorithms
  * and policies, that can be used to ensure all the tasks will make their
-- 
2.34.1

