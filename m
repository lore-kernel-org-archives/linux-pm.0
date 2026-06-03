Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B15638C2C0
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511774; cv=none; b=N9RSo3yD2yvdhf5DkWImmGa0isVWUZ1ftINp4595FH0KjnkPBjIKtBOvrHxJACdejyl9alAAaH7thYLg1R20LhxJHmifTPdlL+8795DMe1mQpDJfkQpnWhmF/U1EiIs7T1LMi+eHnXPgsYlRH+nvqlg/+dmpq/LjQoVAv4gyXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511774; c=relaxed/simple;
	bh=QqIWfrMxgttmX39wyQcVHcYyWTKjO+J7nXkR8YHnwaU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Aqy8D1onn7fXk9i1sz+FikPgUoNBIYY5SqtS5jMaKmfMDI/IS6DyC5RBHHV1xMI0JQZBqpL4kzSqHY8LyQIY+O71wYnKDzuSlma+pCecnAe9VL/gI0FIu2EpEpcTzEn9LSxJ1rslbEfp0dVljtezzPOD91TBHU6C3aiCvECwifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPcPH9Ua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPcPH9Ua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198001F00893;
	Wed,  3 Jun 2026 18:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511773;
	bh=gBX0ZsWn3N2PxKWCnnfLYMvHLgtahuVxn5vk4S///rs=;
	h=Date:To:Cc:From:Subject;
	b=bPcPH9UaKHgtiJW3WgIJv1Yn5O9InwVVZ2GA3c1QXPl+f9qYH9Qtdx1LkyH52EFl5
	 LWxqR1XzScml7oBkGjbphU2xOdzr1kegPpqbNFzrRwhTPp8g+UoVrPOA4LIHILQQYp
	 6APE75R7M1XQtoTsozLILpzGRGnOJkn27Yrm3EbnNh30dFPKa/uvYasKUj0F9OK+gm
	 pvimg3Uoa/nc9y6WCpQwQxQw3KWQJbTb6z5+X+E+DmEdYrA+AlZYUjRF7tb5SPx+ZH
	 A1xDkiq9H9DT55EzP6692UWI1BsbVQZ8X1byeVUTDSCtLdRg63phxPejsf5wJmzMFP
	 6uE8x0ABNnQqw==
Message-ID: <2167c764-6159-4a51-b3f0-f0fbf6c147ce@kernel.org>
Date: Wed, 3 Jun 2026 13:36:12 -0500
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
Subject: [GIT PULL] amd-pstate fixes for 7.1 (2026/06/02)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

   Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git 
tags/amd-pstate-v7.1-2026-06-02

for you to fetch changes up to 5629eec1a2829871d496f3042884cdc267612f6a:

   cpufreq/amd-pstate: Fix setting EPP in performance mode (2026-06-02 
12:32:06 -0500)

----------------------------------------------------------------
amd-pstate fixes for 7.1 (2026-06-02)

* Fix a kdoc issue
* Fix an issue setting performance state in EPP mode introduced earlier in
   the cycle from new 7.1 content

----------------------------------------------------------------
Mario Limonciello (AMD) (1):
       cpufreq/amd-pstate: Fix setting EPP in performance mode

Zhan Xusheng (1):
       cpufreq/amd-pstate: drop stale @epp_cached kdoc

  drivers/cpufreq/amd-pstate.c | 2 +-
  drivers/cpufreq/amd-pstate.h | 1 -
  2 files changed, 1 insertion(+), 2 deletions(-)
