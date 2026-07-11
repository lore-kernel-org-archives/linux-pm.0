Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6D1D45E8
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783769759; cv=none; b=rXCdIjyhSAztw2u4qZ6PAh/8h64Nz7LVnreuea7sKTFi7tMpyPx/emAl5SG9ckKZPrFFq+1PWJrNnhII3DzOqX6KzPL8JTdDQVmonJXpy3eQRqG+wv80xjdo5bKkFeoWOgjc62L/LMxFT4TR3gJahkTNvhJcUjOFI+P2NQYapCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783769759; c=relaxed/simple;
	bh=FMI0p62p5IC0DiVEvrysLH463//QVmCOJfw1cIOYtdQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=igqZ7ncuMnZe6VxehefGjPM6UTS73mW01AKNz3oQT/lM0kYoLTGkfYm8P4i+SLfqspk3I6POa9QSH14JElZV7bN2G2tNxtz8Xn0ZZCaF4eeI+6nHZN36NEW3PSRnWw8XdPWgB6KOiwBlvWLMslcd8Cq3wnogMNlzXmvAh7dEOCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh96YNv3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh96YNv3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABBA9C2BCB3
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783769758;
	bh=FMI0p62p5IC0DiVEvrysLH463//QVmCOJfw1cIOYtdQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Dh96YNv3zAtqp3DuwWt0cPxac7oEvhB61waeq5f7JFJ3bZXG2pi9VR3Atd7zAy3yA
	 Osd36D8IFLGSznEjvGJFrRtGm/PDkXEIsyRjOfMycD63J7ggO/goWCyJzGKbQhJpma
	 00H1TSLEkkHabwazU7qBgR9geuBgLOuG5n1fGoc8ZAvK7qvmCRUGJ3qqja7T8VF0V4
	 C0Z+kaCetDjR+Up1pEAEgE7+PTrj5y/uYVrTiT6XfQgo9YSuSJ+rY/SQ21VLwMMLfb
	 pV5gM7XEk5282qAvPjhQ2LkyyAX0/NvWw/miGxvkQQrIw2V+FiSHLd5F21lksLfs+A
	 BKd6Qm25vXJUw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 8FF99C41612; Sat, 11 Jul 2026 11:35:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221744] amd_pstate / ACPI: CPU frequency locked at 520MHz when
 AC disconnected with lid closed during s2idle on HP EliteBook 6 G1ah 14
Date: Sat, 11 Jul 2026 11:35:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221744-137361-GIqNWahat7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221744-137361@https.bugzilla.kernel.org/>
References: <bug-221744-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221744

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |mario.limonciello@amd.com

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
Looks like a dupe of bug 218305.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
