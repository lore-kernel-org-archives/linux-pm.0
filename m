Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB97322B7B
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187226; cv=none; b=IQFIH4hUS1ULrgSttD4Z9LSEUSwd5PotrqqCi1BqYO10MzkUFSZnDFEl3XC1DD0ZqkOKzhykjuv4YhspIbCGcNS6rLYh0aoqmrzd+DZKtDyMHWDFgNSu1ZsF4k1K2dCeRxfl/t8n1XF8IOFaAtabcFgbLva6n6eoNDE7huZUo4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187226; c=relaxed/simple;
	bh=b+nYnFw4xFlN1uW4ceu/1fKjl5lmddinAk9dl/ywv4Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fda+QH194V/7xQ+LdyEFjRDEHogzpUPx+wwDIott8PZRAmZ2ZdpmVF8HWGb+RaZPjW+JlkUXhDBiKSWAexSnN//+THYm/CnlBb2kkissQDkfg29Z1y2ONA975xbCnatnAR5F8AE5AadyYpya6Aqr8nE6zUEn+KIbiVPtH59Ohw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSQyUIr4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSQyUIr4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CC40C2BCB2
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 20:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778187226;
	bh=b+nYnFw4xFlN1uW4ceu/1fKjl5lmddinAk9dl/ywv4Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hSQyUIr4S6q1iCq+SIO1XaF5prhmJQrhnzpd9CDxO8yTVMQsEQqKDWhurr+xSolak
	 glITDvluoGQMqpQAypSC1+j78umqPfd/9yhPzmRb1UHxXR7aoao1XlCGCoPvmuMr01
	 ipYKPorlJKHJV0EzygW4pBuceBhjZQfMIFj7eSW4moDCUWFz2XWESKC0Ghw/Z0CAnJ
	 VGlw2WnQV6Ym8Khu3juqwOHY9ammmvy/zAYsdz8suDeEqzwd1kD5yBBucD0NpemmrW
	 8GkWMFWlS50XLWxCN8/Nlh5bYvNs6NQwaIFRQe2M/5Q8uXVkpIe4MTjtIQTINY1V3h
	 QiNj+Trw8n1ug==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70A2CC433E1; Thu,  7 May 2026 20:53:46 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 221473] amd-pstate dynamic EPP regression on Ryzen 5 3600
Date: Thu, 07 May 2026 20:53:46 +0000
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
X-Bugzilla-Changed-Fields: bug_status assigned_to attachments.created
Message-ID: <bug-221473-137361-LkDiCgoEAV@https.bugzilla.kernel.org/>
In-Reply-To: <bug-221473-137361@https.bugzilla.kernel.org/>
References: <bug-221473-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D221473

Mario Limonciello (AMD) (mario.limonciello@amd.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED
           Assignee|linux-pm@vger.kernel.org    |mario.limonciello@amd.com

--- Comment #2 from Mario Limonciello (AMD) (mario.limonciello@amd.com) ---
Created attachment 310056
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D310056&action=3Dedit
possible patch

Can you see if this patch helps - specifically in dynamic EPP turned off.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
