Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB739331EA8
	for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503252; cv=none; b=WttMyHqIJAfMrwxEJTZG1WDOrH8QErF6i3fUTcnrY0aic3e612Nqns0VtccsRenwo7fT7E/VyNw4d2UK8fluOkC2NOshTZfRBjTP5KCX8RFzirHO53BupsStqW/waMIjF31yEnqI2Hth1H60NcmWkb0kAcFJAQZzUYjLj9WoW9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503252; c=relaxed/simple;
	bh=/BmFo+4B8BJKStw9tjIO+Mf+W4Ya7v8vTOq0zh8E4jM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fdJsPOjhNYzXzLeEAKizLizSV9+Jxsbanw5p6pZf44aA1rFPpIcserP9EasSILt+pgjgQy+OVqQI/IBfIiWp7Ep5yCUJdxUU3U6aXk0+wH0C9vZIqWGu0RINBfAaGaMjxzngKMYEzpChxjtHBhpTD68/5Mhzfnf16vxkdHxBBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSt4fWTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSt4fWTv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BCC1C2BCFB
	for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2026 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787503252;
	bh=/BmFo+4B8BJKStw9tjIO+Mf+W4Ya7v8vTOq0zh8E4jM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TSt4fWTvNMGI6GPwnqnQ03bFrZLShx4KAXEEeQhBmHCmFOo5AIzOdC48hwndjQYa7
	 oTJzi5/iUSVjJF7dXFxkGPHR+bJMdb0lEtRlH8v2w5vPZzOoXuUDSjZ0yjRcotvILE
	 Ria5o4BOZtHg6v+pAtmgbHlSp+Mbd7MqNdnNbcpabRh0tp7hSyIdgOqDFB5oJNZ5t5
	 xtJQiERu0T/Ff5BAWU2NjXm2ZIOYHxB+cnos5Rz2oFTVMsO1X8KAPf6o1gknlq1prw
	 k4lju9mBGLUt9a/NvuaCqnhnz+UKo1bGnhAKidyqc+r3gmJQPfbnztCAaSH7eNVb7I
	 KcjCRZXocUqYA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 108FFC433E1; Sun, 23 Aug 2026 16:40:52 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221909] amd-pstate: Cezanne (Ryzen 7 5800U) data fabric sync
 flood on DC gated by CPPC max_perf
Date: Sun, 23 Aug 2026 16:40:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: l.perneel@luperco.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-221909-137361-dSnwMDiXfT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221909-137361@https.bugzilla.kernel.org/>
References: <bug-221909-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221909

luc (l.perneel@luperco.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |l.perneel@luperco.com

--- Comment #2 from luc (l.perneel@luperco.com) ---
I would like to add the following link:
https://gist.github.com/eliottness/ded6bce8163689dc426732d0670c7a28 which
contains more background and tests done.

There are several people hit by this issue, which was not a problem in older
kernels. Not sure when it was introduced, but my machine has run more than a
year stable, until an update caused it to take a newer kernel... since then=
 I
have such a failure on average each 14 days.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
