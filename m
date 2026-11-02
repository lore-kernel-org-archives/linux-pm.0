Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627660;
	b=RXbU69QMPfe1igj47GjYdJ0IMPceUWr6rnTDmBwwc/wsWGiPpFfEhdFLqJczzBCQyxzf
	 mc3ZuKcr6Q9Yvkcs32HHAPU8e6vpSVNjFQP4RfJNcBjg8H9U9K73dwHh3kn7iuHbzplKD
	 OsrCEdcBB45/WNbMUHzJMBac2TTuew0PBgrUc7lsG/rOopjk7DzNJf2hC7UUrcyrEdsjj
	 ORJnsXcLNsRS0tzOa+NmUhxW0BKJOK1yxVnsBzpfAg11xOKehf+ts1Pk37UUZdlzZTD61
	 RKsMUxlMMfccGHb0ABLiipc4z7CgdLJpEtiYyanNW1NmpT4Ka3MXoWk1B54OAB8TgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627660;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=lCTSBvg/sVJta496EObSjzg3KWEJc4BDFGrEHVQJdC4=;
	b=AVW3hr5LU+2fEYq3zMVI9/pG0XJt6ZNLtySEPpjg15cW0xRj28jWJamJcZuzR2FUs0ye
	 FrmUkCAaiGDm38vOhvp5xjUOUD0q+gW5z2CkzAz1j0v2F5oc4lh25A7zC4VB8pd3ctRGq
	 3VIQvroW0+Ptjc/x6Ck/mLEVqJ2TtyJXgnip1dCsCHCtI9Tcg1Yssxu5WxNl8JyAQZs/T
	 C5d8kcjxpTXi1ihiehuWRfH9e6JWxbeuVu+4CijCsnldVOhJLQmIILIanpNCqf8t+2k0P
	 ZdIo1Rio/jRUgh8zDHILPmoUIZxFFGIoYyHL+BOTorYwQno95ZUis50/+Al6+InM3dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWEg0rPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3828C606A326;
	Mon,  2 Nov 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWEg0rPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675971F00A16;
	Mon,  2 Nov 2026 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627659;
	bh=lCTSBvg/sVJta496EObSjzg3KWEJc4BDFGrEHVQJdC4=;
	h=From:Subject:Date:To:Cc;
	b=BWEg0rPOtaPNDlx8uNukUpcbfb/QmAYEp+HYE+tLdPyiiHY3zRCz8qcJFmduFZeOj
	 DUpa8zpX2pkBesFQrijJa22dTTZNIgTavr+19ICx2Hae+K925ESSixkm2OQah+ZDzk
	 m9+F728SVDFi+PrOADJW3pjYXHW8FVwwFvBcUOnh2bxFiw4hye1NzlM3Gsig8bOCsX
	 3bMLxmDI3c5EWF7P330zc7Ka+56jP43GSkYe13nPMwzy7Us3fhu4wWCf2oTV1H2ABc
	 3NJ7VIlWAxx4YytBbh4zFsGwN054FLUwxC2oXq0ezoS4AKODpqx5nYCZG4TT6mko0s
	 z2fheGReIZoyg==
From: Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 0/2] Use hibernate callbacks when shutting down the system
Date: Mon, 02 Nov 2026 07:54:08 -0600
Message-Id: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MPQ6AIAxA4auQzjYBAwxexTgIFO3gT6gaE+PdJ
 Y7f8N4DQoVJoFMPFLpYeFsrTKMgzuM6EXKqhla33mjtUc6dymJQLI4HisPsXLDWJB9dgJrthTL
 f/7If3vcDsRKBmmIAAAA=
X-Change-ID: 20261006-superm1-s4-at-s5-f55b441d6c5b
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, 
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 =?utf-8?q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Eric Naim <dnaim@cachyos.org>, Bartu Alev <bartualev@gmail.com>
X-Mailer: b4 0.16.0

OEM systems that ship with Linux preloaded need to go through energy
certifications that match regulatory bodies in the regions that they
will ship.

If any of those certifications don't pass then OEMs might not be able
to ship systems preloaded in applicable regions.

Multiple models of systems are reported to fail in Linux but pass
for Windows on the exact same hardware.

By looking at a breakdown of power consumption across devices the
issue is that some devices aren't turned off when user puts the
system into S5 (shutdown).

A few years ago when I first root caused this I submitted patches
to PCI core to change the PCI policy at shutdown [1].

But through various iterations I've come up with a better approach.
Instead of changing policy in each subsystem we can instead
change our shutdown command to run hibernate callbacks for all hardware.

In order to accomplish that the last 17 kernel cycles I've been slowly
drippping changes into the hibernate code paths of all subsystems to make
sure they behave as intended.

Those are all merged as of kernel 7.4-rc1, and thus I am now ready to
start using the hibernate codepath at shutdown. This series adds that
support.

I'm not naïve; there is definitely risk involved with this change as it
will essentially affect anything running Linux that gets turned off.

To that I will say that I have been running, rebasing and iterating this
series on my personal development tree ever since December 2023.
Various rolling distro community members have also been testing iterations
of these patches in their hardware and distros.

I've also put a few guard rails in place:

1. Don't mandate hibernate support. If not compiled with it, just use
   previous shutdown paths.
2. If hibernate callback fail, emit a `pr_emerg()` message but fallback
   to previous shutdown paths.
3. Offer a kernel command line option `shutdown=legacy` that any affected
   user could use to roll back to previous behavior while we root cause
   any issues.

I did split out the kernel command line option to a second commit.  If we
later decide that we want to keep this behavior but drop the rollback knob
we can revert that commit.

Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/#t

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Mario Limonciello (2):
      PM: Use hibernation callbacks for system power off
      PM: Add shutdown=legacy command line option

 Documentation/admin-guide/kernel-parameters.txt |  4 ++++
 Documentation/power/shutdown-debugging.rst      |  7 ++++++-
 kernel/reboot.c                                 | 16 ++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261006-superm1-s4-at-s5-f55b441d6c5b

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

