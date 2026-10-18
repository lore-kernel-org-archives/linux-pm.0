Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7641B8DC;
	Sun, 18 Oct 2026 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317436; cv=none; b=IPfppmUEHnDDj7pBnq8vVYt4GqdAkjaYxRgmRaXBvJ0+89N8m432Fvq/Tn0PwHpyNfJncXsIHM06cmSVL3vXtX9c+EU0RQQf9IwDL040lhkjcmDE9XCxqOiDscWe4oGoUnFSV4TaDGyYmbLodKhrtxiB2tPG38Z7S1cuEFpB+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317436; c=relaxed/simple;
	bh=rUea3DCws+rncFslxzgZpDb9Tfn9iGN2SBnMV6j5Qaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To; b=h8RSdv0rPk+7EDK5F2B7/LIKySU8OO7X641GuRYEcRXevvM2lLIESVdOQNZlFN6M24g2j0SPqNQDgAvCVyUsIMf2El6pzqdv9bDpop96otfg+LtYK7uoS5jJCpDxByy+AC4sJSGcdPvzXy261KaKa4apbS6dG1YTc675/RO+LKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=izzo.pro; spf=pass smtp.mailfrom=izzo.pro; dkim=pass (2048-bit key) header.d=izzo.pro header.i=@izzo.pro header.b=Vfc2Wfe6; dkim=pass (2048-bit key) header.d=izzo.pro header.i=@izzo.pro header.b=epYghd1M; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=izzo.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=izzo.pro
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=izzo.pro header.i=@izzo.pro header.b="Vfc2Wfe6";
	dkim=pass (2048-bit key) header.d=izzo.pro header.i=@izzo.pro header.b="epYghd1M"
Received: from smtp.soverin.net (unknown [10.102.10.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4j6v2V0tTLzxKM;
	Sun, 18 Oct 2026 09:46:26 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.102.10.155]) by soverin.net (Postfix) with ESMTPSA id 4j6v2T57PVzTD5;
	Sun, 18 Oct 2026 09:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=izzo.pro; s=soverin;
	t=1792316786; bh=rUea3DCws+rncFslxzgZpDb9Tfn9iGN2SBnMV6j5Qaw=;
	h=Date:Cc:Subject:From:To:From;
	b=Vfc2Wfe6XQNccEdPYy9OGKWtLN8vVwQ3yo9ORxrxb0ogkB1acdLxHXnt8Ra8YVL/F
	 o3UlR+5NzW8fdC6zgaGcFGxT7zMcIoUroPIqM8L9//W+OsNLvyZP+QYF7LCLlSGZ5+
	 U+BD6sKMMS/SGTQ/NzNqoZNQKwjMgZsv2B9tzJf6D5eF6OmGTsfnvZGyC1Hq9aDZYe
	 a4/0LGhFnIJqsRSK+Y18NycNDcRkf49vxlcbUn27ENsFf1+4GG7cGiSvw4WR8w2imo
	 hNgxvzzaZPIuiUi1coOh9NtN0Gzfwuph6vaJMnl82MQpdTCXFfAqU2MDU8Ql+lOTO+
	 wxJ9kENAKPM3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=izzo.pro; s=soverin1;
	t=1792316786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rUea3DCws+rncFslxzgZpDb9Tfn9iGN2SBnMV6j5Qaw=;
	b=epYghd1MqXCj0kUjrB767RqUtXb99Ix2y+PbjqhEMVn7btg8WUEerNabZcLZUIRPKcKCK+
	82fQqBnowC7Ypilk+iy2XejoS5UgjY9KA1tN6wUeVH2+K83VvGuez3SDyth38t4UQrPe0n
	HkkaC1X4MRvQ8dfFm5lJtNnMOSpjr4AMeZ/pdWOEBZdXowtSQotDF027J7yxhe6hc8yEEQ
	425x07CQ3e4XoTlT3hbgWq79YteelQSgKpO5HxG0A04/Q/459Gvuv5NqwECFfiQkwT4Zp+
	p5zYgYwJkjEubyy8gUOOz1oGn6gEeDdL9h3uO2on91ejEqupDpIvXy+N3Delxg==
X-CM-Envelope: MS4xfM6vEoJgHLzdsND58SmvowWoa9xq77oOqkuzd6aACLrW8IxVx21AvrT1+viWelsOqikY1d4Tx9NKltMe6o983L2Mw1Obx+Y4zrLUjmAMDQ855f3Nq5QJ MZZ5GCkP3OGFz5sfa3vt3g+0WbmdisCqvIVT1sQ1o6R7tFp11NVWY4/BfnLFiRBQ98fRX1VM7tLkJiunEaSrg1thuB78nnJ6ptI2HcJ7W8zseP+G+gzGPUB5 T2h6e3W1PUFQSxZQAMJTYzeNXGR8gqs/4P2ssHBstiA0TC5S9BHKZhF7A/Gv3W+IKHfNV+zpaJ51L7dgmAUx4w2X4LmGu2fXT77wPLFlKr8BHn0WOxO8xvfK 214y+QSwrtG26CyC9tBjTqLpJQcGWtH6EgNd15WgYrJ7vKyY9a2ioSuefUtM4SRWxUqH8CCR/HTj61hFfHf1w5jml8tw/Ry6I6Da40pIIJYZNmneFoPvJNxP pQ2ym/Iih1SdVCpc
X-Soverin-Id: 01a14e67-c168-71c1-8639-4924ddc596e7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 11:46:25 +0200
Message-Id: <DM7V9WDDVQ2I.3THP2TDPTP994@izzo.pro>
Cc: <federico@izzo.pro>, <luca.weiss@fairphone.com>, <val@packet.cool>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC] power: supply: qcom_battmgr: implement battery charge control
 on kodiak phones
From: "Federico Amedeo Izzo" <federico@izzo.pro>
To: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>
X-Spampanel-Class: ham

Hello,

I want to implement battery charge control support on two kodiak phones:
motorola-dubai and fairphone-fp5. I kindly ask your feedback on my=20
implementation proposal below.

This feature also known as "charging limit" or "battery health" lets the us=
er
limit the battery charging range to 0-80% tipically, in order to extend the
lifetime of the battery. It can also be used with a lower range 0-50% to
prevent battery degradation on devices always connected to a charger.

Newer SoCs like SM8550 and X1E80100 implement charge control in the battmgr
firmware, but kodiak (SM8350 in qcom-battmgr.c) does not support that (I tr=
ied
using the same property ID as newer SoCs with no luck.

Looking at downstream implementations, both dubai and fp5 implement the abi=
lity
to stop and start the charge with custom extensions to the battmgr firmware=
,
while the actual charge control logic is implemented in a kernel driver (du=
bai)
or in a userspace java service (fp5).

My plan is to expose the start/stop firmware capability of the two phones u=
sing
the charge_behaviour sysfs property, then implement the charge control logi=
c
(start/stop charge depending on current level vs thresholds) in the qcom-ba=
ttmgr
driver itself and expose the sysfs properties charge_control_start/end_thre=
shold
to let userspace change the thresholds. The scope of this "software"
implementation would be limited to SM8350 in qcom-battmgr as later SoCs can
already do this in firmware.

Best regards,
Federico Amedeo Izzo
