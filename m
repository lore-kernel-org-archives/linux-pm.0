Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616469;
	b=0yicizl4Q6RfO3dbtobrziiMlOvlAuf7aLteNy01qrNATAjjNpZwD2ZAQwdGJwGIbGu9
	 jqjQroHoQjn+rKLAEExwt0UvODL/wbKswdaxypcI2iZ3PfJeaZU2xpavJaqNLiDsKu3IK
	 EgWA9fT49fmKG3fBB3gUuqCyK0HaN88ow48EzeDjcqKaEPVh9K6dKD+f29m5vKchS94cH
	 1XIbyghHHa9V2l75xHNDQt6pP3XXcpLxyi2dVvgSQRRV1D19fDJ0WCRQC5j1JY7ofBrGy
	 T5rxiSopR1VZDofTBuJJsfq/tZBDyMzmUDLztZAIjWRkLCgJgx4iaTWnHOYUaAfSomA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=LnyZp3DIg0G5Eku4s1DstqCwY90tB5OYltP/eODijGU=;
	b=s3mLNP1mC32puxGeDLOvAusBh0Jyc1/86+QoFcRR5yCSy5q/CZHml3R/WlSuEVgnMLEH
	 f/flF8w3CuNbqQ5yunPEu0ee6LIsPSm11vWv9q3ZyZuo3AHPNC0VrO/XQvRHU2Jq84n++
	 vSKxIy/o7LWjhaCRypeFeXB9gA3RzzrR2cca0EVJV9G4FoVCO3533jN9FS92A4PNDngjb
	 pxwh5ehomtdte5lx0sAPyrFFXTD/c9zp7b5zgFV1gcTgvOL08J1ZvLHlI3680vRvaL2Hx
	 vyLe0Aq6tPqf/tlrPnVBiWkOLTpJW5U1WwNhk1yIQjaiftNCZdMvPdbbNYnFayO+XSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/xPofMd";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D6606A321;
	Wed, 25 Nov 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/xPofMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678681F000D2;
	Wed, 25 Nov 2026 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616468;
	bh=LnyZp3DIg0G5Eku4s1DstqCwY90tB5OYltP/eODijGU=;
	h=From:To:Cc:Subject:Date;
	b=e/xPofMd/kDoK+vSJLI7s34l6Fd8FKaVOunVtLwjtxKjoGZY39o/sGi4mSmTM9h05
	 Joq7ZZgufG6ELItMG1jG3Y45hMvmwOffhMpb5rXIfPf+E0m2xrICuBp9WxldSqOfm7
	 IqeTSIDLqiEmzGnICjNXljQAx73k9ZWT+tVdk+xxq55q5GIOvpE/BacjAA+ExYG4Pr
	 fKkTn3buWJVfb5r3APB7om0FkfvktWm7oJm4bvXMOIi3mWJzO6gOY01wrL3/vHxQLJ
	 hr9bFLeUh4OPeVnNjE1yc1Gf9uQ3QdReOvRA+rKlsTRQBKdl7y8QWHEXaFVYqWXNdw
	 32ZOG77t222BQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v1 0/3] intel_idle: Fixups and new module parameter prefer_cst
Date: Wed, 25 Nov 2026 15:15:46 +0100
Message-ID: <3986546.kQq0lBPeGt@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi All,

This series makes the following changes in the intel_idle driver:

* Update outdated module parameter descriptions (first patch)
* Avoid using empty C-state tables coming from _CST (second patch)
* Add new module parameter "prefer_cst" to force preferring _CST to
  _LPI (last patch)

Thanks!



