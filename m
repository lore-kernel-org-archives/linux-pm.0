Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.42.129.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294763;
	b=qRBC6BkdUF+vTJ8+mSO7ozIu59MxD5QfgqSNFZunV8cxISkiiz8Hg+eIcdF9rYtNjOm9
	 7F/73K03d5vlNEEJQmRgMtdtwaIox1lmlAkq7bRwU0DhRPI6iKl4IcG/GJzjAA0464PxD
	 qF+mknN7lnTDhxTQKUanQQ463BBDkLFMY5Icay9zXqRqdhoQULVCyGbKY4NNxIsv1+Ghy
	 VloIUof8xd2RA0C/bp78GhZS6DIBWnMU98953m4ywpISL+cAOH+YmpbdpBcQTqw8zqopF
	 GTsRacI9zxrQ1pcHgJACJdEOACNCkZVxo8OWTgvAeTl3se8px1H2pwUGB2hi27DxIZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294763;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/DlhFtZZeVSJG9rk/GmS9dCDiNn4FCq66lBVAn8+8Dg=;
	b=fRxseYpsXomDWZfbnQqdjBrH9qbL676SSWdMqEbUcyJdWBWSTsyPQXrgwqn9xLUK7qyW
	 h/68Pmj10I0R0JCB65syumk7lCF7CdtZYlGvFsTEhLjC32tXUOVB97cmsmoDqWQC+kHjA
	 5WqKkWtjTxQcBg/h6JdwjbbYru76t+XXAC2PFHT8C/UiCq7fPzu3jIjWbbwusvfhtMwns
	 VDhWR6IDqyzr+r/X04+tJvPgTWfJD7TNwYatRg/qbuP/C9Og6crGW3OfCYcfagaI+iarN
	 B4VuX41UbKKNxwiAdgLlln0bolIqPvOCQdODJna2XBnAPRPbWFtP3wXTKDNbxdGLuYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ixit.cz;
	spf=pass smtp.mailfrom=ixit.cz;
	dkim=pass header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=kdyjWzTz;
	arc=none smtp.remote-ip=84.42.129.46
Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EDE606A320;
	Sat, 21 Nov 2026 20:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59EDE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ixit.cz header.i=@ixit.cz header.a=rsa-sha256 header.s=dkim header.b=kdyjWzTz
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id A8F095340517;
	Sat, 21 Nov 2026 21:59:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1795294753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/DlhFtZZeVSJG9rk/GmS9dCDiNn4FCq66lBVAn8+8Dg=;
	b=kdyjWzTzAwS83nKf6P8+RkxUYoluHIMADRci6qaL+yhlP63ZbPvsRFMl3t5CE86lm208TH
	iBKIEayADJ5DKkEHFa4hsNA0zyGrlIa4wzoGVLJNjuwvnDOuPDbul5Ph9/rFtwqAizRPS7
	wrIeyi/lirKaehOJKrIPCKL9sTubMh8=
Message-ID: <2a7f984b-dfcd-4e39-92d8-127afaa17309@ixit.cz>
Date: Sat, 21 Nov 2026 21:59:13 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] power: supply: smb347: Set the USB input current
 limit from APSD
To: admin@tsv-stahl-riesa.de, Sebastian Reichel <sre@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Bruce Robertson <brucer42@gmail.com>,
 =?UTF-8?Q?Martin_J=C3=BCcker?= <martin.juecker@gmail.com>,
 Mithil Bavishi <bavishimithil@gmail.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44@tsv-stahl-riesa.de>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44@tsv-stahl-riesa.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/11/2026 10:30, Patrick Fischer via B4 Relay wrote:
