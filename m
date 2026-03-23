Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF63BE16E;
	Mon, 23 Mar 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281856; cv=none; b=Nj6wRWIKG+d6RSX4tsNZXakKTSGVnS5/WlqkHbxgt6Ol+djKoQhxqHDlvS9U70aZDCOsFjmjlVC0NuLX5Tcq9slJC9Nfhn7JKqxVwnvhJdZz/sUxVxXrUj6L0rcEPilXlVIfB3KpmyWri0FSiRsvnm2wnj5GFSEFQPnZnxEHpc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281856; c=relaxed/simple;
	bh=Y1S4gRWDT82nQeaTX8Gz/Jb68lDNGp+fLZnAgEz73ac=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lufWqtCMPDIBLZsfBx3f1vVm+AL314S6xKpUOb/GxekEhiSha01WhqQfS4ztm0k1vf1BLLzBCMh39QWm/YqbWGZPSJ+R+9/p/KClKTwup+SgW+nsRPdTfRF1wdcsV4bzbLT/Qh7EGsfqjqU3awpb6Kk/bTSErwioqCwf5NukiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuSF5TOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuSF5TOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 699C3C2BC9E;
	Mon, 23 Mar 2026 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281856;
	bh=Y1S4gRWDT82nQeaTX8Gz/Jb68lDNGp+fLZnAgEz73ac=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RuSF5TOQ4tczmlFEzU4DOTKsY4TtX4hUDUQSro3tLDWyuPzXBCGx5LHQ51gSxT8rr
	 30Nf71chte5R3Qafv9iDI7p97Fo8jixvMCqNigOy4u0bFQgRuQkCo7xQap4I/jq1Q3
	 YBZ29YpF4J7RVzeozJK/WW/JRqwGtd9PWWk9d0ZhvmznH/EtZa/KO3qcBdiPnJdbXn
	 TZEbz0mbZK+pK7JUZBhrukiNhsp7MI+5K+pc1NH5RTu50gPLKkwR257WllGakPCMBY
	 bYkKI5vHWoZoQxPDw0dbD1sufhq5jh8DlFk7SqxTpqNVQSYSUdkgGm1JpymIqNtb0o
	 nn/iXj2fiSfxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEFF483C2;
	Mon, 23 Mar 2026 16:04:16 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v3 0/2] power: supply: gpio-charger: add support for
 fast-charge timer
Date: Mon, 23 Mar 2026 17:04:05 +0100
Message-Id: <20260323-gpio-charger-timer-v3-0-885796d681a5@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVkwWkC/33NzwqDMAwG8FeRnteRVKtzp73H2ME/UQNzlVTKh
 vjuq8IuY+wS+PKRXxblSZi8OieLEgrs2T1iSA+Jaobq0ZPmNmZlwFgEY3Q/sdOxkp5EzzzG2bR
 tRZhjWWCm4uEk1PFzR6+3mAf2s5PX/iPgtv3LBdSga2uLDMoMoDOXO1M9kMixcaPaxGA+Sg4I5
 U/FRCVPuxbrqrCnFL6UdV3fb9fHQ/0AAAA=
X-Change-ID: 20251022-gpio-charger-timer-cddae1619714
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774281855; l=1525;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Y1S4gRWDT82nQeaTX8Gz/Jb68lDNGp+fLZnAgEz73ac=;
 b=maxne++y9cRaEJbfP+x+FLR324e8XhkSRWugooGHK7LUoiQIrNU15zct1vh/m8rVIZoVzFAI1
 R64jm/kq/8RDR6A2J0OUuEymRjoF7XOv81IrYxKRkRGcU4KfyaiQQWR
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

On some devices like TIs BQ24081 battery charger it is possible to activate
or deactivate a fast-charge timer that provides a backup safety for charge
termination. In case of the BQ24081 it is a fixed 7-hour timer. Add support
for enabling/disabling the fast-charge timer via GPIO.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v3:
- Add documentation for fast_charge_timer
- Add a compatible for the BQ24081 (using gpio-charger as fallback) and
  then only allow 'fast-charge-timer-gpios' for the BQ24081.
- Add sample in device-tree bindings
- Removed acked-by from Connor because device-tree bindings changed
- Link to v2: https://lore.kernel.org/r/20260109-gpio-charger-timer-v2-0-63fd1ba75830@liebherr.com

Changes in v2:
- Added Acked-by tag
- Link to v1: https://lore.kernel.org/r/20251022-gpio-charger-timer-v1-0-b557409400f2@liebherr.com

---
Dimitri Fedrau (2):
      dt-bindings: power: supply: gpio-charger: add support for fast-charge timer
      power: supply: gpio-charger: add support for fast-charge timer

 .../ABI/testing/sysfs-class-power-gpio-charger     | 14 ++++++
 .../bindings/power/supply/gpio-charger.yaml        | 22 ++++++++-
 drivers/power/supply/gpio-charger.c                | 56 +++++++++++++++++++++-
 3 files changed, 90 insertions(+), 2 deletions(-)
---
base-commit: aa2132799817fb052d95a87f0c23cc6af38541c0
change-id: 20251022-gpio-charger-timer-cddae1619714

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>


