Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86505551986;
	Fri, 16 Oct 2026 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170657; cv=none; b=udsvFv8egxzZrLSEHmNAZDrF77OcdA1etF16h0Px72vF3uqdD4iGTfkTQ8ChgXFS07eI2xxcvAke0QbuTk4YYTAzwPxttNjgrRLuW2bEW9EJehcG3VRLz4UUCoR61PEUGgsMVp6rDNuxPwuJqX2KeduCxIZGj2ZJmqUkjZULi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170657; c=relaxed/simple;
	bh=W7xbTv6LVk2SPZ7FumDpd75gCS8aZPFROkF1VDLtQ9M=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s3+A+q0tPz1T7JIceQ7llR+1uMLa6TOjdIx+TdoMCRxuazhHxcBndixX3rW+VcOMG4SQVV9GwfSxEnAnX17bKXh2sS1Nk11wZ7hLu3Xa6e8WjDEly2nAAgWHmrMr6kE+Vey9YgLO6chz2SVUEGJwS8lxEpdC1BIGQhn9l9LWXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Gyh28cR0; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Gyh28cR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1792170647; x=1792429847;
	bh=gD58N0uFrmMxGVW+YSTVLDO9ivTCqwde1SgK7xA5pCM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Gyh28cR0MG05SXgd1JicviitTvjWCn2hXIoQfbNB9aQG4cKlc5ccESuXJGc3Ea4g0
	 d2jciT/Tizfef+zNfXGJ+SQWIhB8zttzCPadIuwgL8YTM0rOxWbXH0qHcyaepIOsxv
	 KXT/Gay909nkCcHYsGCIFWV8Vqv80nGnilEMWfjKCxkFYP7Tn6HCd/wdqeeyXC6fj+
	 7NYCU3/hrJcFF8UQO4sevHUh2qLlv2/5Wo8y08D0hwS1RdsrU0njvBuUSJscVMy7qv
	 L6fTpywC6eMojAbGlISpMaRhVOi7p8wjGQ4TgsoEhlIBKRwzhT4rps5RY5WPDZ+h2Z
	 nVfpMY6CLnAog==
Date: Fri, 16 Oct 2026 17:10:41 +0000
To: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>
From: verazimmerman1987 <verazimmerman1987@proton.me>
Cc: "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "superm1@kernel.org" <superm1@kernel.org>, "lsanche@lyndeno.ca" <lsanche@lyndeno.ca>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Subject: platform_profile: power-saver lost on Panther Lake when SoC Power Slider and dell-pc are both bound (low-power vs quiet)
Message-ID: <UPfoGdnS1R04q8uekSMTyes9PbDuvsGeBE42zHmsjD2xIdfPYx7ejdcpZhrxWFq6uwoMvClHTuHbrwaCh3yxD0Rw7OarNABC4dZsDra44mk=@proton.me>
Feedback-ID: 187400468:user:proton
X-Pm-Message-ID: b9e317f2340975c03edd43708d77f12298f2d894
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On a Dell XPS 14 (2026, Panther Lake, Core Ultra X7 358H) two platform
profile handlers are registered, and their choices have no common
low-power option, so the legacy /sys/firmware/acpi/platform_profile
interface exposes only "balanced performance". As a result
power-profiles-daemon cannot select a low-power firmware mode in
power-saver.

Handlers:

  platform-profile-0  name: SoC Power Slider
                      choices: low-power balanced performance
  platform-profile-1  name: dell-pc
                      choices: cool quiet balanced performance

  /sys/firmware/acpi/platform_profile_choices: balanced performance

Effect: power-saver in power-profiles-daemon leaves both handlers at
"balanced". The Dell firmware stays in its "optimized" mode, so
thermald --adaptive keeps applying the optimized DTT table (PL1
19-25 W) instead of the quiet/cool tables (PL1 15-19 W, lower skin
temperature targets). Setting the handlers individually
(dell-pc=3Dquiet, SoC slider=3Dlow-power) works and thermald picks the
"quiet" target, but the legacy file then reports "custom" and
power-profiles-daemon falls back to "balanced", so there is no
consistent way to use it.

This looks like the same class of problem as amd-pmf + asus-wmi,
which was solved by adding "quiet" as a hidden choice in amd-pmf
(commit 44e94fece517, "platform/x86/amd: pmf: Add 'quiet' to hidden
choices"). Would a similar hidden "quiet" (and perhaps "cool") choice
for the Intel SoC Power Slider, mapped to its low-power setting, be
acceptable? I'm happy to test patches.

System:
  Kernel: 7.2.9-arch1-1
  DMI: Dell Inc. XPS 14 DA14260, BIOS 1.11.0
  power-profiles-daemon: 0.30-1
  thermald: 2:2.5.13-1

Thanks,
Vera
