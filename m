Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F027FB05
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236894; cv=none; b=KHucRZqtchHgRVS+DWDZZIwrX07I9wv3g/l9EaC9S6PUclxzUwsupl7FZsnyzhH515HQa25XBEnNCC7CMq805JButzdYbcx7GTOvPW+/jhWW9i0YhVC1PGU0wkASy1j9g2krSUS5WqphZWopj1CnJWBRVhMFToOWeVjqCBrv7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236894; c=relaxed/simple;
	bh=z+ha9xShhNBlP1h9CsU7XMgXGzFq6MGGOi4LnVvTNoo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdrX2QlhD+e8o2qbnI8mZwxS4evTe9QOqUPhFH9oDnOUm9wWTVCzbrMUbIPW5WGT+VZnNtQ29I1C9AfPfRPUWDQGpZD0immookbhMCwtY4pL//44ZMBleYjJrJVyDaCJ5RzbCy9He19Pd7g//TMAcgG4icNEb1pTW3/K0tvgnqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqpeXNHF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqpeXNHF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4EBFC2BCC9
	for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780236893;
	bh=z+ha9xShhNBlP1h9CsU7XMgXGzFq6MGGOi4LnVvTNoo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AqpeXNHFKUsxodny9vQOc2kxJrbJwhjlaHB4zIM/JrxXqhEEttQ+Ym1neImc9SqRr
	 D8NRdED9XG8iHIv3Lv4BAaeEt5JB7Hb7QvDte45mLMWAvwSLW5IPF9JnWk/Xk9+q3Z
	 p32FGS9N9YxM/3wd60HxrA7KLDRDuQyBHvDn9IYjPEBEszwq6i+wNZKCc6DZii9yAj
	 dVhQghqt7rmiQVoHe0igaLxXIYrnaD6SFr5MwnIkONbI4M7c3ochMvGv36gFN2Kn8A
	 xvM0LVf3ZmubM3Nr/g897pxhIJ6ZVN3Tx/00R/jrWC7lYkNrexUQeXg6pO62E6dbja
	 MT3WOlqIZExtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id DE1C9C4160E; Sun, 31 May 2026 14:14:53 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221505] REGRESSION][amd_pstate] "EPP cannot be set under
 performance policy" (EBUSY) when switching to performance profile via PPD on
 7.1
Date: Sun, 31 May 2026 14:14:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mario.limonciello@amd.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: mario.limonciello@amd.com
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status assigned_to
Message-ID: <bug-221505-137361-GfqmnaKwUk@https.bugzilla.kernel.org/>
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

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
