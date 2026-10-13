Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7651D35AC24
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858134; cv=none; b=X0TzsmcDltc4VSSi+KVC1ye1bkfwIfyi8mAOvOGvy7g41BtN1uKDsM33K6bKbV+mYnGdgeV+1tAg0LSSoGnRXGxB6XyXNo73+1IJjAbvM2fHvbq8E4eG5XqGDTjbBhoCqm5OuSY7gZuHC6DTv279xQxQOmdTaWOBpY6peNAOLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858134; c=relaxed/simple;
	bh=yUbsmqpAlVxpVNUk9mGDoYDLojcHZBXxmh2XxEJpsgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5gUnZupdXvZcBFckqjVnFH8NQg5NDkFBihyfOMJ7M+gkAjNn81mMbn4Y7/jLTaV2+lDXQskYEj+GjUedmCTzSVaujz/jRP3iguMfksNrBXZq3iPT9VVLnYOC2n6L8/M/Cp4AehBuFyr7mNv6i4v0c9GS354GDJACv2dU2OZmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com; spf=pass smtp.mailfrom=timdoug.com; dkim=pass (2048-bit key) header.d=timdoug.com header.i=@timdoug.com header.b=HvjoXXHc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YD0eBg3X; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=timdoug.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timdoug.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timdoug.com header.i=@timdoug.com header.b="HvjoXXHc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YD0eBg3X"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CC2D14000AF
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 22:22:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 22:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timdoug.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1791858131; x=1791944531; bh=8AKFfelsawtSO3UBc6ITm
	hmYy1InGnHtdpXoxDBNvko=; b=HvjoXXHcfS55rJUg2NFTjjiiwuTnf8TKONwz1
	iNqnI5sE8askRHSu82Ec6hQAHP5U0BHyIieqtT49ZD/JTSIfcR1Q65tWbqa2aInJ
	j4qhO5sAXM09pBohg2fMU7aUUQOSoHBzeTFYoSlcinb69/SgzHPGSeYRO//f082c
	1XtSSckmNmOl0Nsffk/gb6HT7LGqB/8I9b/PdlXr5tYiAd+5OdBCueIVrARWTMZr
	53/njjZOgrjQPXtQg01sA6oXStUIhlgR9Yzqi3+NWHxQkItTLMWxIqhb10a0K1Vk
	M8fSB7DRFMWVU8yfTaBX06WpUkoWY6alv6aXd2uo35LJsadkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791858131; x=1791944531; bh=8AKFfelsawtSO3UBc6ITmhmYy1InGnHtdpX
	oxDBNvko=; b=YD0eBg3XfgKl2c9X8dfCeRhjFFWNfNX/omPXComUMUWRxwfg4yQ
	zg1WimYCFXN8MWaOxSP5wyhq6XyhVUXR4Tw7ppZKytT5XvLFNbn25nQ1HcumjeKx
	NcECGVcmiYKq4B7s/mpJdMmeceDCNtz6oN2qBIK3HrP66oE1l/+5X771JrgGXGss
	773RSyByZFvW1SqN2gwWTqYEigBAH+vuHlVWcVnZBQpAPFfBRa0y6Z+O90Epr4Rs
	NjMQxClAsH7cgjERWHo36/+v9mCsxseSSYTlOXFgKWF4j30XqjZqDkrU7nZvancH
	ebIE/v437L2b6IyYoACIIOXfx+xiQr6Q+BA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=timdoug.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791858131; d=timdoug.com;
	mf=PG1lQHRpbWRvdWcuY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:SAxMSlJWXpVW4oB/4YOskTrM3O/+hzBWF+mnJAsECm+AR+4
	eBJRNVoh9IYUIPyKbqlRRrQXexVQnUuyNfIm4+ZrUGiNDFq6D1FvvSMAw2vrc8W3
	XxUa1UUYffALhY0ByVdHrSMjCKWR6wUSLYve50BSX1bcqqXPi1QQPqxm/oGV54GT
	BB38lkuZKYCLakTx0VT8NORg1Yx1Gfw6sMNol66iJo3TjYP6wQi587ZevQEbpDoD
	HxosQ6eTMjOeyxJsASn7s/p8E/cHsxNDM9nhzBXMzfWdWJUkPZMI3KP2KESox+z0
	K6Umlr7LHOUW5T5/EIe16C+o5G6Bo7hdY1AMAjA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:G1595HGMJ+NOp/dMfzKLm+vn2NN0X6PPphEzKsqhWYY=:yUbsmqpAlVxpVNUk9mGDoYDLojcHZBXxmh2XxEJpsgw=;
