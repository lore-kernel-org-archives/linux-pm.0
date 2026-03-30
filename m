Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB132A3DE
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882544; cv=none; b=Xc3bhEeivneKbi6I8SveHekoIzM0cpp18eM21yPmHNB6zN084N/L0nj7f0PkTLNtk1ivQTpFYxa7NiegfqIM6Bmq8WsldQBow3AinukOERs5qRAFYCgSzebqZRS33QMJXr8yTs6BGYnpwbbgt97jRyojMsbIPaZwGh+a1yH3uog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882544; c=relaxed/simple;
	bh=ALD3uDNicTlrTjfpZN84frj9IWM1PUG20b/GPPZcjkw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=E1nefVk3tBNntorAi1P++pokKhBRVAm8J+dUYaaAdKO6iEjJDXV7v5Dnq6YwtUGWzyZ6RdpfGc/s4yPEZoT2PaDy+VlgvbTLbZ5aU5ror/b4SoQ77YZ2eO+31v9v6JfRBUSK9/xCzxmONqBY+6wQVDAAWCRZItl+768aJJVOA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=D0xGysUO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="D0xGysUO"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b97c44417ffso482518266b.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 07:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1774882541; x=1775487341; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=469O081Aaa7aoFYWvcsfiJCJp8arQcJSe+eDYXLPnyA=;
        b=D0xGysUO4tD9ilbCGSWDFxnbQ1YttanWFBZtidn+/fV6kkOfmpuTCaqgcStYnN/A2f
         1rV0HvtQDwqgger5BwCPl1z0/A5QiF8mpqOwHvVM26IKlxdEWlHrq2QsyUjSm3XreuWJ
         7m0vMn+w8eBNjZJv78Tvn1CWzBi9yrdl1xaI7McMKv1iivjDm98W4GZQE4sSLNoQd2as
         ddYUeuhvPl/Qn/SsN8lKz6FqtyQ5j9YzybZeMG8R6MAv3AVgxAu7gONb+I5chp7MjUqy
         wKaNgfYHJP2dE8xptw+CggpzCmROvoQgM/VbSsYCIo/D2/bknx4Tp30Br4NK0qz4vE1B
         FeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882541; x=1775487341;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=469O081Aaa7aoFYWvcsfiJCJp8arQcJSe+eDYXLPnyA=;
        b=LGPWT3i0GKhWTZzXisj4LHxaT06/uYjCfysqsBx+CsI7320W5o54i2oHwJhayUrsYM
         sudb+akBheRN+g4SSljffaHWDDFb1E4Im0gqYTS0XL0bN3qGJvbKg8H1iVWG4mj9Jcoi
         IccnyqTRSX554aZrEs2UCL8TWt6XQ8EvImYObmkBHHHoFWgImabkumRQCYj0+ZdeyV6j
         iC+6/SJxfrM98tuW7ICDqDlux52rciwLliNIuxcfs8VRPTIucG9Dj/IP5bdo8zrUXr8z
         dLDiBc7cRBPDnHTgo4BiabVzQ6vQepxNUpR+OxZigryEsrdMXcEl5xmuaijx7Alugg/1
         wWHw==
X-Forwarded-Encrypted: i=1; AJvYcCXXt4KVnBSNjVCX/TUXo6HTCsO6lSnKHmRYd9eIX4lgL4W0oSBtHgRk4yfcV6wa/tTEdHCa+qCQsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+E6W10iL03LUJjH+fHwucrgF/UNoCb1kToGZ8FW9UPmZ63rf
	NuDDy6HYs7zmxZ1Hm8aS9ZD3HVLZQzndDf1dqU2c9CokTCWbbDGGxI4GhFXBJ3M72mw=
X-Gm-Gg: ATEYQzxFjXY4BSY2f26vYfOSzlpcgy6S0GfjZfHxQb8zI2wmJ8wdAooowW0zR3yD935
	3CjNP0XPmf0tKJWbvG/450qGxoBjfdtBrn0b2Vz/CCrNi8yzx+vvqdh3plrnh8d7Ra4Gay9makM
	XMpTXsFLKy7+pxIjWHzgSHP9nioPlvGZSQNRlC7qTds+NRA+ryjyJYEAb9Nob/56XLlfJhM7zwC
	WzNjcyyf1EZbXzphaE7E5ZC32WaE04mEKePx/alJb6Wdi86zjeQaVkl3JK83e4RWR7xGA8s3tZ8
	Krbt9MQt7vV9mD3YvtadU3QP6REX3m7m31ZPYvjR0EL/ujqibrrFM25P7S210kURSWubWUg9x0z
	aH7mjtCQ8Z/A8n7m1zGxlR0eRaBGpG1+OIyRZti6v7Gb2XFtxpYbVueEGU3afVxg+tgfQ1w7VWG
	SsRcV6z7LOuqzmn5/GzqXgOHBjk00VfS+GPNn6exPpK9NGDaVdcKHWWePJ2ocpGRl+JzMg
