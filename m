Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352143BD242;
	Tue, 31 Mar 2026 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774999354; cv=none; b=u8zkIZX3Yx/47RAA5xVtQ+YWxQ1SPfdADRXckKp5YjER1k9wfNsaQUx3d2kV7HKOIFUxqrs1hmTqacaN3XHS0mXTbyRWGN3/6j/oUXEYTFP3ZE+cJyxhBp2ADUTV8YWco0eason1t637x33tspyBm+SpcwUygsOx/0wuxJOSgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774999354; c=relaxed/simple;
	bh=QC+/tqe1/wX3mgbcC+PR25ooF/RqKPuOwtdoO9U4yTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZYITTJpcv9oSr8whnOxHNKc0ZC112YG2I1A/U9KWd1z35Eluh+mB4/tRlzrDleFt5228v4TjOk+89KsWSIvWNFGZmOykFvjTnSeUVD7xF+gHGSc/sqouS9RAYHBpFKfEgGAnd6vrnNrR6FsPB2XU9XET/CSnznWZ2B/pwFSEzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuSTj4tH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuSTj4tH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F32AC2BCC9;
	Tue, 31 Mar 2026 23:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774999354;
	bh=QC+/tqe1/wX3mgbcC+PR25ooF/RqKPuOwtdoO9U4yTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JuSTj4tHq2+YsBAEbcPsvI6QbbqD+H2GAvp6bE6TYbafBHZg1v0TgDIdr5obxUnVa
	 Fh1DK8wuDW7WFRM9DO5bG23UV2HzDOd2Kq37fSwmHh0BFbT6fny4UlcAIqcuUt0qcx
	 rY0Zpg0V0jkRyo62FEQKVjTRReYg0U/wJbFl0qMRyO7uNpVHfczbnndmm+CZLbrXEX
	 dLMldEHr/HzAmdWk5jqL3pQb+5MlT6gjwdWZPZ7yjMMjY45HUY5TBYtYGk1prNRegq
	 yFCJ/q+pyF2zGR5TEmjcO18FKytr4HOVVQ2jP8eef/r4fYwznKz2JGgVAZHbCXrf8p
	 NFEhR4MPlAMlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0569910F930B;
	Tue, 31 Mar 2026 23:22:34 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 31 Mar 2026 23:22:19 +0000
Subject: [PATCH v10 4/6] lib/linear_ranges: Add
 linear_range_get_selector_high_array
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-max77759-charger-v10-4-76f59233c369@google.com>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
In-Reply-To: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
To: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jagan Sridharan <badhri@google.com>, Mark Brown <broonie@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Reichel <sre@kernel.org>, Amit Sunil Dhamne <amitsd@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774999353; l=3004;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=EfsBhqbhWkOWcpl6lnnrrFZd6U20wlHL8pMi8geg4Dw=;
 b=8SnUCdVnNvBOuxFKx0mY+BFXadDyNmS+pNAGroFaPxnnnFjJszZYb3XPGU7KnX3Ah4iFaQ14u
 kMXZaNKamdaDxRE3d2kcAh4KMnLpP+A7JwXaKor+SxkvvBmk21k9wau
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
2.53.0.1118.gaef5881109-goog


