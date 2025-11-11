Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EB1277CA4
	for <linux-pm@vger.kernel.org>; Tue, 11 Nov 2025 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762839654; cv=none; b=TM08tRXeyAGMQKJagg+2rpA97qQhmV3LdxzqmulKORfuOsvNUE97RoJh9OyfvlnVeDl+pM+WeXCBtrOP1SRGKTPtK17bVt+8NKSAalOFdvEheVoyCWjCgD9Y2vVgYyTVVv/YTlTJ1/YX5o6EHVeTMh/hI1J5Ak0sBhnELlMQWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762839654; c=relaxed/simple;
	bh=LiAcHNyFul4fODN5audBRVET4YeCZepfQkLmyTl5GUY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Np85i49p0vPpkOO/9+vIpCpWTQ/xFzIlIAPGLO2Yt/2VGNqyYjvNs/+fZY+ZoQ+8su4WuaGj/VzGK1ekONC7drkiXpm7EmO6rbCSVLJ219kK5y+QHJ1061pxyW6+5+6DLhI9FY6FsqyxIVzLb6QAoP4rKGzetbsT1Slpeyx7jo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFHvnyMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFHvnyMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8A6C4CEF7;
	Tue, 11 Nov 2025 05:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762839653;
	bh=LiAcHNyFul4fODN5audBRVET4YeCZepfQkLmyTl5GUY=;
	h=Date:To:Cc:From:Subject:From;
	b=mFHvnyMcFzLHgXPiLCYgZpqA4MQDo1DFlJxIFoBJTa5eVabgv0QHP8WhqXNl+R8fu
	 2wNuwsd4A9CMCrFNxZ8g0qFnrWKDXTCNXfoGvt+Dvb66tkpni7Ebu7+8BxjP/6DJb4
	 Dh8uaFljizNtvoZz18bpA+7usKDduPM+5JdqF7ERJVUL2yM/ClOpjTXbGIT6ajYoq2
	 RLhBElE8nlOJq99WWuneuWJMjOEVvwrhGIOc3BHk4L+MC4j7pYlQA2tlefuXzioCeY
	 6a1gTfZUm8feRsYZ3SZltwpaTjce3IjZmoEiVSzfDSandPBI/a9WJcdRoqUlGQzEnO
	 DSQQ9rrWzJ9qw==
Message-ID: <f175ca74-78f9-4210-8185-ada8091e95a5@kernel.org>
Date: Mon, 10 Nov 2025 23:40:52 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
From: Mario Limonciello <superm1@kernel.org>
Subject: [GIT PULL] amd-pstate content for 6.19 (11/10/25)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

   Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v6.19-2025-11-10

for you to fetch changes up to bb31fef0d03ed17d587b40e3458786be408fb9df:

   cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs 
(2025-11-10 23:35:20 -0600)

----------------------------------------------------------------
amd-pstate content for 6.19 (11/10/25)

* optimizations for parameter array handling
* fix for mode changes with offline CPUs

----------------------------------------------------------------
Gautham R. Shenoy (1):
       cpufreq/amd-pstate: Call cppc_set_auto_sel() only for online CPUs

Mario Limonciello (AMD) (6):
       cpufreq/amd-pstate: Use sysfs_match_string() for epp
       cpufreq/amd-pstate: Drop NULL value from amd_pstate_mode_string
       cpufreq/amd-pstate: Make amd_pstate_get_mode_string() never 
return NULL
       cpufreq/amd-pstate: Adjust return values in 
amd_pstate_update_status()
       cpufreq/amd-pstate: Fix some whitespace issues
       cpufreq/amd-pstate: Add static asserts for EPP indices

  drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++--------------------
  1 file changed, 15 insertions(+), 20 deletions(-)
