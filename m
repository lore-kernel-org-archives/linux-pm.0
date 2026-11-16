Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864484;
	b=s8NrCeFyf/8tm1rTcIMT4y7xt9/dsNRICOTIgNZcHbU/4VByKj4TRCyENwmevDXxAMV0
	 bI2VrRWLMRswFriMZnZCkVg3tpAZyjAY64s9txLuzruMptArJ6PAJ3R0pUbneH3mkyUME
	 sekGJeP/Dc/EXx4MQlInDC6ytSF1nFBW51SgnRQWM4/RQ1YK7Q+/5PYRjHxWyW2/4I8HZ
	 AFP/gnGT+3N3WbqiVOMJMIWgnj08//m5GarYMcsPDbMSUvjnRoV0Tp+M7rTBGN3DxG9As
	 49PddMvc3UnHim2GviDSdb8OABAO6YhqWY3pYVBio3M4x8DyECVqL0AG7dXEvrNsQ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8TdMvk4MSLOM7B2AUfqYT5uxdywhrc23UXtZE8vgWzQ=;
	b=ALW9KggdIbGFQhunGuUbumBWI/FKdBdtYCM+pBJ6OSBjrNBzIoRauyRzPGRvwV5sKS8j
	 MXizT2XUB8j7IMsBlrAknwKUXR17J5jGcq+7+DtMqEbQYboB5uQ0APl8dprCeQVFsFOd2
	 PcZw1yvqobqUIVlRFnilm2JxkOkxHggjaxaBPonXZDPcxX/QwQwvaKKmke4PSPVbHdQPR
	 gPTkeLAu9VnowHGEZFTg/2sKtzAogyOVp2Tuv0Hy9vsdCBQtW0z2uiwpSL5BjLB+ni0Ue
	 51+mA6lxed0PyWyUpbVSRCUeDZt6PRzDtISmqjDtsjaai+oBZSAndTDQ2nSMDHLDeCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGH3kEag;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE57606A335
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE57606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UGH3kEag
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so3551681f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864482; x=1795469282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8TdMvk4MSLOM7B2AUfqYT5uxdywhrc23UXtZE8vgWzQ=;
        b=UGH3kEag7+QnSPw8NgN0my144BL9MI6P+lzS4lSmWpGQLU/I1Wj2jG9zLis6cKkcyN
         ttu90mcZBjnspWeaKA1sIRwB9cdXaff25bi0pIzo2nlZOYJTE5UudY0yiqgN+oIc1Gk4
         27gWEvQJDPseqUIJdZV/bKhN6eyFQZ7udD/C2KLm+okaF7uw60hj4NRq7HAVpwg467V9
         MmOa42/K0JqbfZnd737Yd7PfrKLwppbtes0cyHasCRpOwm/EKfvIwi9YyvfmdII+iysG
         TW0GSAVvcD/jtsTLZMB/5KuH/HSlooTeqSEMLMXw4y/dOpM0oYUhyTRXoRWTIM99mqwk
         kqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864482; x=1795469282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8TdMvk4MSLOM7B2AUfqYT5uxdywhrc23UXtZE8vgWzQ=;
        b=z8nu4APINJIfpBlyEGo+C+vCA/b6QtTMzjg4XfRi5YUNp5IOIlguckwZ3rHUAFtuTi
         z4CXqZnB39ACfowI2ywLjQX4KnvxuQYJ7+VVsTB6hXFKyCP43HkDuhANQd950JanQ6oo
         V/H1Kod3HDDdNw8mS3BoXw4BxlyJ8pAG00YLNczt0wwDSEJnse1IMPfieo9+GbO6u6ut
         jqHwiobL/ZeR04PqhYCfxCB4Nz12HRElGcA61YIVEPfEhB1BZ1fFLtjM2yLjlpXDQdc1
         T3cKKlpRigwcgClfTOnIYuh780mLNQCZfRdirPj+KSDFcKBwp62qpxI+Krw8KNmxe2v1
         iQAA==
X-Forwarded-Encrypted: i=1; AL+hErH70pFAk9AQtWQ16Cx78vk/2wKEzOS6Uud864s3x+WyKj0XiJDrBuzP4XuUnrbfoi0KbRIeV8Wqrg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9wck9vWwn7yJ2ZNgSlLJq3pwJJ0IrtBMGnp5SsjG1XX01CMibB
	ddDW1VLYIuIHb78yakIG2Ya1oluCIAM2XdW7RVuTbfjHlpxIdwPf32bb
X-Gm-Gg: AZFdTZecaLE6N26t9dD3B8QB1GGGzzCl9viReoT5a7Mc9AW+Z2FIMztD0Nz+xBsPRQi
	YeyL4UZ2I76tDUozRbAWHQgVFn82uBKnpuB6zrvrBytXfDPdmOCqKMdL9uZiUGoFd8exfjkZg6o
	wKheCXZZhf9e2gZ+dl0wTTEJkjMyDRJ2eKIf0w7uq3isnRTZAtN5IjPx/SMoBeKptKY7Eo3Y1D2
	LS84e5RELwFLcKKAs8+NerxxkiVUFwYo32UwfIuCVMWDTk5LwAcCtoXcCszZKTnIP/C0jV6xrZx
	of8v0LaHZOfwUVrZTFP51cI2yxRI8PZgFP3eNqs0WCoYWW2hTcdanopx0wG7ozvc/U/9IK5ZZ/A
	hxdO7z8eR70nKQ8oCzQ254/fTAtdqgkoqIGFaPYq3TXiqzBMXcMoIMqHY8xGPpW43DFtT/PWyMQ
	1VC70NuSmiND5rSwKDUIuzzyLKw7OdQ3X316jNF2lsyr8HJ1i3+GOvvvzVwSCzWds4PfESQaWn7
	DQroeOlnStnuk+9T0ePHfNH7/jrlRj/hU3j/C2PfAN0Mb/7Dv+Zbo/zJ8sEZIbA0E5BFo3WO2Rc
	Ywiif5UtsCmpAvB90djoH3pSMCevEY8K3//HocBT
X-Received: by 2002:a05:6000:5c7:b0:48d:f996:1814 with SMTP id ffacd0b85a97d-49c7325b40amr23107019f8f.57.1794864482125;
        Mon, 16 Nov 2026 13:28:02 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:28:00 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:30 +0000
Subject: [PATCH v2 14/16] soc: qcom: socinfo: Add SXR2250P SoC ID
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-halliday-dts-v2-14-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=679;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=6bC47xmeKrVS8XaUkfpVIXGQqamVpsrDydmAXACmpko=;
 b=L3bECMGWqB70KSAXliPLAtrm9JvwyHz3xUlIS/JSaVuyDRybXKh4TJZIKniI807WZa1pL3+Ja
 bm5mXrDXMYUCX9Qe7poGqRt5BD+3P/4++4UczCRJAuB1UHs6hFIK/pI
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Add the SoC ID for the Qualcomm SXR2250P (Snapdragon XR2+ Gen 2).

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 38efc5db7fa8..c5b61d28fc9d 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -529,6 +529,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM7635) },
 	{ qcom_board_id(SM6650) },
 	{ qcom_board_id(SM6650P) },
+	{ qcom_board_id(SXR2250P) },
 	{ qcom_board_id(IPQ5321) },
 	{ qcom_board_id(IPQ5424) },
 	{ qcom_board_id(QCM6690) },

-- 
2.55.0

