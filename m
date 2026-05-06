Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631523536B
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028634; cv=none; b=q+SqIU/7z4FRU0PY7HeHlSFaJRsmiKZ6phA8+7nes5aNVTDoex8n94qkx8SlMTtgWeO8VwKxxRAlzajUsMm6T9JUknruMhW1DvHt5lVQLwC8yetyrkarJVmTxu1Tvx8CwJaXAFsFIXopJR2dCeZ3UEh8HifVtHoMvoKU+yQStHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028634; c=relaxed/simple;
	bh=zMeXAyyLpb1ycANNIw7NwRnIidpI1as921qDmQJS1JY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U7lDJX7u5oQN25dBSdELM8pSP1UGUnNmgjTGjqbNsaakDDY5D3K4gLDz6wmtBGoqTaX9AVrS+7Y4SQnREwWGa4GuuR7sJcJ5NZfri1shvLzcQdD1W/geBRz5LtNsfH20q04ydnVOytYNbo1WJdjpk4SC8slaLv4y2y5TywEN98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzHPmpro; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E4QpPJ8k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzHPmpro";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4QpPJ8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778028631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b9H8cYKTCyIKnl9+d/AL5JHJT5IYmUArCaFMH4v5EuY=;
	b=hzHPmproW2C2ridhXsuYry5VohlLDyq/LS2iDyQzWB7hK9AlqzMag5uX0BKAU2pY56iwsD
	RDRKQ0HHKFsz2DyOKGWO79b71nezBo3CMEDOajkiSNc6Uv1Sj1a0Ga8EMyHhGeFFR36Xfs
	RJvRPlsxF2BCCRXIMO6xHOfS+BQf3RM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-hbkV5Z97Mru1RizqlbHQlg-1; Tue, 05 May 2026 20:50:28 -0400
X-MC-Unique: hbkV5Z97Mru1RizqlbHQlg-1
X-Mimecast-MFC-AGG-ID: hbkV5Z97Mru1RizqlbHQlg_1778028628
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eb82634cbeso1174119285a.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 17:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778028628; x=1778633428; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9H8cYKTCyIKnl9+d/AL5JHJT5IYmUArCaFMH4v5EuY=;
        b=E4QpPJ8kLNMULdl1YUVfQ+6z8lKShLBKXd7TCIveG2890PqK9Mh7LgyYlTyyoTK2G5
         2SF+c2k+doCaAWqCQA7UOe3N25PlSAo/6/B5szG/SyIovtfDxb6IOP5ACS5UBqlbGXw/
         W8gApWSglPcBKSP4qIHNsxa1sGJGNeQQO5w+b0wHasU07ErS6CFFF45dEyLxenmFtHK0
         mtKT1785hYBCHQhdFxCEQkhFaD9iFGI/Vd5GAimENg9l4sUmAG3OBs0xa5uAeja/LCwa
         k1VpPs5eGR7SmcoFLFckkHr7QJCsg6RSCNcZT3JbhiqW1QrKPmh1UkyJtTfI1CRDOTqV
         umig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028628; x=1778633428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9H8cYKTCyIKnl9+d/AL5JHJT5IYmUArCaFMH4v5EuY=;
        b=AyHQVbFDyHlTl9VykwvSlpggqrjE441ChkSrOlzsD/vs0acNXbv599+iP0JStPcLJY
         j/SLDxmlp0vBI1lMaZ1DRK5GSiGewO1W8L9Av2AlGSMigm6qAmO7ago1DMrwfVtQwZYx
         wEvgfjod1gEdON8AFlNLFlqopQt6vRWLd747rKUrH7l++PCE/GH8a/Zavvy5E5+eujmn
         vV9MOSjqfOPouYW7gewnx7jMKTT6JwZ0pdWLgVpUBCOajtrV1GPj+419MxBoKJbg9GTV
         02qvNJJ47hPvVdSK+80sNnh+JU3iRDSFbOMmp2avHX5JrlQoOKnwMcv2BQkxmS7+N4F0
         Sy2w==
X-Forwarded-Encrypted: i=1; AFNElJ/sm3YsaHc7CREvQy0P5udd+1EW7Ok7Obazl08ZXcVolyn/wzWZHd2Y6Fw8tRQcRgkWpF74z53VLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdepO+Bx9AXhOoyhNM9X7nnihHIQY12u+UldFymhhx2QP5ryG
	EIfT/rqN2iYKNVR8kj9fDTa1lAAYnnB9naev1HqohivPs4wgj6JRZoUTEVb0BTMKDO6fd42jQCr
	sARDXYEys2nGsK5AzXeeLBLmTiTQqDCuy3nnMl4prc88s09LyQ+4A8WvOLZLH
X-Gm-Gg: AeBDieu1XA+cI2q8eB/0WkfaxXwPcjKSE4eE4JR1PNELChkvGQ9vVsHkbUGbr2ITxT8
	9knyL8abIuTrXqBemqipz6uawRkjBLa5qw2/Fwv0bbGqNCmKYfSCgTMhu6ddyJY1tIDxJtJTl1B
	Bryjqqec8zGfwEfI5JHlR29fB4WXh+70zOafDk/DjDPUKTOf87TvTKKIoIjO7QrDUBT4QWNJ2dz
	v+koAI7KppGXi+EBvXzb5SOgYG3Otn+FT8kATgHbi9vII0PwX1kyA9pSWpSRz97RKEboq1Er2Df
	A8PH106hdfIEQYMtIjDJ8AhfTTnuDFeHR1JpuwIPjwRF0pxNzM1q/xMniW08dMETb20UlSyQshN
	8AvQdfDVitIfD0Hyq67HCQSLyLpNoe/nAZ0kS3ClqEHpalfr2kfz4Bupn5tb51pHdtgWWoGjy
