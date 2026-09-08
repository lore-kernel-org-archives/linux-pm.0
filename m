Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE2355F53;
	Tue,  8 Sep 2026 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788841182; cv=none; b=r8wjv4QnU9ERWYhZWbq6Sx0D4P8Pa14fEgmmN8IG+c6FaoS8CW3fRZlYVk/9mqSy/8ppXhWov4kcpfKbwn91FXno7Kx9jyT/oPYObMiPRctQjKBX63gs2Ftwp/pg0+8BNbG2qJgzsW7uQFXzZoqqWLvTYZTPAEHERdXAulfaXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788841182; c=relaxed/simple;
	bh=m9KOhdAmKYGmXCbZTxGcPBFgGxnj4qLivYr70AGoJVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEQvyGW3BZ+DYGWfPtWh4/pszEE/EBQ6nkU86DNe5HELQVEQr9SmUYLlGsOBZRXLWdZJXAm4kxKDMWV49hKrAndSCLxIHvIupawAVUbvgxt4dB6QlQv5TFUzB3S6ZGNQu1wSSWoGpV1jPP0SKyLjpZAhguQA7wQFLe7MihkIAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0J+lKBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0J+lKBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A4F1F00A3A;
	Tue,  8 Sep 2026 04:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788841180;
	bh=bclTE7HDb3MJkZJGcrqaf/B/Bf+rv3+XQk7DW5rUv7c=;
	h=From:To:Cc:Subject:Date;
	b=Q0J+lKBiWk2o6KjTH9W6vvd88n6vnNV3i3bXZ14Lbp3oGWR9dVm/C/k8Q2SRkw4o6
	 4UuhtqlXwZmeRzflxY/yYZTigauXR2re5qxqIIu02VBHUkik3Y4+YQQdikGh3cze/1
	 oFUPLQphAMSYexluKwE6ZwE+y1HFNIo60zDHi8sqnPrwHdZW1iYQ3gyXWSg+2lJUMx
	 pagN7UPM6uYM3kJwEw6EeGd+0A9/5MS4zL387n9nDDfF1sYbLdn+iXEorIApd+xVZ5
	 fA9jB14uGgeEqYzMEREEl5HcxJz0xVo5z/ySa7e+5t0PnTKhwlmPZNcy6m1f2VPMZx
	 7NhIHCMqywZUA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Vishal Badole <Vishal.Badole@amd.com>,
	Richard Gong <Richard.Gong@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v2 0/3] Add support for Zen 6 client EPP tunings
Date: Mon,  7 Sep 2026 23:19:32 -0500
Message-ID: <20260908041935.402116-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zen6 client platform firmware uses EPP values differently than previous
platforms. To optimize performance and power consumption tunings are
applied that match platform characteristics.

v2:
 * Rebase on v7.3-rc2
 * Add patch for platforms missing tuning

Mario Limonciello (AMD) (3):
  cpufreq/amd-pstate: Show a warning if missing EPP tunings
  cpufreq/amd-pstate: Add per SoC and per core type EPP tuning values
  cpufreq/amd-pstate: Add EPP tunings for Zen6 client platforms

 drivers/cpufreq/amd-pstate.c | 227 +++++++++++++++++++++++++++++------
 1 file changed, 190 insertions(+), 37 deletions(-)

-- 
2.43.0