> The SMB347 driver programs the USB input current limit once at probe
> from "summit,usb-current-limit-microamp". Boards either leave it at the
> chip's NVM default, which is 900 mA on the Nexus 7 (2012), or set it to
> 1800 mA (exynos4412-p4note, omap4-samsung-espresso10). The first makes
> the original 2 A charger no faster than a PC port, the second loads PC
> ports with 1.8 A.
> 
> The charger detects the port type itself (APSD). This series reads the
> result after the input became valid, sets the limit for the port type
> (SDP 500 mA, CDP 1.5 A, DCP the DT value or 1.5 A) and reports it as
> POWER_SUPPLY_PROP_USB_TYPE. Patch 1 updates the binding text, patch 2
> makes the registers readable, patch 3 does the detection.
> 
> Measured on a Nexus 7 (2012, E1565), median current into the battery
> (bq27541) over 5-30 minutes, battery charge in brackets:
> 
>                         before (NVM 900 mA)  this series
>    laptop port (CDP)    505 mA (84-89 %)     640 mA (85-90 %)    1.5 A
>    2 A charger (DCP)    561 mA (84-86 %)     968 mA (74-78 %)    1.5 A
>                                              972 mA (79-82 %)    1.8 A *
>    same, display off    596 mA (31-33 %)    1161 mA (37-39 %)    1.5 A
>                                             1147 mA (45-47 %)    1.8 A *
> 
>    * with summit,usb-current-limit-microamp = <1800000> added to the
>      grouper DT for the test; it gives no gain over 1.5 A, so this
>      series does not touch the grouper DT.
> 
> The display was on unless noted.
> 
> The laptop port turned out to be a CDP. A PC port detected as SDP was
> not available for testing. With 1800 mA in the device tree and without
> this series, AICL ended once at the lowest step directly after boot at
> the laptop port (the battery got 120 mA); with the series it did not
> happen in seven boots and several reconnections. Directly after probe the
> charger NAKs the write to CFG_VARIOUS_FUNCTION; patch 3 therefore does
> the first detection 500 ms after probe, as after a new connection.
> A quick move from the laptop port to the charger once left the driver
> with the CDP limit (two interrupts, input state unchanged in the
> driver), so patch 3 detects the port type after every USB input
> interrupt; quick moves in both directions work with that.
> 
> There is no public datasheet with the register map that I could find.
> The STAT_D, AICL and APSD bits are taken from the Android 3.1 kernel for
> the Nexus 7 [1], which uses them the same way (900 mA for SDP, 1800 mA
> for the other types). That is why only the SMB347 uses APSD, and
> SMB345/SMB358 stay as they are.
> 
> Questions:
> 
> - Is 500 mA for an SDP acceptable? It is the USB 2.0 value, but less
>    than the NVM default of 900 mA on the Nexus 7 and than the 1800 mA
>    p4note and espresso10 use today at a PC port.
> - APSD result "other" (non-BC 1.2 chargers) gets 500 mA here; the
>    Android driver uses the charger limit. Is someone able to check the
>    meaning of the remaining STAT_D values on SMB345/SMB358?
> 
> Bruce Robertson posted an RFC for a Rust SMB347 driver [2], which does
> not handle interrupts or USB OTG yet. This series is for the existing C
> driver; I am happy to test the Rust driver on the Nexus 7 as well.
> 
> Tested with v7.4-rc3 on a Nexus 7 (2012, E1565) at a laptop port (CDP)
> and the original 2 A charger (DCP), including unplugging, replugging and
> quick moves between them.
> An SDP, chargers reported as "other" and USB host mode (OTG) were not
> tested. The series is build tested on top of power-supply for-next.
> 
> Tool use (see Documentation/process/generated-content.rst): the patches,
> their changelogs and this cover letter were prepared with an LLM coding
> assistant (Claude Code). It compared the Android and mainline drivers,
> wrote the code and drafted the texts from my measurements and
> instructions. I reviewed the changes and ran all tests on the device.
> 
> [1] drivers/power/smb347-charger.c, branch
>      android-tegra3-grouper-3.1-lollipop-release of
>      https://android.googlesource.com/kernel/tegra
> [2] https://lore.kernel.org/all/20260708214738.25008-1-brucer42@gmail.com/
> 
> ---
https://sashiko.dev/#/patchset/20261121-upstream-smb347-apsd-v1-0-ca46b92bfd44%40tsv-stahl-riesa.de

It's partly matching with Sashiko, but here is second LLM review:

   Commits Reviewed (909ef7a9a30fa..HEAD on branch test-smb347)
   1. b5983679ca5a1 dt-bindings: power: supply: summit,smb347: Clarify the USB 
current limit
   2. 94061e72ab31f power: supply: smb347: Make the APSD and AICL registers readable
   3. * 375bda07de8ee power: supply: smb347: Set the USB input current limit 
from APSD
   Build & Validation Checks

   • dt_binding_check on 
Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml: passed
   • make ARCH=arm64 LLVM=1 W=1 drivers/power/supply/smb347-charger.o (in 
temporary worktree): passed (0 warnings)
   • scripts/checkpatch.pl --strict --git 909ef7a9a30fa..HEAD: passed (0 errors, 
0 warnings, 0 checks)
   • Reachability / Kconfig / Fixes tag: REACHABILITY: confirmed; no Kconfig 
changes; not a bug-fix series (no Fixes: tag required).
   ──────
   Per-Commit Summary
   • Patch 1 (b5983679ca5a1) — 
Documentation/devicetree/bindings/power/supply/summit,smb347-charger.yaml:56-60: 
No issues found.
   • Patch 2 (94061e72ab31f) — drivers/power/supply/smb347-charger.c:1425-1469: 
No issues found.
   • Patch 3 (375bda07de8ee) — drivers/power/supply/smb347-charger.c: 5 issues 