X-Received: by 2002:a05:620a:454d:b0:8cd:7952:d449 with SMTP id af79cd13be357-904d5f00d9emr231853285a.29.1778028627974;
        Tue, 05 May 2026 17:50:27 -0700 (PDT)
X-Received: by 2002:a05:620a:454d:b0:8cd:7952:d449 with SMTP id af79cd13be357-904d5f00d9emr231848285a.29.1778028627449;
        Tue, 05 May 2026 17:50:27 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91fb3bsm1464933385a.41.2026.05.05.17.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 17:50:26 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Subject: [PATCH v3 00/15] clk: introduce clk_determine_rate_noop() and
 update drivers to use it
Date: Tue, 05 May 2026 20:48:56 -0400
Message-Id: <20260505-clk-determine-rate-noop-v3-0-f3f829fbacdf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrDsQNVHpVYqLoH90aJvIREpBv
 LvB5bd476AMFWR6VgcpfpIlxYL2UdG0+riAZS6mxjSdccbx9HnzjB36lQhWv4NjShvXvXfWhn4
 w9UCl3hRB/vf5NZ7nBVsAcIVpAAAA
X-Change-ID: 20260505-clk-determine-rate-noop-17a544f78018
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Abel Vesa <abelvesa@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Anson Huang <anson.huang@nxp.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Andrea della Porta <andrea.porta@suse.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 arm-scmi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org, 
 linux-pm@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=zMeXAyyLpb1ycANNIw7NwRnIidpI1as921qDmQJS1JY=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ/TXBhDD/HJ+irfPCG5f8LBYvv8Dx9dmqr4NPkLyFFK
 ++kbGS41lHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEFrEwMqxq53uRvrC91Ddt
 SpiPrVzUGZG/vn+yPrXy74upe2fVfJGRYcr2/5NeNj+qTdRbHh6S2B+gniyyo6Z0VsK7yHUStra
 VbAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

There are some clocks where the determine_rate clk op is just an empty
function that returns 0. This can be either because the rounding is
managed by the firmware/hardware, or the clock is capable of any rate.
Let's add a new new shared function to clk.c named
clk_determine_rate_noop(), and update all of the drivers that have an
empty determine_rate() ops to use this new shared function.

The first patch in this series also includes a minor cleanup to
drivers/clk/imx/clk-scu.c. I included it as the first patch so it
doesn't get buried in the middle of this series. I change this same
driver later in the series to use clk_determine_rate_noop().

Changes since v2:
https://lore.kernel.org/all/20260309-clk-det-rate-fw-managed-v2-0-c48ef5a3100a@redhat.com/
- Dropped the NOOP flag and just use a dedicated noop function.

Merge Strategy
--------------
All of this needs to be directly merged by Stephen as one series into
his tree. Subsystem maintainers: please leave a Reviewed-by or Acked-by
for Stephen. To reduce the noise, I am only CCing people on their
respective drivers.

Since there's only 3 drivers outside of drivers/clk that need to be
updated, I included them in this same series for completeness. These
should go through Stephen's tree as well.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
Brian Masney (15):
      clk: imx: scu: drop redundant init.ops variable assignment
      clk: add clk_determine_rate_noop()
      clk: hisilicon: hi3660-stub: use clk_determine_rate_noop()
      clk: imx: scu: use clk_determine_rate_noop()
      clk: qcom: rpm: use clk_determine_rate_noop()
      clk: qcom: rpmh: use clk_determine_rate_noop()
      clk: qcom: smd-rpm: use clk_determine_rate_noop()
      clk: renesas: rzg2l-cpg: use clk_determine_rate_noop()
      clk: rp1: use clk_determine_rate_noop()
      clk: samsung: acpm: use clk_determine_rate_noop()
      clk: scpi: use clk_determine_rate_noop()
      clk: sprd: use clk_determine_rate_noop()
      phy: mediatek: phy-mtk-hdmi-mt2701: use clk_determine_rate_noop()
      pmdomain: mediatek: airoha: use clk_determine_rate_noop()
      pmdomain: mediatek: mtk-mfg: use clk_determine_rate_noop()

 drivers/clk/clk-rp1.c                           |  8 +-------
 drivers/clk/clk-scpi.c                          | 14 +-------------
 drivers/clk/clk.c                               | 18 ++++++++++++++++++
 drivers/clk/hisilicon/clk-hi3660-stub.c         | 12 +-----------
 drivers/clk/imx/clk-scu.c                       | 24 +++---------------------
 drivers/clk/qcom/clk-rpm.c                      | 15 ++-------------
 drivers/clk/qcom/clk-rpmh.c                     |  8 +-------
 drivers/clk/qcom/clk-smd-rpm.c                  | 13 +------------
 drivers/clk/renesas/rzg2l-cpg.c                 |  8 +-------
 drivers/clk/samsung/clk-acpm.c                  | 14 +-------------
 drivers/clk/sprd/pll.c                          |  8 +-------
 drivers/phy/mediatek/phy-mtk-hdmi-mt2701.c      |  8 +-------
 drivers/pmdomain/mediatek/airoha-cpu-pmdomain.c |  8 +-------
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c    | 23 ++---------------------
 include/linux/clk-provider.h                    |  1 +
 15 files changed, 36 insertions(+), 146 deletions(-)
---
base-commit: 4cd074ae20bbcc293bbbce9163abe99d68ae6ae0
change-id: 20260505-clk-determine-rate-noop-17a544f78018

Best regards,
-- 
Brian Masney <bmasney@redhat.com>

