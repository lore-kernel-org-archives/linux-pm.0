Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9273845C7;
	Sat, 14 Mar 2026 21:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524159; cv=none; b=KM7GW5f/v+cHRIUhrlN0tEcySM59fwjGeQ8DGy3UDE0QEomZRPgHH/lueVtevdndsI9NXHx5epHiK8r5ttR7x8mAF2hE55qaq8gu2bulDFo0Ng3NvQeDXaTRhgu/hoXdr3x9vW0akmaMdC+x13QtO2oVagh4ec3ubap/jOakr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524159; c=relaxed/simple;
	bh=JWRu3Ts4XCH6EVNWqY6K4/OGwPEsBoXK67d+4bDxyAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUVHppWX74RDaG7MehSEBgVCo9llIGPjCLjntMrg9sU1zw4h4cQjQSUwXn+gBYNvCKwNlefk/Ah8dqw/Xn6Fi0NG/Nz3pkKwKhPoSPsLr5wlTWtxUNnae/comZfmXtayQfd94GFjd3avjipP6olWYH3+IhRVRJ3IzxWyX2+k8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn3DbppI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn3DbppI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B72C2BCB9;
	Sat, 14 Mar 2026 21:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773524158;
	bh=JWRu3Ts4XCH6EVNWqY6K4/OGwPEsBoXK67d+4bDxyAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jn3DbppIuXycpowAYZc+X/VIcRxi0nH2FcyY88MA7H+5gDMz1jKzQC2v7lLQ2+/1S
	 aYqVipWWvj9C3Wi+QAzjIhUrooeiKau0MGzdYFoOOC6y2gBfviqTR0/M6eMBIgBMUZ
	 qORMzqrd7wo2wDp3u16yX3aHIJp11yoxcN+oom7QkRS9eDmCRi3O61NiW1QRbE+A2i
	 8EZsJBkZN23YQP6TcKUW71oYbJuSjQ0tUak1HtRgSv9CYsbo/Ib4VE5IP2xw2Z2uC7
	 yesrB6ve5Q6kWeS5xB6fixHgwr5dgj6j09tPoLAjMaFVpQt2hHMtmdbbEWsexlUMe8
	 dR+CFukcfxxwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6BA10854AE;
	Sat, 14 Mar 2026 21:35:58 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sat, 14 Mar 2026 21:35:39 +0000
Subject: [PATCH RESEND v8 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-max77759-charger-v8-4-226ca5f8c7d2@google.com>
References: <20260314-max77759-charger-v8-0-226ca5f8c7d2@google.com>
In-Reply-To: <20260314-max77759-charger-v8-0-226ca5f8c7d2@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773524157; l=3003;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=uuyjXd7dWRAWN4xiKCoHmw/T2i4nCX6K/xcdYc4Jrhc=;
 b=rClPlVLQ0lBkHwwSlvv6522AMU4iooGWIquWXhUEXeNpg3OLKrUpkh3/ip0mrBybe4SeBzG/J
 /P1O7/wt3gJAUjoPyRKlkTbxzc9ZD1B51tJzKo+1potLF7GiWgmfust
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a helper function to find the selector for a given value in a linear
range array. The selector should be such that the value it represents
should be higher or equal to the given value.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/linux/linear_range.h |  3 +++
 lib/linear_ranges.c          | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
index 2e4f4c3539c0..0f3037f1a94f 100644
--- a/include/linux/linear_range.h
+++ b/include/linux/linear_range.h
@@ -57,5 +57,8 @@ void linear_range_get_selector_within(const struct linear_range *r,
 int linear_range_get_selector_low_array(const struct linear_range *r,
 					int ranges, unsigned int val,
 					unsigned int *selector, bool *found);
+int linear_range_get_selector_high_array(const struct linear_range *r,
+					 int ranges, unsigned int val,
+					 unsigned int *selector, bool *found);
 
 #endif
diff --git a/lib/linear_ranges.c b/lib/linear_ranges.c
index a1a7dfa881de..c85583678f6b 100644
--- a/lib/linear_ranges.c
+++ b/lib/linear_ranges.c
@@ -241,6 +241,42 @@ int linear_range_get_selector_high(const struct linear_range *r,
 }
 EXPORT_SYMBOL_GPL(linear_range_get_selector_high);
 
+/**
+ * linear_range_get_selector_high_array - return linear range selector for value
+ * @r:		pointer to array of linear ranges where selector is looked from
+ * @ranges:	amount of ranges to scan from array
+ * @val:	value for which the selector is searched
+ * @selector:	address where found selector value is updated
+ * @found:	flag to indicate that given value was in the range
+ *
+ * Scan array of ranges for selector for which range value matches given
+ * input value. Value is matching if it is equal or higher than given value
+ * If given value is found to be in a range scanning is stopped and @found is
+ * set true. If a range with values greater than given value is found
+ * but the range min is being greater than given value, then the range's
+ * lowest selector is updated to @selector and scanning is stopped.
+ *
+ * Return: 0 on success, -EINVAL if range array is invalid or does not contain
+ * range with a value greater or equal to given value
+ */
+int linear_range_get_selector_high_array(const struct linear_range *r,
+					 int ranges, unsigned int val,
+					 unsigned int *selector, bool *found)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < ranges; i++) {
+		ret = linear_range_get_selector_high(&r[i], val, selector,
+						     found);
+		if (!ret)
+			return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(linear_range_get_selector_high_array);
+
 /**
  * linear_range_get_selector_within - return linear range selector for value
  * @r:		pointer to linear range where selector is looked from

-- 
2.53.0.851.ga537e3e6e9-goog


