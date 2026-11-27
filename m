Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821307;
	b=Y0UTA2Z95pYxLQp5iUya/ucc/LXWPZ3zezY9wFAUpKytK7XEzr0+hZpzlPOfOc3FSdb0
	 T+bIp9Lms+A7AoPau2rxTHEUWVrVY7ELgI5uo49ohPc4kS0CsFB/s1vUbc/CuJki2APUC
	 BTQ/0QtoDOUix4JGnx6AcwT8qfZgBrERuiPzOkKSfXg12xnDgI77zNNcNZsMpxAi8sqIK
	 1cxET7DrLfOBem3X+53qBpxQAQF6tbvtDP8wR46iU22VMKv2HU/S0TXKzxhEL71+1FyK2
	 qKtFFSwIsY6uyJ5OWw+j7lSR0V1dL5kw7nRvMb8tFjJREHgeNnuq4gnMB8QEf1ky3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U1M+MDeqlkODjZ50qKjXMO75f40J30DxxF3l7NYSGEM=;
	b=qLlUxWg4vZ46llOEdG6+O3xjEbWpq2wdcYdhUZQ72B1TJuRgt1wCqGPcXiFDW1cxEPfG
	 cXhZCleClZB8zaibEgWKEbPHkV5HAczhnxy5vAB1EgiZ89QKrsPapQmM1G9H3/Y8x1MF/
	 DxIuEsONbAFmimkmkxqXj4X/sIkAgBlSAtQInf0GCn/ROHBTR1e4zYNc7aWq1XvQomBso
	 MnEye6MbupDW1EAJ/1Tle2yZMh3/28ufp5ccHCh0menM5epZLaqhrpAywPbLzEPP6ELdb
	 iCl1uowAf8CDfdky/USuCWLoefv2FlDHRUc6oU+Dmli5OuIFe4LXhZ6s05l1zRh2vQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDrBk4z3;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC87606A33B
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 23:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AC87606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WDrBk4z3
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so7810218f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 15:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795821306; x=1796426106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1M+MDeqlkODjZ50qKjXMO75f40J30DxxF3l7NYSGEM=;
        b=WDrBk4z39jTSJg7fP1LZv5pSAmcolbmVo4wwWMjjlFQboYBu3wN5rJ9GYnYJV50K3+
         tkw+jwH1lJXR7gVV/OBT9/yk7tTAiZrdu2ajb+eYT+UVhWfUsEfp6iR0FSExSHMDzvsZ
         3fpjMgMby8qPK4rdWEnPxtHr3jKM0uthso6MfAww0lrr5k/+C3OtKtXfdvcLi7gHPltW
         qCeMSaWpCWUuLbQVELMCkcXgultuZ6nRhj58FRGzZaFMWHaLx3Tjc30C/hZ5vAlCSiMn
         7dF5c687gdpqCnnInSFJs2GpiUdsUfdCYGv9dUppGS+08fFr1MS5RebwLf1K2w2KKf8y
         FyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795821306; x=1796426106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1M+MDeqlkODjZ50qKjXMO75f40J30DxxF3l7NYSGEM=;
        b=CPb9xuvMlSqyw/dWiZeKtwWBbxRstRP2+8uWhXBUi5U79RLhqIeC9zXQNslf/K0Ix7
         iD87NSqqEcyCkYos9X/neuC0onriQaOHdwtjqxwhNJcR+Wf02NZoloa6D+3o1+gqUkDB
         fTPEjlxNEqbsOMfvFFJNehJLH5ld959qqkrYmcKil/e6WMzzscgm84o0OeyK/1c8nCqY
         Es7EuOU6gnJjUSLGAK6IwT2bYLCa5f+KPAYtCONHlyf66tiePPXt4iRSTmsCfWhywz8U
         GK7u2FYcpJxbNcYgxAdkXdY3bQ5S/9ACC6u0mHiVEgF7TwTAzDc+ZRl2hMIECx6w+qr3
         jqPA==
X-Forwarded-Encrypted: i=1; AL+hErFBOIM1J1of6EB/qMlbMHjWby1kUZd/dNdgtAFx8VVDzq+86UHfdUUV3ZBx++sh21DXo4thJq6OcQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9TSkAkZjbiH+xKU7cBVL2aSmr4Jyit1CE7RcyyvkXY3gvJZWbi
	OXHq9cd1l3ldSQeSKd8WDKW2WeRv3D+YdrGzZtTv0E30+n2kjflbuxWo
X-Gm-Gg: AZFdTZfWBSGY9qqr/2GTMbz34HTjA98FDge8NSDl488jT16zosnNmnsXXHbGel1ESJp
	QgnCPmMs+kK5fiCrYJ49781NpN80Kjqy084kDVKbUI0nsdg8V/g53uIBwSfmqX4S+SpLvMvo32v
	lAflfXC6/0375qGb2uurP9sF6XckIXoMzkxFV37ko5mVMCR/cp4DBkZjumHZDruvYeW9etSAlwN
	q4bB5+u7LjbeG+PPFSyttLUbVd5DrqaYi7e1EGj37erco8rh8cLqsWefD4GCncArRYpha+LJ0zG
	gMa9sWTQCyfMTS6++RJ9nUE1VKt159TOdkQmCxzM4ezl3mJTroXa+wXuXIZXaT3/k1hGQVHP7A7
	vG+WvXKhQIn1oo9kSmBuySbUYenpLdCPb6iSrQoILWr5YkRapqWJ4dLl+NjOLNxSzIb1siDHOiz
	A/SONTQh4AYeFKdQdLJKFhoDzy5Ez10OqppibDJ7Qc0fEk92bJKdMNDNyyyzci47apRypWy7xay
	c4+Dp3jHXnPIVI8H6WH619BpIZUPW+EceIL/Idi71hpbJtXUiYgD2eKLm37UdNf+AolcaIrJto2
	qkoxbQstIt1q6Sp33M+9oxEj9hs=
X-Received: by 2002:a05:6000:178f:b0:4bb:c85e:d565 with SMTP id ffacd0b85a97d-4bbc86e17b5mr14733028f8f.55.1795821305534;
        Fri, 27 Nov 2026 15:15:05 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm45269880f8f.23.2026.11.27.15.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 15:15:03 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Georgi Djakov <djakov@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 14/14] arm64: dts: qcom: Add Samsung Galaxy XR
Date: Fri, 27 Nov 2026 23:14:45 +0000
Message-ID: <20261127231445.3623202-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87280d80-9047-405b-8dcc-11276d34d2dd@oss.qualcomm.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com> <20261125-halliday-dts-v3-14-5c8311c0b70b@gmail.com> <87280d80-9047-405b-8dcc-11276d34d2dd@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 27, 2026 at 02:58:40PM +0100, Konrad Dybcio wrote:
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Thanks for the review.

I've implemented support for almost all of the hardware in my
local branch and I have found that the headset exists in multiple
revisions.

So, I'd like to make a split:

rename: halliday-samsung-xrvst2.dts -> halliday-samsung-xrvst2.dtsi
add: halliday-samsung-xrvst2-rev22.dts
add: halliday-samsung-xrvst2-rev25.dts

The .dts files will initially contain only compatibles.
The real differences between the revisions are the DMIC drive
strength, the display panels and their supply voltage, so the files
will be 'empty' until I send my sound and display series.

Is it OK if I send the split in a v4, or is it better
to do it in a follow-up?

Best regards,
Stanislav
