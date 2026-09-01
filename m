Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D89E40B0ED;
	Tue,  1 Sep 2026 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228604; cv=none; b=tSm3O10pxe+TYzxjbjAFzhWCMw6JxBYBwvAB4wxF46NtHNOIYX5vITS0mq+HthOFR+TKSZQYkOlb7dJeDPYMMtYWeiAsjHE51OeTNuEUK0c5fcVzYDNJLJ0/pLajn2QwanBK0a4o8+YFGJ0LFHfzfaenVT4f1NYetSnEgJoAwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228604; c=relaxed/simple;
	bh=vM/b+8Lm9P5CL6sjrNCoXlhWVUIXWgvPTo9FewuChPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NglycMX5pNKdiyQnNIqAgacptc2TitpjcuP3or4VpL+HINYD+PyyqujXblmpvZ0BIfDoHEk8OAKCAsA8fs+CaMQ92+rwXr4igsFHV9pOqIPyGQbWRhhZl/0Gvu8UnGhrUXNimt7bCwBPzJn+U1IjcwBEH+ZvWWzZEkUNMbb70MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok2cON5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok2cON5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25EF1F00ACA;
	Tue,  1 Sep 2026 02:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788228585;
	bh=imccdf2g1mEFtExQXUXHUdzPH5T3kvgztV71j7lsVdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ok2cON5qzJUYs6HC/WtGf6nOZ+S7sog1jx06koojWhYpFvB1VjXlpU+vazbj6ys6X
	 5NaeODhTcaoc/Wr0vJz6n2tNSs+/7uMVVIQEQCklowwFfSRTC0jihy6WpRwsDFJhTw
	 utAT3OmjhjG2VfvLkMnFdFm2RfAE/kQ8ugvNCpyBdAyxBm35bEexK2wsO88UXt6SxC
	 J4hGZZQOjQ4lmZzuEyH0vh5MC4F1UfYUlc9dkyf+/VqvKRw7gSogBmSItmpuQXFjV9
	 sOqkbnoqyFXwJhzmXg95gCfi/FksnNECfYMWhmofd+jCJDZA4TWyC3W77+LTsVw++C
	 /fi4xgOjY/I9A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Georgi Djakov <djakov@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
Date: Mon, 31 Aug 2026 21:09:22 -0500
Message-ID: <178822856270.1835959.15842744749902984423.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 27 Aug 2026 23:21:03 +0530, Hardeep Sharma wrote:
> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
> 
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
> 
>   - Global Clock Controller (GCC) and RPMh clock controller
>   - RPMh power domains
>   - Interconnect (NoC) provider
>   - TLMM pin controller
>   - PDC interrupt controller and SCM firmware interface
>   - Devicetree for the SoC and the Kuno IDP board
> 
> [...]

Applied, thanks!

[04/15] dt-bindings: clock: qcom,rpmhcc: Add Kuno RPMh clock controller
        commit: e304e8919043712191462224ce9d40bb5f5a6bc1
[05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh clocks
        commit: 12918d595ac96b819b9c3ba0df4c6a4bf50c43a9
[11/15] clk: qcom: Add Global Clock Controller driver for Kuno
        commit: 7db06b5f624b583fa2206f98de8437819acada9b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
