Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991C43C768E
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265300; cv=none; b=r3b2mVaXgYgS8Q3qis3HOyWfdg2EGo2THc/tFsl1ZBpEK01C2KWyCzdLvNxX4wFPv45zKQUsb+Gp/6D5oVfbZp+bsYu4+MNIq6XKluyK7lGynk9DxXOhATMMChnraab3GEfHhpbnV+Mf5yL8BFNOfsWyHCWU8yYEC9o0SdGGKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265300; c=relaxed/simple;
	bh=OsgQcZ4/PBulHvbVN8F9jYjhZtgg6w0doOwZJAIXBuE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZGpJfZvS0TS0m9aOoy8E/XjUvzJvYC1xWNKXc0Uk18IEZS0Y1xIevWztTU0Z8VyGZ9jBoW7nKrtAc+LBXFT7HQUd/CVKNFOAgqkdV8rMO3q6DM0jVS2X8Owii3ti1QDChKKRfh3pbqJbF0H0zHkfMxZcTNlvbPbFe9q0sSjb0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLliXN/T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLliXN/T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED658C2BCF5
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792265300;
	bh=OsgQcZ4/PBulHvbVN8F9jYjhZtgg6w0doOwZJAIXBuE=;
	h=From:To:Subject:Date:From;
	b=GLliXN/TwQ4vmL2IshN5oMOXrTZNQ3VkOTCoOlkdmsugHrRC3ueokhs5PBe7rLA0b
	 LSD4Th+x0ftiGw3RQM3vCGhDBiUnL5zLMkuM1cehk86NPbFFs1DAufVkqNVRLxYDC8
	 EqqXHo6tqjj1Da2R+yRPwy7oMC3ruhnVzG0iRn88DRSzdhCGotduKMp5MQnm9mH5mR
	 DcSaH4e9LunD2zR7lgeEW9Y2edHAG82t3o8BKNkqEBBmzvp3a058Jjuo5V7k6M2pbW
	 APK5e/1deYbqduJZozaafpRGFAL4WF/L8+VoZfnCDngUmsx9kHLHK8GB7YN+Z0f0DI
	 Cm5M1gB1Hp48w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id D3A9AC41613; Sat, 17 Oct 2026 19:28:19 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-pm@vger.kernel.org
Subject: [Bug 222146] New: 6.18: AMD (Ryzen 5): cannot select existing
 energy_performance_preference
Date: Sat, 17 Oct 2026 19:28:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: cpufreq
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: steffen@sdaoden.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-pm@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-222146-137361@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D222146

            Bug ID: 222146
           Summary: 6.18: AMD (Ryzen 5): cannot select existing
                    energy_performance_preference
           Product: Power Management
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: steffen@sdaoden.eu
        Regression: No

Hello!  I sail 6.18.newest and since some weeks (possibly: since "custom",
whatever this is, is listed) my self-knitted "cpupower" shell script fails =
like
so:

  /root/bin/cpupower.sh: 1: echo: echo: I/O error
  ERR:CPU 0: write for energy_performance_preference=3Dbalance_performance =
failed

Ie it cannot set that even though it is reported to exist (the script refet=
ches
what is available after settings are changed):

  CPU 0: freq: 406477-3201000; scaling: 406477-3201000; boost:0; gov: power=
save
(performance powersave); energy: performance (default performance
balance_performance balance_power power custom)

On the terminal:

  #?0|lecce:~# cat
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferenc=
es
  default performance balance_performance balance_power power custom
  #?0|lecce:~# echo balance_performance >
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
  -su: echo: write error: Device or resource busy
  #?1|lecce:~# cat
/sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference
  performance

It works when i switch to all-performance, when i build, for example:

  CPU 0: freq: 406477-4979334; scaling: 406477-4979334; boost:1; gov:
performance (performance powersave); energy: performance (performance)

And it worked everwhere just smoothly before.

Thanks again, a lot.  I love it!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
