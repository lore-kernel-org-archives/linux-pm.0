Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBBD3E5A0E
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789374409; cv=none; b=QEcw173NlbW56G1rpT3mEZIhqwJT1P8KOBlIDvIjM9vODVSLD43b+boNS6oUvCYEj/yp353E1iorAVvRg6/Usd/VxpQwjjbN3kff8Lwi6SviBnt/facFhdk/1yavfW2ukTXtitg3XSs3AieJ1uYSzZzycwC9UWxFlYcFcPszrlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789374409; c=relaxed/simple;
	bh=TA26xEZ/LjJXtkH+wc6rh6u0nbvSN8fi3WWcPpbpONU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgMlphTfGUmJ8QPVNHPfL+ydRl2niurJLXVeCwI0IiWC6PyZ52DxeNMFQNqka7MAhWzYL+mgdy296O929584qlYGBU21YYCvanXpNckNncPD8T28cQurvvWxjjb4wrRRu6EMokgLqPE/s0hY5oupS1Y30K/ZMuotOabeDFk4/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7rZ64Er; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7rZ64Er"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883751F008A0
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 08:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789374407;
	bh=e6EWldjLUV164UHYmg9SwSNk9vpahiavUGimVKHnqTs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S7rZ64Er9f2J3r71j+Ra/t2dR0m3MCQd2lZWyIajqu/P1gyoxwditamSmJAhvxfLO
	 oPuqEeUZCXSPfct5Y87skLbFYzdxrBs7ygzvAI1ulhvODDeH36Yy4wapVKHZPMta6V
	 qIosKNt2T6yX/nNiiwHxrqRS5JDVDo+RH2e7LJLdLwtV5R1W0nJdzhIK2Vzu5m+ATB
	 rfIubf7stDTGlVK6riX994NejNaH1p6zZQ7VN41kJTqT93rPJIumty0w/xQRmcW+dk
	 /+zwsJ/MZoiBqKepzlCCkPLfbDXMjS0GneU9PtrZOkKHWMV7u/AmzKmfTX45sGS/ID
	 DxVr/E2qiV97g==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1651cso1249946e87.0
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 01:26:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwD2CYMB3gmQZR0v6UW/pYWDHG4wpvPwyiwLV7N6VfGElcq/SG5yFDKxl8DGBqEeoVjGQMJ6QkbQQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lGc987SMgCImE5vN5yGgKX2oheKbx1m96YOYJrD5gOJ76P6PJu
	UIHLdPHdtbUzCK01enieQEb7PUGBO4QVHGmq0xFU5ZNNy+FjKJdhxFjwEYZQwSCwNkgW6eGoh9P
	b8A+aLk5HW0fbYA//86mHEC0vurzzhDs=
X-Received: by 2002:a05:6512:239f:b0:5b6:184c:7da3 with SMTP id
 2adb3069b0e04-5b8ae6afb21mr372849e87.44.1789374406193; Mon, 14 Sep 2026
 01:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com> <ac236a52-1293-4a70-b5ea-ec6118cb02e1@oss.qualcomm.com>
In-Reply-To: <ac236a52-1293-4a70-b5ea-ec6118cb02e1@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 10:26:33 +0200
X-Gmail-Original-Message-ID: <CAD++jLnmH31iNsOeB7CWWpxkav6qxRgU6-tp=gxZxwWz3KUupA@mail.gmail.com>
X-Gm-Features: AcwNN1UxxQOsVcBHVbSaj8l-dq0hp_W-v71JNdK8T8AJOQnCtU1FStuksPYcjMI
Message-ID: <CAD++jLnmH31iNsOeB7CWWpxkav6qxRgU6-tp=gxZxwWz3KUupA@mail.gmail.com>
Subject: Re: [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>, Georgi Djakov <djakov@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Bartosz Golaszewski <brgl@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Taniya Das <taniya.das@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 8:43=E2=80=AFAM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:

> Several patches from the series have already been picked up and applied
> through their respective subsystem trees.
>
> The remaining patches listed below are ready to be picked up as well:
>
>   [PATCH v5 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
>   [PATCH v5 07/15] interconnect: qcom: Add Kuno interconnect provider dri=
ver
>   [PATCH v5 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
>
> Since the majority of the series has already been applied, I would
> appreciate it if the remaining patches could also be considered for
> inclusion.
>
> Please let me know if there are any outstanding concerns or additional
> changes required from my side.

6+7 looks like stuff Georgi should pick up, patch 14 looks like something
Bjorn should apply to the Qcom SoC tree.

Yours,
Linus Walleij
