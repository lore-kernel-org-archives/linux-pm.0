Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107952;
	b=ksyRk8ZFz0j1XCp4B//a1QDOoml+fr3YpB2CIMX1WKbGdwO4Pbsee8wFxW0ynq5E3v3D
	 lMnlWZyToHqIpBnsPDIZHD/M20BisB2sqawW2iNbh6Ss+fdMgF5jptnszyrnsXfUSuuEz
	 oDBNM4dS+Eg9tnR8p4jX+vrlFPsSKSpMTqGKSJE8X2OFrSJi1PAKWocM+lOpb0rkI1vxG
	 frXl9nBKb6zupVX7/txIjti/iCvO7aueO3d9jJhDHvVXiDPMotu1Hk2kXZhPh3nQfHvKN
	 FJfRN6VSvjCp09Ur6+yMIJejA0sibuhOlh5x0Kd7DyAWWGfZWl3XC2PdXroa3RJ5c2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107952;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Y/nohP8oC9bMDqPNbXJu/Xy2XNB6KcMHLd3KzRmDVWA=;
	b=R5zZtFRQIh0BJIYXvwFOyGfK0n6EKhzesrDsD5u5yz/QXRq1AA3LmT7X/kSBQqc2Qg1q
	 OJJvIO0D4pmqvUZDfjbk6gkpZsxIii+OOzdfXjTeUkiQqklb6tct/zDKkgIvhb/Zdv5uz
	 AhvpwgaeCA2ojT1voDFdXe5JocElIuwjoD2fAbdnA5726iqJONA1QTWtAs/YdRuKqpGQI
	 LbamBy35C6B2EeRbiKXK/t9W3IY3ZdMUrMXf1RaGcNlJD4DQ0dmrgwq9kugCGktmBUztX
	 Bl5lF9vhj63yAaZ8ehteayIyXkwX6oSLc28JyVGf6yC8rUDb3gvvAm7hnMiZQ/hn1AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=pQOk+Bto;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30992606A31B
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30992606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=pQOk+Bto
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=Y/nohP8oC9bMDqPNbXJu/
	Xy2XNB6KcMHLd3KzRmDVWA=; b=pQOk+BtodAzrE29OWE/WhyAxLulS1NavNFYuT
	MBAxvUN5iZUq0/X5kc32ci/PSKXej43D4wxMzqDo9Jk//XzMpBYF7zRNiB5D5pVz
	JcnTyTJ76Sb8aBxVnc1crRpWR7WikymjEQJiClSJqs79etvjgH0HO9JtpDFhXolm
	37i2Nk=
Received: from [127.0.1.1] (unknown [114.214.177.11])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAXmDztp+BqSXBRAA--.1888S2;
	Tue, 27 Oct 2026 21:32:29 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Tue, 27 Oct 2026 21:32:29 +0800
Message-ID: <179310794919.246319.18194934566240136@mail.ustc.edu.cn>
In-Reply-To: <20261027132949.242685-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <20261027132949.242685-1-xiaqinghuan@mail.ustc.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:3pYKCgAXmDztp+BqSXBRAA--.1888S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyUAFWDXryUKF43Xry8AFb_yoW8Gr48pa
	y8AF43Kr1kJrW2ka48X3y7C3ykZryFg342kFZ2qFykuw4YvrnrJrWUt3WavFn3ur4fZFy3
	ta1jqw1YvayDtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bYhLnUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiARENB2rfqlZqOAAzsy

Sorry, I should have tagged it as v2: the patch I sent a minute ago is a
resend of the 13 October posting, not a duplicate.  Only two things
changed, and neither is code:

 - the baseline moved to linux-next (2026-10-27);
 - the commit message corrected one claim.  The SM8750 PMIC GLINK node
   lists "qcom,sm8550-pmic-glink" as its second compatible, so today it
   resolves to the SM8550 entry and advertises POWER_NOW through that
   property list.  My earlier text said it falls back to the SM8350
   variant, which is wrong.  The observation itself is unchanged: the
   published value is the maximum-load number, not an instantaneous
   measurement.

One more data point, since the vendor drop was requested: the OEM GPL
drop for this unit (android_kernel_lenovo_sm8750) drives the charger
through the downstream qti_battery_charger, which depends on interfaces
upstream does not take (qti_pmic_glink, battery_charger.h,
panel_event_notifier.h), and its own copy of qcom_battmgr.c predates the
SM8750 variant.  So there is no reference implementation of the battery
side there.

If you would rather not add a variant for this, the alternative I can do
is a flag in the variant data that drops POWER_NOW from the property list
- behaviourally identical, one extra preparatory commit.  Say which you
prefer and I will spin it that way.

Qianhui

