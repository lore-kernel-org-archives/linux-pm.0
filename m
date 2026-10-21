Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590563;
	b=kRNq5QhvVKf6uh4d1CnDS8MYOhknjjPhiKuCXOyPmq0Qym3EuLYRdy/7kXdMMg/F6R0K
	 lIPCjKS2n/TBavY72eYS58QRyhGZ2RjWdUrTFxQB3UMdO4hUzKy+lWnz6FiJ7X7H8zKqS
	 NqeTo5jq1sdAWDgfpETDcjYxuCVL9G56RZloCmZULOkJpv9YxwipFZA9TfcwN3SoIC2mZ
	 J5z446z8ZjBn4ua/MFHninUMPgQPGcar2K4gS/e1R9ZGBXKFaVBsnm6OauMuKLL3lx9Kc
	 9VW/dHATQ9N9ElKsWOs8dLRpOgSR3DNuj1dQzl8afH0GWfdxE5iuNb5HY1z0JaRyPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590563;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=uZg4BKspB/y+CooZbsgJ6fLMCO5/PIy2LqC7iUq3yNk=;
	b=kXEeHMRCc4PNZNi8GLSpVh1Wwmy/tkfDqbOCV7LVppGwsJPzguvgSo2io4JS1SbJH3sT
	 AOO/fCgzvBMYgQHqPZxEJnkqftxPag074cafZ9Mn0l6FII8D/78CEMnKwYhGc8ATzPnej
	 b030FeMPnZIIC12YslAC/9dPlAoX3RuqWbbJdederBW95Ibq1IEFJ5HdTqCIbt09PK0BN
	 ZNuIBvOqBz9k3QTCtfebaX9hKF8PhWKTIAhAEgUo+xTUVmt356vWGEtbdEnF2tmmlJUnG
	 sPFwMHpC+lUiM6wuHZkHoG12OD4WP3I4cGh2S2W1BnfOGPGgiiix90jGARYaZnnREUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=PrElQ2nI;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EA3606A319;
	Wed, 21 Oct 2026 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6EA3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=PrElQ2nI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=uZg4BKspB/y+CooZbsgJ6
	fLMCO5/PIy2LqC7iUq3yNk=; b=PrElQ2nIsm9MEcoRGnwjnvUBJBgamTyjrOg/v
	/hoK8j+AT8UKFPEtKlmMWh3LM0Xbzhzs/CpMHfmLVdtzjwi5lFd/45SfMuFUWKrD
	6vm1Pzo72ZY+9T+LfFJmlRpSd+HR4vPXMtMmuUNNAiLylMd8siATq6lTjo/uG6Ah
	hfqHvs=
Received: from [127.0.1.1] (unknown [114.214.181.25])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAHfzPNwthqAOokAA--.948S2;
	Wed, 21 Oct 2026 21:49:01 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on SM8750
Date: Wed, 21 Oct 2026 21:49:01 +0800
Message-ID: <179259054168.209323.8102186130128474174@mail.ustc.edu.cn>
In-Reply-To: <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <5bf3636d-be7a-4800-9914-808d2fc5ebd9@oss.qualcomm.com>
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
X-CM-TRANSID:3pYKCgAHfzPNwthqAOokAA--.948S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW5ZrW5Jw1xCF18uw1rJFb_yoW5Gr4rpF
	Z0qF4DGw1DJFyfZryvv3yDCanYvrZ5X3yjkFy8GrnrZayDKrn7Xr9Ikr1agFy8Cr1rWFW0
	kFs8K3W5CF1DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xS
	Y4AK67AK6ry8MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
	twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUI7
	5rUUUUU
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREHB2rXwVRrvQAqsE

Hi Konrad,

You are right, and thanks for stopping on that sentence.  "Maximum-load
updater" is a phrase I invented; it is not a QBG or battmgr term from any
document, so I should not have used it in a commit message.  Let me
restate what I actually observed and what I am and am not claiming.

What the driver does (no bug here)

qcom_battmgr_bat_get_property() does not sample anything.  For a given
power_supply property N it reads the 32-bit slot that the QBG
notification buffer reserves for that property (in the SM8750 variant the
battery property array starts at context + 0x6a8 and is indexed by
property id, so BATT_POWER_NOW, id 22, is context + 0x6a8 + 4 * 22).
The driver faithfully returns whatever firmware left there.

What I observed on the unit

  - charging, actual input well under 1 W: power_now reported ~89 W
  - discharging, actual draw ~4 W:           power_now reported >100 W
  - current_now * voltage_now in the same samples stays in the expected
    magnitude range, i.e. the other battery properties are consistent

So on this platform the BATT_POWER_NOW slot does not hold a measurement of
present power; it holds something closer to a configured/estimated ceiling.
That is a statement about the value, and it is reproducible on my unit.

What I do not have

QBG firmware sources, or a public document describing the semantics of the
BATT_POWER_NOW slot.  The "it is a maximum-load figure" reading is my
inference from the two facts above plus the vendor battery property
interface, not something I can cite.  I also cannot yet say whether this
is a property of the SM8750 firmware build, of this OEM's configuration,
or of the slot in general: Fenglin's earlier reply (default supported,
OEM can customize) would predict the latter, and confirming it needs
power_now/BATT_POWER_NOW readouts from the stock Android build on the
same unit, which I have not done.

Proposed wording

I will resend the patch with the firmware-semantics sentence removed.  The
commit message will keep only what is verifiable: on SM8750 the reported
POWER_NOW is not a present-power reading (with the two counterexamples),
the driver returns the slot as-is, and therefore this platform should not
advertise POWER_NOW.  The code change is unaffected: add the SM8750
variant and reuse the SM8550 property list without POWER_NOW.

If you happen to know the intended semantics of that slot, or know of a
QBG interface document that defines it, I would rather cite that than
describe it in my own words.  Otherwise the factual version is what I will
send.

Thanks,
Qianhui

