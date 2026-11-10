Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329619;
	b=vvUVwkxM2LreIujWMRpsHAwuLZJLHKDtWOjq24iDSL84HdIZfNyvdhYqOp80PDRBTunW
	 enpTHHYGJT2hwIq/Nyskz1V12r+A4IiKHUq1pc+6niBol8iYlOBvpt1GSWnuENIZ3ekGM
	 +5yq4PLZqKnrjcQSfafGP9omaWjHwaBmHYIDNxnJDyMMTfirrCa65TF8tzP7D6TXjHTRx
	 txfJ5mz7Mos+Cx1TdXJz7P5bSCCIUS2I9+2++RAwVfFgRcwDIyoOmroap9y3mLES6jPJz
	 R9alilov7xVcBdvy4OkcQWKMozY4fZJdGWA5MpWzFj6ttXwOJhZ6wAD0lKPPlPRVzEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329619;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=V3JXTHhmdNjBk9g5BqE3hUMQ28Shcd1prmw0Vh+zpCg=;
	b=OS2n6J2hu73yRqHgLClhasgmf4oZyKW0kBMUm5zhYaVIBLFhGGsMmqETL7R5GyNiWhGA
	 t49ZUQYUCQqSsjAxuJhpaMEG3Fajq0fwekYwjebG6l0Jp2GwofI+86JOLz3RiIWxpozHO
	 rfFbAWf1X2yS5eC881X+kNSK3fhrkyhKsKuqL9hSjPeq5Sb7irkGqVopIPKNIm1qV1dyJ
	 xwgg71/S0ryZiIP4YxAaTWypVjulWecIjmISkupWudbcfDLHDyu48b3IA47ByUnkV+PAJ
	 1S1oxl2pY8hW5rnq4UwkyC/GaI6n/afELD+5eznci3kRCz7SK3s6DxQpJaQq5+Jap+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DREiqeo+;
	arc=none smtp.remote-ip=212.227.17.21
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE960A6F46;
	Tue, 10 Nov 2026 16:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4EE960A6F46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=DREiqeo+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794329614; x=1794934414; i=w_armin@gmx.de;
	bh=V3JXTHhmdNjBk9g5BqE3hUMQ28Shcd1prmw0Vh+zpCg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DREiqeo+pbgR0k92fTuGahkwzwczw5NrrTg/NCLFlUNkgYZ+VX3jMeIMWDSuK2z0
	 tR3QTGsp4+X0AqyAqI2QoYoZMGRKaSf9ox67cGmsaYa505QhU5JtML3iUq4n3BlWD
	 4MAprRcGUlp3RITaz9RKNN2RdXysZIqkIvJnY8xwTTnyMIlXr7gqMTU/9bc9VDpNB
	 WekmkVOl9beyH1tSFq3aYORaxbE84Wawp0XcDytMlHDavcZrv5HHiqmCtYl0exdWk
	 kDtAitj+V+DXqbOHmtpwurkb7nvQnkIZ5Q0G4BvseyU2QTuOgFWbkkWrwLqh2GJLV
	 XT4ID23uxjf+Yn2kLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4z6q-1wSQWX3YA8-00xqhP; Tue, 10
 Nov 2026 17:53:33 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bifangknt@qq.com,
	nicokessler@icloud.com,
	sre@kernel.org,
	linux-pm@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: [PATCH v2 9/9] platform/x86: uniwill-laptop: Add support for XMG EVO 14 (E25)
Date: Tue, 10 Nov 2026 17:50:10 +0100
Message-ID: <20261110165318.631010-10-W_Armin@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110165318.631010-1-W_Armin@gmx.de>
References: <20261110165318.631010-1-W_Armin@gmx.de>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:C7pKhPTYJNzsT97dpnvr6NmcMFLDQNh0/ikwGXp1mgqSiOyLh1W
 KnEgOdCppRkhtszOluhenU1ZYxLbnoF+q6Ftz/HR3aIqUfO5bVPOStMI9C/wqmIO6eKn5P9
 vOhjexd6EVqvPU2+j4K1dZab8z7YVpMpuZwnjmDYWpqk+jwb6jDjb5FZWxHcFYSv4Z7Zotj
 fJ7DRXxFbS8/HpT69DIHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iJkSg6gfCsQ=;w+77W0UbVq0iWDcF86cjLOn1FVB
 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

The XMG EVO 14 (E25) uses the same board as the TUXEDO InfinityBook
Pro 14 Gen10 AMD, but contains a different manufacturer string.

Add the necessary DMI entry.

Reported-by: Nico Kessler <nicokessler@icloud.com>
Closes: https://lore.kernel.org/platform-driver-x86/7FEA1980-AFC6-4A6C-84E=
1-E820B7E6CF3C@icloud.com
Tested-by: Nico Kessler <nicokessler@icloud.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/uniwill/uniwill-acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platfor=
m/x86/uniwill/uniwill-acpi.c
index ab02cd002194..dc99bf8a8568 100644
=2D-- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -3214,6 +3214,14 @@ static const struct dmi_system_id uniwill_dmi_table=
[] __initconst =3D {
 		},
 		.driver_data =3D &lapqc71a_lapqc71b_descriptor,
 	},
+	{
+		.ident =3D "XMG EVO 14 (E25)",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "SchenkerTechnologiesGmbH"),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "XxKK4NAx_XxSP4NAx"),
+		},
+		.driver_data =3D &gxxhrxx_gxxmrxx_xxxx4nxx_descriptor,
+	},
 	{
 		.ident =3D "Avell A60 MUV",
 		.matches =3D {
=2D-=20
2.56.0

