Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81BD483BF1
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009175; cv=none; b=Q6+d5cYC+NO/UGWURK4jh07p8ujZX8IoTu+5aERUgd2kU6oLDIY0dvX3YdRqWNMCS9WQBqptskUBpV8wVBYHLyGNNvkHHO1qSBXKhI3musXQw2s7xRMi98JAI1AXXX3BBiQ1n4ki8TxyR0JWiWQu4KUoUbQguzuOE/DDBbyTebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009175; c=relaxed/simple;
	bh=eSYIEtLXOZYiRJoaAgKd3qpeKeesbJPtOjtccnR+8uM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cQZ9Hnc37v8/CR3HEXCstTVs6kQ4Uyp0SjP0jqrHcdXLK0fWayzHhYHcvUA5YE2+9xR+GTTl0if1RURLo6LH1jFFuo4JAlqAeSlD5cZRgY3wiO4e5zS99snyeaPYn/2eAjtV0obz48ho/Olb19io2N6M/OgeGGIDOg+PPfd3St8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKeAkjOA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6uDJOeG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKeAkjOA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6uDJOeG"
Date: Wed, 14 Oct 2026 20:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRh5NUlHtEy5rghlcmfOy9lEKzUDQ9Fnt/J8ZwXyhBY=;
	b=IKeAkjOAbMC9UgEg0/AAT3fYHgX2ihFoa2m9vj/ZM6/rOw1wAADsIr/mmADf6GB6ZLlZw8
	T9OohCU2VEpQ0w6U9aTlBkQyiBqwrGNqkk0hW6BEzCLobHW+Pcc25/svwwoPRmVR4eSucK
	xejt41ZcDaJz6pLaJKr2Xxgf4fM/UOgiRqcsNsyJUOYQiYek5on3NGGJb9L7aBoaQp/621
	vKWLxrn0G5dAOmcjmSE8cuXz1vHvASUI3sispR/T19GK60KTVntkGIGH7579awz4TIPUYR
	w8vtGG82eqHNifzNbisj5RSMJAtX3jkoI6i00iFkQ4QwF2JYTyURUjAYylR5vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRh5NUlHtEy5rghlcmfOy9lEKzUDQ9Fnt/J8ZwXyhBY=;
	b=j6uDJOeGpA5eNLVZlJR3KDUOKodyYNDDGk32ys6OXSJUt6Ja2JBniJ+08o1dmLAvty/hzL
	DuZOkM/L8KdhPBAg==
From: "thermal-bot for Muzaffer Kadir" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject:
 [thermal: thermal/linux-next] dt-bindings: thermal: tsens: Add MSM8952
Cc: Muzaffer Kadir <muzafferkadir@mainlining.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To:
 <20261011-msm8952-initial-support-v5-3-1857074992ec@mainlining.org>
References:
 <20261011-msm8952-initial-support-v5-3-1857074992ec@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200917044.2666337.9479905905938136710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     200265cfa885553da708a4e677ec10df98d3f68b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//200265cfa885553da708a4e677ec10df98d3f68b
Author:        Muzaffer Kadir <muzafferkadir@mainlining.org>
AuthorDate:    Sun, 11 Oct 2026 19:51:25 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:41 +02:00

dt-bindings: thermal: tsens: Add MSM8952

Add compatible string for tsens block found in MSM8952.

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20261011-msm8952-initial-support-v5-3-18570749=
92ec@mainlining.org
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Docu=
mentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 5a8f767..c78074f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -46,6 +46,7 @@ properties:
         items:
           - enum:
               - qcom,msm8937-tsens
+              - qcom,msm8952-tsens
               - qcom,msm8956-tsens
               - qcom,msm8976-tsens
               - qcom,qcs404-tsens
