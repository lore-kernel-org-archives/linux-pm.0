Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276399;
	b=vSTeon0ydH34ByC0Oc3jgN76jgsPMaZL4cZfLSbKtktqqEQ4dk3kryd5EsPU3ZoVo2m9
	 Lwx7re9nndoQ1GJo4VmDmh5xaaSr17suSIYqMjoZroN9u5c0vruQvYHLcj8J1Pp/sIZVr
	 c+xXiL7pN9tKZ1I83Tq12dCsa9BIxH865OUuw3qV65F7xmym1e9fc9+1/tVho4QrNFKMr
	 0JAFV90FAW1+4OzaY97Iqeb1wxfHu7ZJjpKYyCUUg7MKYtsHkDpKn8tZWiNGUo3Dz5L7D
	 QIN6CmlIL1IR6cGp2QNnmO+x4v6yPukbRliIKpKseX8QdiNhrQnI+ebgva0UZe5/kWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276399;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8GOm5mqv/vPH3T4K7FKnmGNXu6Nbnr7Dim4Q9gPf8QE=;
	b=qHyyZK/PRn63HVJqp6vCWXQlC86SUQqY6ngkQkuIeV9JKNofGXFkJpkfHGBRDHnpf9Jz
	 /20i4bzOHojBgCAVwiWudz2KTtFNQYADED9KOZ3+uoKL2kLh9gJGW2z++xStSEB0t42Ak
	 owM1NYWiA5p4dfHRZ3+JFuM7Bqwsr71ipCu+2uPxuhyMH1ICqG5kLQFrGNWoaCGL+pX+P
	 T8PDgkszEG0IFWaY++fxHZKW6psPE+X/yZm7yJiKPC7GKn/iq7/C542JT0bI5BYMYz/Fg
	 ID9MlgVSYzlQ1afsjHmyhJ5MZeVykZdRI+FWd+iLMnEjB12UZR8F4f/GL04D2cSTtpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PD1Svb8u;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F3606A31C;
	Thu, 29 Oct 2026 12:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 578F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PD1Svb8u
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7840F1BB2;
	Thu, 29 Oct 2026 05:19:54 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.65.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BB2263F673;
	Thu, 29 Oct 2026 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793276397; bh=IRXzHZizSA8qgVC1SYHO6nGD/4m9qSUc1s3Tu/z9hSY=;
	h=From:To:Cc:Subject:Date:From;
	b=PD1Svb8uFrM+sG42iYhRGAc6HevICG+FOJHye7uL/Kut66vpCZi8LioLSmK6mNMzJ
	 Kdu44/+643OZlYzagrbvgzWh+MJJbKedqs+YLlhB+I+SDYTVaCffNX/iRr4NJ+1NoB
	 Ea99gJicVrLYFW/dvJFZW5SB1zg2arZwM9xCMYW8=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 0/2] cpufreq/amd-pstate register write fixes
Date: Thu, 29 Oct 2026 12:19:43 +0000
Message-Id: <20261029121945.854675-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two issues that popped up when trying to integrate an AMD machine into
my testing for acpi-cppc, in particular for this (otherwise
unrelated) patch:
https://lore.kernel.org/lkml/20261020121846.691218-2-sumitg@nvidia.com/

The first is rather straightforward, I think the case was just not
considered during the refactor of the Fixes commit.
The second is part of the resume handling and was introduced when
that restored the register values (DESIRED derived from policy->cur).
My platform seems to handle it well, but it's still strange
behaviour, so why not fix it.
(Also of course the resume value will generally be overwritten and
therefore 'fixed' anyway.)

Christian Loehle (2):
  cpufreq/amd-pstate: Keep minimum requests within policy limits
  cpufreq/amd-pstate: Clamp desired perf on resume

 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.34.1

