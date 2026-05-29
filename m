Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA03C345F
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048616; cv=none; b=LUYfW7Wmk9OFIMYWabzwuc86ckuiVUPGVNLhTYHVOikjN63xcIDu37J3xdF1J+ybwIy59h6J/qHH+BH5tNwJoHnL3DRb76dku/UlZ9jO51wHuQBu3VBdiTucDrVf2yh7QJfLmRjuHHG5W0xRhzV18vwo3isIUM4cmA+Eo+nDrnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048616; c=relaxed/simple;
	bh=WbXkTQNs2MRcVPpNfF7QZW1ggmOOk1BXOR9sM1g0+nE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpHS6HUfBLI8wbITzc6JQtaJVhALGmMa6RF3Kru0XVm9/ibtnUNNgNyuRYwEtA4YY7T3N6geszkS0eRIvRd6vEsIwj61b8JV62bXByB4nzVS6G1xCHXmr9YW4hSOvBYwPP428w1+2m5FUje5dOzJHY9/fbVmmguTLkTM4nYpa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLwBob1o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLwBob1o"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F602C2BCF6
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 09:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780048616;
	bh=WbXkTQNs2MRcVPpNfF7QZW1ggmOOk1BXOR9sM1g0+nE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oLwBob1oWJOuxk8UCdmwiaek6ebID/8BtBgbK91EPQ1ln1ZfFyy9tYjTSWvYR4zKY
	 zAZJeD+QIpLGrKPTHAwxVSlcde4qkLsRS1uaT2V+CPwX/1Mp8quLETgsfAeeVQwisg
	 TCX1itvgBFNK/AbeeIy9wlUJGgfFf0ArI5+kyS65QNreos9jOj/vx5KJZiosI/WmI3
	 2UvxwcNNARGhP5z5DPHJF9UOp1u3TscEhT8FEXzcb9NjDV4wSQZiqtXVGQem0NfaF8
	 8V8YHJUNvP5mP/MgtaTl2jvJ/1sVh1fx79XuPO1Q9/T/477ibmNNs7TtegtROGm+Cd
	 21idhF3qn2+4w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id F0180C53BC5; Fri, 29 May 2026 09:56:55 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Fri, 29 May 2026 09:56:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221505-137361-c1CYLVp5kC@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221505-137361@https.bugzilla.kernel.org/>
References: <bug-221505-137361@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D221505

--- Comment #20 from The Linux kernel's regression tracker (Thorsten Leemhu=
is) (regressions@leemhuis.info) ---
(In reply to Sergey from comment #19)
> I don't know if this will help, but I'm having this problem on kernel
> 7.1-rc1.=20

Quite a few problems were fixed since then and a bisection likely a waste of
time. Check if 7.1-rc5 works better and report back please.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