found, written in mailing-list format to review-inline.txt (and metadata in
   review-metadata.json):
   1. Unsynchronized CMD_A_ALLOW_WRITE and shared state (smb->usb_vbus_enabled, 
smb->usb_online) (drivers/power/supply/smb347-charger.c:918-963,
   drivers/power/supply/smb347-charger.c:545-589):
       • smb347_set_writable() only toggles disable_irq()/enable_irq(), which 
blocks smb347_interrupt() but does not exclude other process-context threads.
       Previously, runtime callers were all VBUS regulator ops serialized by the 
regulator core mutex.
       • smb347_apsd_work() now holds CMD_A_ALLOW_WRITE across msleep(20) in 
smb347_set_usb_current_limit(), allowing a concurrent VBUS regulator callback (or
       smb347_remove()/smb347_shutdown()) to clear CMD_A_ALLOW_WRITE 
mid-sequence, causing the subsequent CFG_VARIOUS_FUNCTION write to re-enable 
AICL (or the
       regulator's CFG_SYSOK/CFG_OTG writes in the reverse interleaving) to be 
ignored by hardware.
       • smb->usb_vbus_enabled is checked before the up-to-2 s 
regmap_read_poll_timeout() loop without locking (TOCTOU if host VBUS is enabled 
during polling),
       and smb->usb_online is read without synchronization while 
smb347_interrupt() updates it.
   2. Missing 500 ms post-probe delay when booting unplugged (+ regmap cache 
poisoning on NAK + use_apsd probe race)
   (drivers/power/supply/smb347-charger.c:965-1005):
       • smb347_apsd_init() calls smb347_apsd_schedule(smb) expecting the 500 ms 
delay to avoid the post-probe CFG_VARIOUS_FUNCTION write NAK, but
       smb347_apsd_schedule() sets delay = 0 whenever !smb->usb_online. When 
booting on battery, smb347_apsd_work() runs immediately and still writes
       CFG_VARIOUS_FUNCTION (to drop from 900 mA / 1800 mA to 500 mA).
       • If that write NAKs, _regmap_write() in 
drivers/base/regmap/regmap.c:1988-1998 updates the maple cache before 
map->reg_write(), leaving
       CFG_VARIOUS_FUNCTION_AICL cleared in cache while still set in hardware, 
so future smb347_set_usb_current_limit() calls read aicl == false from cache and
       stop toggling AICL.
       • smb->use_apsd is also assigned after smb347_irq_init() has enabled the 
IRQ and before CFG_CHARGE_CONTROL_APSD is written, allowing an early USBIN_UV_IRQ
       to schedule apsd_work prematurely and race with smb347_apsd_init() on 
CMD_A_ALLOW_WRITE.
   3. Teardown / shutdown bugs with apsd_work and free_irq() 
(drivers/power/supply/smb347-charger.c:1821-1863):
       • smb347_shutdown() calls smb347_remove() without devres release (and 
i2c_device_shutdown() skips disable_irq() when .shutdown is defined), so a 
pending or
       polling apsd_work is never cancelled on shutdown and can keep issuing I2C 
transfers after smb347_shutdown() and parent I2C adapter shutdown.
       • On detach, devm_delayed_work_autocancel() is registered before 
devm_request_threaded_irq(), so free_irq() runs before 
cancel_delayed_work_sync(). An
       already-running smb347_apsd_work() finishing its STAT_D poll then calls 
smb347_set_writable() -> disable_irq()/enable_irq() on a freed and deactivated IRQ.
   4. POWER_SUPPLY_PROP_USB_TYPE exposed when APSD is disabled 
(drivers/power/supply/smb347-charger.c:1747-1757):
       • smb347_usb_desc unconditionally exposes usb_type advertising 
SDP/CDP/DCP on SMB345, SMB358, and SMB347 boards without an interrupt (such as 
exynos4412-
       p4note), where smb->use_apsd is false and the property stays Unknown 
permanently.
   5. Commit message inaccuracy on exynos4412-p4note 
(arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi:219-229):
       • The commit message states that exynos4412-p4note changes behaviour to 
draw 500 mA from a PC port, but exynos4412-p4note.dtsi (charger@6) has no
       interrupts property, so smb->irq_unsupported is true and smb->use_apsd 
remains false; only omap4-samsung-espresso10 is affected.


   Ruled-Out Potential Regressions

   • Ruled out regression 1: smb347_apsd_work() calling 
power_supply_changed(smb->usb) cannot dereference NULL because smb->use_apsd 
requires smb->use_usb, which
   registers smb->usb unconditionally in smb347_probe().
   • Ruled out regression 2: smb347_usb_type_current_limit() with low DT values 
(e.g. 300000 uA) or unset (0) always maps to a valid icl_tbl[SMB347] entry, and
   invalid < 300000 uA DT values are already rejected in smb347_hw_init().
   ──────
   FINAL REGRESSIONS FOUND: 5
   FINAL TOKENS USED: not exposed by runtime
   Assisted-by: Antigravity:Gemini 4 Neon
