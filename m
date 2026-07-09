Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BF439337;
	Thu,  9 Jul 2026 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601253; cv=none; b=oaIubSYB2CxWZXn5+VtAktbOd10TXHx549pQNtbj7zpCqc63pzFhaOI/d51PUI5BKsfjnRRU3H0xlzJMrfxjo8S5segqh+TknFLo3LUnCevqH2VZihlfJ5/gBxAux03k6kQFEvCNIrYmZsgWBrmjc/HFQ+jwtvZSYiBIFs5Rw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601253; c=relaxed/simple;
	bh=46leSuh7OfjqJArt3szYC/GGsiRjn4b8My8cro0ACmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5BNqTYDHtbS0N1twwLme5bEcNu1tcVr+k/jYzZWomJXR6nNCsS9Ei9cTw+8SMYC4ydlSDIreePw8L3td3fWmKhhSeta3qLd+N0YcixQQmrphPTzppS5ZisKQ2WS44hqR/1jBBGvpaEQccD1+GxQhT3qrjE+r1S5UgD0tKqEi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0PIiqSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0PIiqSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B1F1F000E9;
	Thu,  9 Jul 2026 12:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601251;
	bh=jNDzD/QzZAIhvL/FRaPMQ3rDbkOMX9PokScHmt3gYe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0PIiqSJs/EjtQGNm9CwpsVI70pnTmnngVbiUDarJHfljS4OTbaaxFwNUJcuvSdw+
	 gOUXqDhRdU3MBKhBdLtbOjrGj604SlmK48XEpe1Gq4nhZ00cTQ7ub9GvbEDJM6kZoM
	 Ya4wEKLvww9ENU/SoZRmKCmjgRAMbzXyquKs4Qe5wELqzoeTCi1J6OPX/b1O21Sv2J
	 845dNUeGKkO67m4OCFxft4fNEx/Cg+DrNKH6tbdySYVcivO1Mai7K1B/HKAAeRHhRH
	 rLtUQ3V7+W8IJZctP1qjiaujG9oZeGyo6uH7fFgdCxT4Gl6UFLle+769yzQ1jZUQGl
	 M2DQd8PD0Ldxg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject:
 [PATCH v1 10/17] ACPI: processor: idle: Rearrange loop in
 acpi_processor_get_lpi_info()
Date: Thu, 09 Jul 2026 14:38:29 +0200
Message-ID: <1862515.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4746278.LvFx2qVVIh@rafael.j.wysocki>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Eliminate local variable status (that is redundant) from
acpi_processor_get_lpi_info() and make that function call
acpi_get_parent() in one place.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/processor_idle.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 274abe3da7a4..57a0a8aaa42f 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1095,7 +1095,6 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	struct acpi_lpi_states_array info[2], *prev, *curr;
 	acpi_handle handle = pr->handle;
 	unsigned int state_count = 0;
-	acpi_status status;
 	unsigned int i;
 	int ret;
 
@@ -1151,11 +1150,13 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	prev = curr;
 	curr = &info[1];
 
-	status = acpi_get_parent(handle, &handle);
-	while (ACPI_SUCCESS(status)) {
+	for (;;) {
 		struct acpi_lpi_states_array *tmp;
 		struct acpi_device *d;
 
+		if (ACPI_FAILURE(acpi_get_parent(handle, &handle)))
+			break;
+
 		d = acpi_fetch_acpi_dev(handle);
 		if (!d)
 			break;
@@ -1171,8 +1172,6 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 		state_count = flatten_lpi_states(pr, state_count, curr, prev);
 
 		tmp = prev, prev = curr, curr = tmp;
-
-		status = acpi_get_parent(handle, &handle);
 	}
 
 	/* reset the index after flattening */
-- 
2.51.0




