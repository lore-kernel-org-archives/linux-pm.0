Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433C26ACC
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809747; cv=none; b=n7cfoXhe0e7siLBfhdAXJ7QowR5fhbsP00qMviFIhc5aJxyOLGXPRutX16Yic1Vas1ooe6HAyGnRcSEmED8tdbbC1DG6vxASfwzzwo3AEkCqGC3aJHThG7LWX9pG5GNIXqsQPDIaFXqCdDbLxYDRck/nsbE8JZWTwsNfAMAqrqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809747; c=relaxed/simple;
	bh=VA6GGYnGAQtH2GiILqAqJpx51JKLqt6JeCFyBK4idA4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuCdxmYRrch8Rb4J9hDG2t4Uc40ys33hw7kABmB75aLHzsdHwz1nsxYqkROMGZS7EhnZQGCq/siDclFiinZrEBTFgfVSisSpY9wwnoTgZnzQEt1vDhpOYI5Bf3m5+z+ehF9yCyMTO2Mg5yIB+E+RKI4hGrgUnz0U7PmvhVQKqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2lWmM1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2lWmM1e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DF06C2BCC7
	for <linux-pm@vger.kernel.org>; Sat, 11 Jul 2026 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783809747;
	bh=VA6GGYnGAQtH2GiILqAqJpx51JKLqt6JeCFyBK4idA4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L2lWmM1eq7leIHarDvcglN54ggkEyjQbLHU4FgCbMauxUdjFSYfe4aJ3PmIdWI6tC
	 pa+jXyXgvI+rqRnGhiVWO8FST/PWSwPUBZrpIKuG2CkUGm1j+AngxeuHye3/jcZ/d2
	 hpiCe/CQxp3aIMCUH3VsIdJpoZVwwZZqS/KRwSRn6o5NDH791h223lhl89JSvViW2u
	 3YLy4t2EwXjWI8Kg/wpajG71/1I4zljD0Owk9pKy15lkFmI9LtXDzBFRN32DIu99Z7
	 tIDgosYnNynsSQncZRiJ9KMnNpRnQtx5U+Ath7USdoer/Lb1fxTq6DIZvIejiKIXWJ
	 91T6fp7fI5X/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 43429C41612; Sat, 11 Jul 2026 22:42:27 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221744] amd_pstate / ACPI: CPU frequency locked at 520MHz when
 AC disconnected with lid closed during s2idle on HP EliteBook 6 G1ah 14
Date: Sat, 11 Jul 2026 22:42:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pepegnu@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-221744-137361-1JADY1TAvf@https.bugzilla.kernel.org/>
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

--- Comment #4 from pepegnu@gmail.com ---
Yes, plug and unplug the AC wakes all cpu-cores. (No other software kick
helps) Moreover, once this is done, I can close the lid and re-open it
multiple times, the processor cores stay awaken at 1.12-2.4 GHz just fine.

On Sat, Jul 11, 2026 at 7:33=E2=80=AFPM <bugzilla-daemon@kernel.org> wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id=3D221744
>
> --- Comment #3 from Artem S. Tashkinov (aros@gmx.com) ---
> Does unplugging it and plugging it back in help?
>
> --
> You may reply to this email to add a comment.
>
> You are receiving this mail because:
> You reported the bug.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
