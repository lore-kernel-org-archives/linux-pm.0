Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A4E3D9DA1;
	Tue, 25 Aug 2026 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664461; cv=none; b=iZotZJYN7xpJhv/sRICR5J91KU8jXs5Z5Ur3nu9TvtmhxC6fvGpn9aqfPe0j65XMEP0GZUnnCQKFELEEssGZq+uCq4W43DgxBLzZvrRvF0y+s117UlvT0A5V0xnmD2qTfdj3Fw66L7lkz0s7mkq6UWt4fslahHozMp6CWOpdKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664461; c=relaxed/simple;
	bh=ilpVLALwlvTAzh0wvTbGJuI/TaSk5Kn29ks4pKAVk6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rSEZl1vqqmHLxrM3ZCyqy4SYnXspiUSXvZR8B1frnbwcAAhShG2L2ZTutXNHIfESgf6K6TJBiUu9bnEOPDwWTbTaS+XXzGAGy923v4whZzfDIF1ec2BDm/8SNyLT10qG5rGVLEI0jw4Vi1WQdf3YT0eIA43cdLe13RwxPIN6SaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy3+DCwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy3+DCwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCAA1F000E9;
	Tue, 25 Aug 2026 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787664457;
	bh=DqA8NXxoJwuxyBglxq6L6D8V/R/BLqhNNu312R0Q/yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vy3+DCwTUDVqkq/XhHLoL1vx76Qx6FTOPcbDbxerSGvyuU+K3kli2eafebQtvOJMj
	 ZchGeAT6FK9ebXJWctJuEvQEQT67IqCVxTbZEeTGMfvWxCIlLW5k4FWgh7GCHfYcSd
	 Q0L860Z0BMMwlQlSSliM1Er8bVCp7BuMdQNN4QGNVfZUMu7yEkWUHZW9+48iaxSi+2
	 fexfFEFAZrtxt/yxY7N4QCuT8NVqHXP/MB+uTpPAOLoYxPa/XYDdLiIQ88LSoUF+ja
	 qnjuqLDEodlPTHhIBVmf2cxzwvRpGVatJE4yzE92l2glWnANCiHv9cxv+Udbhd/w8z
	 ItAulDnygnJ7Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM MSM <linux-arm-msm@vger.kernel.org>, amitk@kernel.org,
 Thara Gopinath <thara.gopinath@gmail.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject:
 Re: linux-next: Tree for Aug 21 (drivers/thermal/qcom/qcom-spmi-mbg-tm.ko)
Date: Tue, 25 Aug 2026 15:27:32 +0200
Message-ID: <6027571.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
References:
 <aohvcP8ch-Zn6tV-@sirena.org.uk>
 <580f9129-de4a-472e-bebb-d08d9cabad7f@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Monday, August 24, 2026 9:15:16 PM CEST Randy Dunlap wrote:
> 
> On 8/21/26 8:32 AM, Mark Brown wrote:
> > Hi all,
> > 
> > Changes since 20260820:
> > 
> > None.
> > 
> > Non-merge commits (relative to Linus' tree): 7073
> >  5989 files changed, 509370 insertions(+), 156446 deletions(-)
> 
> on x86_64 allmodconfig:
> 
> WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'devm_iio_channel_get' from namespace 'IIO_CONSUMER', but does not import it.
> WARNING: modpost: drivers/thermal/qcom/qcom-spmi-mbg-tm.ko: module uses symbol 'iio_read_channel_processed' from namespace 'IIO_CONSUMER', but does not import it.

Does the appended patch address it?

Interestingly enough, it doesn't complain for me when I build the
thermal tree merged on top of the current mainline.

How exactly do you build it?

---
 drivers/thermal/qcom/qcom-spmi-mbg-tm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
+++ b/drivers/thermal/qcom/qcom-spmi-mbg-tm.c
@@ -252,5 +252,6 @@ static struct platform_driver mbg_tm_dri
 };
 module_platform_driver(mbg_tm_driver);
 
+MODULE_IMPORT_NS("IIO_CONSUMER");
 MODULE_DESCRIPTION("PMIC MBG Temperature monitor driver");
 MODULE_LICENSE("GPL");