X-ME-Sender: <xms:05XNalWzKNFbURUr4hURXI0X_G51BAWDjnBJehyLratpFFOTxknuHw>
    <xme:05XNanHjby2aeCCFSDClgSXX0I7-O7Ld254ppVH4va1dM-mpsF8z2VLR2I9RbMDR8
    ColcZFJy5cQJFa8L_m2ApPeP4UVnjcmvZKY4HmusB1dwkf0VIQ-HA>
X-ME-Received: <xmr:05XNahcaPb4FaG5YRpnXfQ_vWVoaP4qJxx7XZX5Uv39z6J2Ir_A9IczeV2fM>
X-ME-Proxy-Cause: dmFkZTE5TSj0uNldv2nXrXZQ8H9jo53p3MOk4d7KCTAcDjVAkEaWTxKUrgbO6Z4kickB49
    HeTFah9v6z1wXVZJnL+zjwS1bCHjbPwg4R1Xa4ES0MNm09I/EwJieoBo2wu4MN7h63Pvlh
    rRjGitwF9eZvZ9lBidoaPr/4QvlVYTIkVWU0i+ehQ3Ayr7WTt4Kj+/BLutAImOIOjcQV09
    3TttaZQ20mA7hDaQ4ecd5qsNO91ge0baj3yatQ4nZ28hmDL/vW94DYCE0nm2i8AhME7Qb2
    rOwqhgXQHCTFPJlzDQpYTQu8mZK14kucrksqzssluwx930YctLOj+KtB/LXKGlzS+vXKni
    SPg50rm2pzVe6LscbGO/D8IBWXh8/Lb8mU5ked2CpzsolJCh1yxcofkb63I+Xfz1XQrbXT
    Co+n08J+qUBN53aIvbGZ0NX+GkLyHJYG3hMZQbDQ0/R+uplehYsnfahTEz/HC4yu5XOhEk
    LMKc0+v1bbPERScFmQZ16p053gWWbNUaJcvTLjGEqc+i3cAsDxRSat6UdwD1Z4dXnoR08g
    FRa1eVe12tFjTZM3nsIaRmjM91C+7YwM+DxeH0PkZfrZ9Amepgn56PTI5Oumkq131QMzfy
    aqGuhzfFMPgwDVAlaE4h2HcboYl873XZAzBUKw3PL+nIeepV9dsNeTPlAbwg
X-ME-Proxy: <xmx:05XNaoIfpejzpXfifyRwwtivcIfC8fvjzMk1MwNP9hgDJNFj9Vqr5g>
    <xmx:05XNamF-roYyJRi3OmHN9FxCog4mNESAC5evhrnxJVIQ1v8qyRyFVg>
    <xmx:05XNarA2tLQWYolnElxnDxsjGDSQIPOj6qD6_6kraVfCnJtU1BQY2g>
    <xmx:05XNap_D4Cxd9mtqtoAurXRKwNkVJQuaSg5-RE7Y0fMt70uLVsBoxQ>
    <xmx:05XNajOJVeJTWBb4orurUqnbauJcVDfcjae8mPA8AsYATKi3rXCCMJta>
Feedback-ID: i12bc4175:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 22:22:10 -0400 (EDT)
From: Tim Douglas <me@timdoug.com>
To: sre@kernel.org
Cc: Tim Douglas <me@timdoug.com>,
	hansg@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: generic-adc-battery: fix status with no supplier
Date: Mon, 12 Oct 2026 22:21:53 -0400
Message-ID: <20261013022153.6707-1-me@timdoug.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power_supply_am_i_supplied() returns -ENODEV when no registered power
supply supplies the battery. generic-adc-battery's gab_work() tests this
return value as a boolean, so -ENODEV takes the supplied branch and
reports CHARGING, or NOT_CHARGING if the charge-finished GPIO is asserted,
instead of DISCHARGING.

This was noticed while bringing up an out-of-tree Linux port to the
WikiReader: the driver reported CHARGING on a device powered by two AAA
batteries with no charging hardware.

Only a positive return value indicates an online supplier, so treat zero
and negative returns as discharging.

Fixes: 46cecd130d55 ("power: supply: Fix power_supply_am_i_supplied to return -ENODEV when apropriate")
Cc: stable@vger.kernel.org
Signed-off-by: Tim Douglas <me@timdoug.com>
---
 drivers/power/supply/generic-adc-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 185f55d2f..9bfd8c9b7 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -130,7 +130,7 @@ static void gab_work(struct work_struct *work)
 	adc_bat = container_of(delayed_work, struct gab, bat_work);
 	status = adc_bat->status;
 
-	if (!power_supply_am_i_supplied(adc_bat->psy))
+	if (power_supply_am_i_supplied(adc_bat->psy) <= 0)
 		adc_bat->status =  POWER_SUPPLY_STATUS_DISCHARGING;
 	else if (gab_charge_finished(adc_bat))
 		adc_bat->status = POWER_SUPPLY_STATUS_NOT_CHARGING;

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.54.0 (Apple Git-157)

