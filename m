Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717A93126B4
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673386; cv=none; b=UNJK0QOo4NpzMWEEb+USvlSJRRvnVUxBBhCyCLTpTC5CL+VjBNhqk8Q2OB+w+dBOviN5TG6WFXQl1RcsbEJmo1b9bVjbMH09QYzeU0PVSBSNpe3s0+BnBYhAFZWH0cH6KhQKIyYDeo0tN4xswV0rHJlL7WAGWIXZHgGwXWY22Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673386; c=relaxed/simple;
	bh=SMl3Wrxpjqp4zhVjwehql/YPr5mXgBPXeb73M3/+5uw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dfXDuDhEwFy6oWs8Z1I1ADeTiXTlGE0cpNQUzrd2Q9Vc3XF78rrDq04msygsb1zLp/CJ6Q/PyFZK3nugqa5Q1ehhXLjvMgqjgzMrXlqcvZn1qe0rolxW/E0V+PXQd1tZJN3xeaJBupOlw3wYJiYea3j9d4QN77XgebVOJJBxVUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbvvj7PX; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbvvj7PX"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127337c8e52so87454096c88.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773673385; x=1774278185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1mIGKHhFEp4UVK+eulXpjau2QaiKJ+LkKKD5Vd3/77g=;
        b=nbvvj7PXhddDv96qWRhlnGwFStf14HB5sXtVq2h4vTsYow6ve4ldFshARGhhRv+TQj
         x+GCKt6ZPeAOU4T4VNSMpvTCWlMkkQ7EizbHOG7zFevMip2gzH7i0f52Zpp6626BT5Cn
         l5uqnAGrnZ6zOl1Sf4oeaubyph/o/RjXcwVOWFQuFfsvzZvxYG+BFkr6Q9IhhtVNEciK
         tFn/3khq1wsePGjYyVlM1MKKxfKnsljl2pOItZFqQlHaNrwQ0jIieSz335RBFxoAhAMw
         AH7HJ2Xi7PAF9TEnRd9rUI7u2l60/MEz0O8jZy7ZNo70e3lvSYuxZU385AA0n0FuTyQ6
         5Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673385; x=1774278185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mIGKHhFEp4UVK+eulXpjau2QaiKJ+LkKKD5Vd3/77g=;
        b=NcadrEt80r7+mTSvZzYIpge5QRMSr/ZXJsz+qHMoewMD7KkUwjzHWgOolce421s6GH
         jzu8ZMz7gC7h5C93cydnilCfN2Pvq+M70OfYMf6zBC5fjhLjxdAo+49qPk2I2HH8krYF
         juG/B1wxfyJTf1R+uYfe39mN+foW5FSvrYqROQDdHiHWX2X73opQMqO3FEPZB1hqNwdy
         vD3bSimXvC65QKfMwuh41D02mTlKquoFS4IpyLZdtyyp4Ap/7KAZsBmX+iex4mk7Ec3p
         jT61FrMlRAcKKC24M1Qh0xRVWCVcIaBg9uS++cPei7/45JaOUI8CBMccLS0RdqKqo7ht
         8biw==
X-Forwarded-Encrypted: i=1; AJvYcCWsPi358wGZLZ1O67pTkMIyWZM0COKNpwyPqdF1b4LipUDusgbGWFEs4pfpN95cACXNJdU+SFmgWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iMp6ydxHNOL38nt4VZcGJ04W/XRpdmDjrthvwh4BM0uZ/9eX
	ffsNP3BmHbwD8OY4A4zZ6RSaBTtww6+ZcJ6uzElEIacgBxoLwUNPjeiGulqfdV9FmGgQJH8qUKJ
	gi/O2UA==
X-Received: from dlbtu10.prod.google.com ([2002:a05:7022:3c0a:b0:128:cffb:50d7])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6b98:b0:124:8d7d:2d63
 with SMTP id a92af1059eb24-128f3e24bb3mr6179621c88.35.1773673384259; Mon, 16
 Mar 2026 08:03:04 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:02:58 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316150301.3892223-1-badhri@google.com>
Subject: [PATCH v2 0/3] Add support for AVS in TCPM
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To facilitate optimum charging USB_PD_R3_2 introduced a SPR AVS
(Standard Power Range Adjustable Voltage Supply) which is a power supply
mode operating within the Standard Power Range (up to 100W). It allows a
Source to offer an output voltage that can be adjusted by the Sink in
fine increments (100mV) within a defined range.

Unlike the Programmable Power Supply (PPS), SPR AVS does not support a
programmable current limit (Current Limit Mode). Instead, it functions
similarly to a Fixed Supply where the voltage is adjustable; the Sink
is responsible for ensuring it does not draw more current than negotiated.

This patch series enables sink to enable and negotiate SPR AVS with an
SPR AVS capable PD source. This allows gs101 to negotiate SPR AVS with
a SPR AVS compatible USB PD port partner. The DTS changes for gs101
will be sent as a separate patch while marking this topic as a
dependency.

This patch series also depends on the "Introduce Sink Cap Extended AMS"
introduced by Amit Sunil Dhamne as it introduces the SPR AVS voltage
tier constants which this patch series relies on.

Depends-on: https://lore.kernel.org/lkml/20260223-skedb-v2-0-60675765bc7e@google.com/
---
Changes in v2:
- Updated Documentation/ABI/testing/sysfs-class-power to address
  Sebastian Reichel's comments
- Added Acked-by tag for patch 3 and patch 1.
- Rebased on top of usb-next which dropped prerequisite-patch-id tags as
  Depends-on patch is now part of usb-next

Link to v1: https://lore.kernel.org/lkml/20260226055311.2591357-1-badhri@google.com/
---
Badhri Jagan Sridharan (3):
  dt-bindings: connector: Add SPR AVS Sink APDO definitions
  power: supply: Add PD SPR AVS support to USB type enum
  tcpm: Implement sink support for PD SPR AVS negotiation

 Documentation/ABI/testing/sysfs-class-power   |   3 +-
 .../bindings/connector/usb-connector.yaml     |   5 +-
 drivers/power/supply/power_supply_sysfs.c     |   2 +
 drivers/usb/typec/tcpm/tcpm.c                 | 611 +++++++++++++++---
 include/dt-bindings/usb/pd.h                  |  18 +
 include/linux/power_supply.h                  |   3 +
 include/linux/usb/pd.h                        |  32 +-
 include/linux/usb/tcpm.h                      |   2 +-
 8 files changed, 565 insertions(+), 111 deletions(-)


base-commit: de6c925db978004703944585e9dd57d58aba0fac
-- 
2.53.0.851.ga537e3e6e9-goog