X-Received: by 2002:a17:907:7a89:b0:b98:9da:4d94 with SMTP id a640c23a62f3a-b9b5095e40amr877735966b.48.1774882541028;
        Mon, 30 Mar 2026 07:55:41 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1a5fbesm301940766b.37.2026.03.30.07.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Mar 2026 16:55:40 +0200
Message-Id: <DHG7CMLREKDF.2L5V5VQCEYDKH@fairphone.com>
Subject: Re: [PATCH 2/5] dt-bindings: clock: qcom,milos-camcc: Document
 interconnect path
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Mike Tipton" <mike.tipton@oss.qualcomm.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Taniya Das" <taniya.das@oss.qualcomm.com>,
 "Georgi Djakov" <djakov@kernel.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-camcc-icc-v1-0-400b7fcd156a@fairphone.com>
 <20260116-milos-camcc-icc-v1-2-400b7fcd156a@fairphone.com>
 <20260117-efficient-fractal-sloth-aaf7c2@quoll>
 <59d9f7ff-4111-4304-a76c-40f4000545f5@oss.qualcomm.com>
 <9f8619d4-43ac-4bc0-9598-c498d59a27b8@oss.qualcomm.com>
 <acH7aEBvSbiNwhBz@hu-mdtipton-lv.qualcomm.com>
In-Reply-To: <acH7aEBvSbiNwhBz@hu-mdtipton-lv.qualcomm.com>

Hi Mike,

On Tue Mar 24, 2026 at 3:48 AM CET, Mike Tipton wrote:
> On Mon, Jan 19, 2026 at 11:28:07AM +0100, Konrad Dybcio wrote:
>>=20
>>=20
>> On 1/19/26 11:20 AM, Konrad Dybcio wrote:
>> > On 1/17/26 12:46 PM, Krzysztof Kozlowski wrote:
>> >> On Fri, Jan 16, 2026 at 02:17:21PM +0100, Luca Weiss wrote:
>> >>> Document an interconnect path for camcc that's required to enable
>> >>> the CAMSS_TOP_GDSC power domain.
>> >>
>> >> I find it confusing. Enabling GDSC power domains is done via power
>> >> domains, not via interconnects. Do not represent power domains as
>> >> interconnects, it's something completely different.
>> >=20
>> > The name of the power domains is CAMSS_TOP_GDSC (seems you misread)
>> >=20
>> > For the power domain to successfully turn on, the MNoC needs to be
>> > turned on (empirical evidence). The way to do it is to request a
>> > nonzero vote on this interconnect path
>> >=20
>> > (presumably because the GDSC or its invisible providers require
>> > something connected over that bus to carry out their enable sequences)=
.
>
> The GDSC itself shouldn't depend on MMNOC in order to turn on properly.
> It should turn on just fine without it. There *is* a dependency between
> CAM_TOP_GDSC and MMNOC, but it's in the opposite direction.

I can personally just write from practical experience, as Qualcomm
doesn't share any relevant documentation with OEMs.

Without this patch the GDSC refuses to turn on.

[  291.055839] ------------[ cut here ]------------
[  291.055860] cam_cc_camss_top_gdsc status stuck at 'off'
[  291.055878] WARNING: drivers/clk/qcom/gdsc.c:178 at gdsc_toggle_logic+0x=
138/0x144, CPU#4: hexdump/1995

With the patch it turns on just fine, no issues seen.

As Konrad has written, originally I didn't see any issue because that
interconnect was being kept alive by simple-framebuffer where I've added
'interconnects' to keep the framebuffer alive. However when testing
without this, the GDSC would refuse to turn on, which led me to this
patch series.

Additionally you can see in downstream devicetree you can also see an
interconnect defined for the "cam_cc_camss_top_gdsc" node:

https://gerrit-public.fairphone.software/plugins/gitiles/platform/vendor/qc=
om/proprietary/devicetree/+/refs/heads/odm/rc/target/15/fp6/fps_overlay/vol=
cano.dtsi#2943

Regards
Luca
