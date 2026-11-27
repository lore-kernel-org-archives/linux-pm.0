Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796875;
	b=VlILml+uSR9CI3RFGTz28PEEGX8uTZakEef81fwAFAZXZrW7zNdf8adz4xkWQ6CeJ5bg
	 77QFi63epQ3QocCB5wdhQOwTS1+r5MZAZrKxecDK9LBvGZb5bLvgq2/hQ/MJiB1HXVsTW
	 /VpUh4olFwdfBPp9Yrxc7ZYE39ZHYL++HzikNzDyWWlY38sYRR04dziU6VW2Qr0jxIjs/
	 5E09eNfRrGnbOTATXbOFmbwZkUM+XnmdX7ExLoH0KT+Gs1y+O6pQ4MkELYphC09vhSOLf
	 e+7c2NeLexoFyyhF9Nf7MpPtRNq7cbUdWjNFJv2+FPhTM7vcrWr303dx5gwd89kPmzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gisVbaBWzS2DJvutQXrGbyA0kSo6MCGtMefGtDzFmWE=;
	b=azRaIognI03IPLSURsvTfZX5Rwr29JySQzCJ6EJ4oaVkelo1UdtQuvGklhZU8yWNQoD/
	 X+NSxKVLiY5pIb4aH9y1Gn1WrHP4k/0KN0XBxyXB6SvUQ4T2fiNEM94UM6fOqTKaXv0aa
	 XWAT/Oa5WHjBdJ0EOFLPY46wTbZV0txjFQkJeijnm8aB1rhwTtulYvomZoFjNIQCniZtG
	 k3U4CabOlmEcByITXKREmFI15w/pgCXgDcgfhGPLSjlZRDI5Hoo4ojak9aRcZr80Ft83m
	 EqJ9pl418fugfwedhvbnXQikMD70n6gPIw8Yg6SKHizB07sPnFGWYq4sOs1sEEfZa4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljPX6cKa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6626606A31E;
	Fri, 27 Nov 2026 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljPX6cKa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D93C1F00A15;
	Fri, 27 Nov 2026 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796875;
	bh=gisVbaBWzS2DJvutQXrGbyA0kSo6MCGtMefGtDzFmWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljPX6cKaAwSota4iRpfXSgz3ixc7mnh30WhcMLZLGY4IDA5k3lWT7wh8EpLMlUitK
	 cW1fURRnVv1OEK6n+1qeAu39T9TWlq+YdhGL8qy2/YYryK7gj1fFzbJkfaM6y2nAx2
	 CiwDCMH95QyWl282uWeH6xcxngpER0fmm5UXYaRekMJRVxtLPs0+l5NTrO5MB8Fu42
	 yW4H3Q4hbms8kj7LnsAK5RGluKxZ5d+bH4EwWAggcQbFh8DPWSYxHeI2rvlQH0fUgE
	 0ijElmr+Rx+Gv/VZroY2vIj8ulU6hmtcCSryVUAfojS8Sq0I6gG/MwGNeVnNGkQspG
	 8+o+EP4O7z7OA==
From: Geert Uytterhoeven <geert@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 08/14] pmdomain: Make genpd_get_from_provider() return -EPROBE_DEFER
Date: Fri, 27 Nov 2026 17:26:53 +0100
Message-ID: <6247d25ea6cd21ce9223c7fdf2d2bd4c9f61772f.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

Unlike provider-based look-up functions in other subsystems[1],
genpd_get_from_provider() returns -ENOENT instead of -EPROBE_DEFER when
the provider is not found, thus not supporting probe deferral.
Currently this is worked around in of_genpd_add_subdomain() by remapping
-ENOENT[2].

Fix this for all current and future callers by returning -EPROBE_DEFER
instead, and drop the no longer needed remapping code.

Note that other callsites either don't care about the actual error code,
or propagate it up.  The latter (e.g. of_genpd_add_child_ids()) thus may
start returning -EPROBE_DEFER, which should be fine.

[1] of_clk_get_hw_from_clkspec(), __fwnode_reset_control_get()),
[2] Commit 18027d6f392ee8d8 ("PM: domains: Make of_genpd_add_subdomain()
    return -EPROBE_DEFER").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v6:
  - Add more clarification about other callsites,

v5:
  - Add Tested-by,
  - Clarify that all other callsites should be fine.

v4:
  - New.
---
 drivers/pmdomain/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4e0a76f1f08fc64f..633a6e642b1ba50d 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3037,7 +3037,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
 static struct generic_pm_domain *genpd_get_from_provider(
 					const struct of_phandle_args *genpdspec)
 {
-	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
+	struct generic_pm_domain *genpd = ERR_PTR(-EPROBE_DEFER);
 	struct of_genpd_provider *provider;
 
 	if (!genpdspec)
@@ -3292,7 +3292,7 @@ int of_genpd_add_subdomain(const struct of_phandle_args *parent_spec,
 out:
 	mutex_unlock(&gpd_list_lock);
 
-	return ret == -ENOENT ? -EPROBE_DEFER : ret;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
 
-- 
2.43.0

