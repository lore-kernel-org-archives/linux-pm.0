Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB79F438033
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751658; cv=none; b=JgzaiucLV541IZWl9bkHKVR9G1BVdEvdV2fJajbJxv0+SHdomFUf9Gm2zHbuQKM41HnasQWo5HAhjcJFCmv2qpGwVoFNlMwe5xbBJEZNUr7fUv6h1CTviiBiIr1Q2VRAq5+Aaklp7sCcZZKy+1QdGg+qf+VB4RgxFcJhxy7iTps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751658; c=relaxed/simple;
	bh=Zm7poqjZQ+v271GCBUGheeR3AiOvaj5M78I++L+5k4g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=igC/8oFoA6Bn03R5Ov1l0Chfxc3iC+sZjN2ZrU9nOhsV9/IbZk7nQrPuYOyuJN6XaEJmBiXr7DzuhRk5VaqwKwGjryDiTK681zAw03V2lOMU285V5NCBhZeTLQjcLG3WZsG5Www7Cke8LTtknEz1a6COaoejboypvHOU6TENzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMgmOKNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMgmOKNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AF21F000E9;
	Wed, 22 Jul 2026 20:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784751657;
	bh=XadH3laBKz0Z1hc7gsM312N3y/s1V6z0tczR8Wg8zGA=;
	h=Date:To:Cc:From:Subject;
	b=kMgmOKNHvuUCXzpM9qwt5Pb6OTEd0Px6FAZB5QFabwI6MHGM4KQDPzNxhuVkDxoXj
	 m0fFTZK03o/hRBUJvje3Qj0FacJDfsphNu4Le/jVDdtTmikUzV0GN6bz/x0n/V85QH
	 gxqsx76gUOQCiizuxo9uLGgc0Yzzy0/362aHNDYhV612iOLJO1EQBqWr9/n8v2C9fJ
	 lQf6ZgigSw75Ev7N49nlGjF9HhoFOZrbjJzrcUyjqHEC47047NJuMF5uzPlw4AWsL2
	 OfYzQ2RuyGKIlxJFJJlJ1JskopJAHy9IlOpODxlhVlbt/iDoUGgkXklGp8JbDk+z/s
	 Yyp07tD+6Johg==
Message-ID: <52cc1241-639d-4946-bd61-9618ac53f053@kernel.org>
Date: Wed, 22 Jul 2026 15:20:56 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate fixes for 7.2 (7/22/26)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

   Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.2-2026-07-22

for you to fetch changes up to 08fc1e7b31f8832e356ede8afae1ad1ff0d5a1fc:

   cpufreq/amd-pstate: Prevent the driver from loading on unsupported 
hardware (2026-07-22 13:45:32 -0500)

----------------------------------------------------------------
amd-pstate fixes for 7.2 (7/22/26)

* Fix a case blocking amd-pstate from binding
   when lowest nonlinear freq == minimum freq
* Stop trying to bind in guests

----------------------------------------------------------------
Mario Limonciello (1):
       cpufreq/amd-pstate: Loosen requirement on lowest nonlinear 
frequency != min freq

Rong Zhang (1):
       cpufreq/amd-pstate: Prevent the driver from loading on 
unsupported hardware

  drivers/cpufreq/amd-pstate.c | 8 +++++++-
  1 file changed, 7 insertions(+), 1 deletion(-)

