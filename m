Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEF48165C;
	Tue,  4 Aug 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785874326; cv=none; b=WF3IPMRRXAqXiMwHALuVtCiF6tNjhR51piM8r0wNKFBDhhHiGVS086IXkTdcuHmmg87O0Y++IwTPeMykra8SHPDam4SiaOa01EIZMlQIy4GuISzPw/oNWYr0xqbErAlat2AjWODqbqe1El/un5NVQN9vxLyAcsZwi1nBA/R1ZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785874326; c=relaxed/simple;
	bh=no6a4w1VpV2TrFyoz1YXb/vpWDVVbSGG0grpLEJx/rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUeNKpTEjGlCmsWY6MdY+m0lA3sHmez5y5DI73dtDoUh6HMvq/KEF/gjCzTFmX3pbOiqQKEcuIeKR+clvH3CMg/HdLRvJjTl1NooX8Rzoqvg2vHYW3fWIqnwJu73OsK11ZvnWzwrBvMbk2iP81B+3uiqXKHPJ0p6EmQwWNQ/dEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VR2N0fQY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VR2N0fQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6EC1F000E9;
	Tue,  4 Aug 2026 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785874324;
	bh=jCcbi2RIkeGOytDlZVMlkzb1HlKWs/CG5nCy98sOMdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VR2N0fQY7F+sHR95dPM9RQDGoW4flKh4QmlN6RVlI6VvcZ73DJwmPjzrJGJR9Eq9e
	 HEfcsa8QTC3olBK8y5v+kwt7UUiq+oejsGz27EvLSpUUcP+cRs2nVZkJHIVuHDjbJ9
	 69ZqymsGmOVgi8yahsH5bw8mUSfu2qD2z1rcL5HH1zMHXvEuCwEPaQZJuXai/OJ6Y+
	 in5dt+qeIC+QkFFh4JXu7kkNSH2Z/r9xVtNs5I3kDO5HL6nYn3MywRLip1Ku5vemda
	 98FRCx6y9eKPDVWgOdNLWMSo5qXckkH13tyRW8wi0vC7lPicz1RzjPryENsvzUE3WY
	 8SzbxxSCDRrxQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject:
 [PATCH v2 1/2] Revert "thermal/drivers/hwmon: Cleanup coding style a bit"
Date: Tue, 04 Aug 2026 22:09:10 +0200
Message-ID: <5123895.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <12947893.O9o76ZdvQC@rafael.j.wysocki>
References: <12947893.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Revert commit 030a48b0f6ce ("thermal/drivers/hwmon: Cleanup coding style
a bit") that introduced a use-after-free into the error path of
thermal_add_hwmon_sysfs() by removing a valid check from it.

Link: https://lore.kernel.org/linux-hwmon/20260803183915.4ED7D1F000E9@smtp.kernel.org/
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 597c33c8a555..ec73d03a1e60 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -212,7 +212,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 	if (new_hwmon_device)
 		hwmon_device_unregister(hwmon->device);
  free_mem:
-	kfree(hwmon);
+	if (new_hwmon_device)
+		kfree(hwmon);
 
 	return result;
 }
-- 
2.51.0




