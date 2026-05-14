Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258D319847;
	Thu, 14 May 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778800864; cv=none; b=jUDA/lhuCaoEds0uDRuKVXo/9aSGWN347UTETyKBbWu+60V6VXzFIUI5RYmCnFBkd5wPdvd0oQ6DYAs5nT2V6JtPhKFQ8yr5hzFKVB+s7brfr1jDJyypPp01Hf1UwWliqvmrTtTHwMUdwClCapBdXpYLut+RePs0MNCvEhHoWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778800864; c=relaxed/simple;
	bh=woR3eW2vN+nrbzCT/rg9ask53K0weHezP8BYoeNyT2M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aYjXRCNymSL10gNNbPw7gUnY7Tvg/49p7J0TngXy1sG+vpx7BfPsPgTSINF0PccEZola5ZOPbPPvoQmToKZflVwKuczUnjEvARpd+0drr3wFExvO68aZPFNla7NTMAG0KqsWcpxh/5Uzy3wpJ9JFz8V/9JGMLU0yNVAGyAATgBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbwhgxpG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbwhgxpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63B6C2BCB3;
	Thu, 14 May 2026 23:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778800863;
	bh=woR3eW2vN+nrbzCT/rg9ask53K0weHezP8BYoeNyT2M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nbwhgxpGApskI74n3kYSrYrG4UapXenJ8Ooo2EiQkFQcJBsnMSkRZ9So1PTGiX3W5
	 W1AkRWj2RozGO41ZpgsOoSoea3QXSQzV9iRs/38wuG8UOD3pJr0etlPqp3Xpk06C6y
	 oWCGf6LZBIZosKcfLytux6o7mm6GE8onYd5/GTyw1Ei7bwqEjETTXYLBaRVdiY3O2H
	 MUJVj9AEWEgHxkgFnpXFfyYCSHF41RwSoYN7X9KdgOAIlR/S/T0T6EqANxtqaRzIyp
	 NuDnHKyH6fc9fBdFSREn7Lo5j2HM5FCkXGP56KSAXh1CoRqUmFLuN4zXZZlKvazh3s
	 UZ2Q/Vls6kRlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD5639E4DB3;
	Thu, 14 May 2026 23:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Support BPF traversal of wakeup sources
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880080805.121176.5183470343054925054.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 23:20:08 +0000
References: <20260511174559.659782-1-wusamuel@google.com>
In-Reply-To: <20260511174559.659782-1-wusamuel@google.com>
To: Samuel Wu <wusamuel@google.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org,
 gregkh@linuxfoundation.org, dakr@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 May 2026 10:45:55 -0700 you wrote:
> This patchset adds requisite kfuncs for BPF programs to safely traverse
> wakeup_sources, and puts a config flag around the sysfs interface.
> 
> Currently, a traversal of wakeup sources require going through
> /sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to query
> sysfs is inefficient, as there can be hundreds of wakeup_sources, with each
> wakeup source also having multiple attributes. debugfs is unstable and
> insecure.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] PM: wakeup: Add kfuncs to traverse over wakeup_sources
    https://git.kernel.org/bpf/bpf-next/c/5ff44955447e
  - [v4,2/2] selftests/bpf: Add tests for wakeup_sources kfuncs
    https://git.kernel.org/bpf/bpf-next/c/9ef647114201

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


