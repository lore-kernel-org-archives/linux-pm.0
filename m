Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E918FC7B
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147495; cv=none; b=io7Io1tczJASEIy4M4kCSNQYIVNADuhnepnBezdK5/SNncvqoURAosz0Eu0rbcAxNPNnASCpKhFcw3il2a+UFTtIt4VQ0slkOH2F6Wy9awlNqPegYKR3nnWo96tj/8+3W+HaFfDrBqPbirIomusYDaS0gHgsKtdYSwpmKF0bCBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147495; c=relaxed/simple;
	bh=n9DeTBPhZjVS1M34r8TXs8JemAYhXkJjAkYmey747Lc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kcOY06nY3cQ2uKvH5vqBNOdnLhzurxd5OkSgXWEuqjOLHwGEeJc2ZmaEgFFsO207pIwysv5lg9PchLNYYrxK0P9bVOcK/MHQceZkpuIbN6CSpJL01MljWV1UtqbNHdmt1+3rNlPRu4YRLbV+9Bx6RLoZdX63DomCDGsHWaKHlBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIUgNN89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIUgNN89"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 380DFC4CEEB
	for <linux-pm@vger.kernel.org>; Mon, 28 Oct 2024 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147495;
	bh=n9DeTBPhZjVS1M34r8TXs8JemAYhXkJjAkYmey747Lc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CIUgNN89C5ddUmfdv/ITZsBT3M5xV4gayUIVAacY/7KWUHaJGk9Omhy1p8fdGClRX
	 fHqxD/DYlQ8CRDJRgflbjuEHRnKA52FjNsG+DT9zCs+5zIH0RYRNoFvsBMFJwjLxbc
	 zeRQ3NHJ+rPblzP/klVe5y0P50H1dba8d8UE9b7DLrrL0KMVBTlG36B8jUGQPJtAl6
	 MaP1DqTfXiTake1x76gGWaQi629WkcWoybsii2J0t1Hq3+8yIbNfHNzPW6AmujzrcY
	 sx32tq/g5d5JfcnjWmMox6/WNtrVZfxDxoVIIpXOQFZAgqWNGMdif1UaJKikdqDJtQ
	 KHgfMiMg5OtQw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 1D728C53BC8; Mon, 28 Oct 2024 20:31:35 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 219431] [6.12] amd-pstate / Ryzen 5xxx (Zen 3, Vermeer): Could
 not retrieve highest performance (-19)
Date: Mon, 28 Oct 2024 20:31:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-219431-137361-1YQycyhgoJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-219431-137361@https.bugzilla.kernel.org/>
References: <bug-219431-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D219431

--- Comment #12 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Something else that would be really useful to understand is whether this is
only showing up now because the error level was raised
(IE : https://git.kernel.org/superm1/c/21fb59ab4b976) or if it was there in
past kernels too, but because it was debug no one ever saw it.

Try turning up dynamic debug on arch/x86/kernel/acpi/cppc.c on an older ker=
nel
that doesn't have that commit and see if you see it there too.

I suspect the answer is yes.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
