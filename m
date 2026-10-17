Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DB311C2D;
	Sat, 17 Oct 2026 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792242543; cv=none; b=BYJGfwv9easjFXGHg7FH5nFeYN9x8or1eBpAWV/ruvuQQ/uZyffl0uBy9iuEsJGMRmM1X/O9ndmdsE1MPKv7gYEkW6i1UUXCXnmqKuYxUE70pi+O8I36WCImTDc8BmXSDKZDBHYnPXKolpxs1dCC9w6bCnVuMXXouXr3i4RUOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792242543; c=relaxed/simple;
	bh=OaL1Gpxuch1Zw2DJv3JbxCry//JaeMv/NYthqYMb10k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZSglxtDKS8UBhdqwWTB6rr3qqbRiH9h03go1g6QV/zEWeON1BLlwwyiY8bXQgaHHmpUhrjwyz9uXAimifiGG7fTBfp2I8GMT6kC+s5QC38yUkbDLSx+eJzlL7TX7NrXOVnveNslZMUamWFGhb02IHXgoGEfr/lWPPuLZmRgvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PjvIZyRT; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PjvIZyRT"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F161180B1E;
	Sat, 17 Oct 2026 15:08:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YrlJ5mjOseF5; Sat, 17 Oct 2026 15:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1792242539; bh=OaL1Gpxuch1Zw2DJv3JbxCry//JaeMv/NYthqYMb10k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PjvIZyRTSucaESfB+opgxBkKNeKBI4a05ggPy1BVJ8cu5nA1bZRkSSt/fmjEKCiM5
	 Dt+C9gqg8eGo90EuWaTUcrKmfhOSTdZ0rtD1t9idRKBU4xq7UbRZbCFhjjyvxpk4Mw
	 yox2jhdHo6zEgg4fpyFyAbZvu8LgZWSbQWEYYrKywl13saMrwe8ieJDNlyx7/Efy7g
	 rMpADffL6+WrFs7JpJnGAl/AfiSgq1L/+Fyh/PUTJcwfywUytg477bny/6iNtsQvHD
	 zom7UptKEzG+L7Prlw9wxqXV1fFwOVK5rEpVN2HxwQCqvPrQ8epvyetoCxq+7E562C
	 rTMHvc85Ne75g==
From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rong Zhang <i@rong.moe>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Ike Panhc <ikepanhc@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Charis Stratakis <c.stratakis@proton.me>,
	Avraham Hollander <anhollander516@gmail.com>,
	=?UTF-8?q?Jeffrey=20W=C3=A4lti?= <jeffrey@waelti.dev>,
	Rick <rickk1166@gmail.com>,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
Date: Sat, 17 Oct 2026 16:08:46 +0300
Message-ID: <20261017130847.319661-1-aliamemis@disroot.org>
In-Reply-To: <20261017130652.318778-1-aliamemis@disroot.org>
References: <20261017130652.318778-1-aliamemis@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some Lenovo IdeaPad and Yoga models, the battery _BIX takes the EC
AML mutex and then calls the serialized RDER through RDIF, while GBMD
calls RDER first and then takes the EC mutex. When the two run
interleaved they deadlock until the mutex acquisition in RDER times
out, and GBMD returns garbage that is reported as both charge types
being enabled.

Evaluate all methods with the exclusive helpers, so that GBMD never runs
interleaved with the battery methods.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221065
Link: https://lore.kernel.org/all/58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe/
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 8213524504ee..1335f4e48870 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -297,12 +297,16 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
 #define IDEAPAD_EC_POLL_MIN_US 150
 #define IDEAPAD_EC_POLL_MAX_US 300
 
+/*
+ * On some models GBMD and the battery _BIX take the EC mutex and a
+ * serialized method in opposite order, so evaluate all methods exclusively.
+ */
 static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
 {
 	unsigned long long result;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(handle, (char *)name, NULL, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, NULL, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -324,7 +328,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 	in_obj.type = ACPI_TYPE_INTEGER;
 	in_obj.integer.value = arg;
 
-	status = acpi_evaluate_integer(handle, (char *)name, &params, &result);
+	status = acpi_evaluate_integer_exclusive(handle, (char *)name, &params, &result);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
@@ -336,7 +340,7 @@ static int eval_int_with_arg(acpi_handle handle, const char *name, unsigned long
 
 static int exec_simple_method(acpi_handle handle, const char *name, unsigned long arg)
 {
-	acpi_status status = acpi_execute_simple_method(handle, (char *)name, arg);
+	acpi_status status = acpi_execute_simple_method_exclusive(handle, (char *)name, arg);
 
 	return ACPI_FAILURE(status) ? -EIO : 0;
 }
@@ -394,7 +398,7 @@ static int eval_vpcw(acpi_handle handle, unsigned long cmd, unsigned long data)
 	in_obj[1].type = ACPI_TYPE_INTEGER;
 	in_obj[1].integer.value = data;
 
-	status = acpi_evaluate_object(handle, "VPCW", &params, NULL);
+	status = acpi_evaluate_object_exclusive(handle, "VPCW", &params, NULL);
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-- 
2.55.0

