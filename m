Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F0361974
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 11:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065866; cv=none; b=sW2Zg5ai8xuYhbJhtLNfQ3gbVbTAIXwOa85z7Ky3Jtzql+PNCczb85vTu0gFLrJ3fgBFTXIGMyXGhknYto22N1cKxY7/HGExPksPaUQFnnn0Br8+CniTqNzwBD4YInuufrxZUGF5bF4f4m9NHZbEN5QelcbKw1xfiaRM3zZYsGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065866; c=relaxed/simple;
	bh=21VCcI21oKwqVk+HwGqyB9Mh9DMXy52+lNZESlqn0Sc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SP58D3keDjhg2oWpz7TVTcsM5krqb0xw5T9jLu/PVnrLln4ORhicaSp8/wHWNWQa4qaddkpCYnd9481C1zVXNdxWAURuAca3bwujR7VStW7fyNft6WFZECqvm1kOK40duSZ0x2x0c9N60fK/N2i8sZgvShFAv0xkK0TSGRBhfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZTDnmTD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZTDnmTD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE02BC2BCFA
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 11:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785065865;
	bh=21VCcI21oKwqVk+HwGqyB9Mh9DMXy52+lNZESlqn0Sc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KZTDnmTDYMYDiQ/RdalvgOgdugyZDymKVfUlk/5UuzfXYCf1cOmNS3PZIDzQKWdyF
	 ivljLcRK8oUczPL0oiz5golEX48n0OE+ze7DrcWKn9A6dqABd/noSFKih1GDuFKPHO
	 I8XDU6hlXjS0F7MUMUBaS77LG7um/OLY1x6vKPTawXTh/WMgvgKykrG2u9dcgGOt05
	 5hopQ2QUlvEVgGGW/Ea2luzczqLzdGYJIQe+1Vm1fS4mw2Z1xuih7fJUFBOm+07qW6
	 6sIXFZjZUuUONA9bYOmoL+peDjD8EM7BUm0yxzo8qBCZS5tPKqCdySnOc7mSGRdTFm
	 rIeGzMeu2UciQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 9D71BC41612; Sun, 26 Jul 2026 11:37:45 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221795] amd-pstate: max_perf stuck at nominal_perf after boot
 on Ryzen AI 9 HX 370
Date: Sun, 26 Jul 2026 11:37:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mogdad@yahoo.Com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-221795-137361-hBkxkAVfKY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221795-137361@https.bugzilla.kernel.org/>
References: <bug-221795-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221795

--- Comment #1 from Mogdy (mogdad@yahoo.Com) ---
Created attachment 310512
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310512&action=3Dedit
acpidump

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
