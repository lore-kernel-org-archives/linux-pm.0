Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192268;
	b=XT2tr1xMuUaTseAMAr7heZeCqiyYxyjtl4l4eBQdSnxhtBwYKOXQYyHcz5su+1ir4tMR
	 tL1k9fODUjgIXbnoE8B3DyF8YAY0WQIkMxmztEnL3bOfcc4YT3vzxLrPZSNnNqegGdGiJ
	 iLONUp7p1d2cK/yZ1/EP4HRkVMj2/Q75ONkA+Do3i5Ubyp9WRpJlRyI5w+e9vweNu5yLS
	 SkDpRdKP1yzA/Ox/0oZTGnxAykF1r3RNKuXCaezO3dXq/qOjOFH4pKGO5zgToWQcLiMHP
	 QDFBE5aN+Xb2EwykcBQJ+ahdm1/jo1nLXkQhScISPr1llpOIaDtR+3bhoOICdA5JnqQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lizOVy5JA8TKh5Yky6TmOsMP24uJtn6vdJB5vxQOYHE=;
	b=u6Z87OiH352JafK1W2aeYkP912d4ah9GYNTMs/2BGiW5ncO2evVMCjJY5qJlvS0EAlfS
	 LAy3rLTo1ApD32yB5a5jaC1CxTYDjKG87MdT7DbRKXjsSRMGHVzcJVdJS4/Ytwxj2XNt/
	 rAldLaEw+Pt2F/aCjC1TyQX5BYxkSWH/OvkvbkCW7X6AK6GTxDeLY3MuQQ8KgOMi0RQG1
	 DAj8Q7kRRPCjRRRxSw9t6h3fk8FN5A07FsMb6z/O495kUX9Epojsd+0BY13hF+RkQZN/n
	 v2DOcmMoQOMUnh4q7bCaTOlrFTlRLNqe3fzO63lX7h5W8EVKBMhRB/oQYGgJegfXMLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+kwyYZE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEEC606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 02:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EEEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H+kwyYZE
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15ea896ddc8so812587c88.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 18:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794192267; cv=none;
        d=google.com; s=arc-20260327;
        b=jDsFQnCDOmrGy8UNb5AziMFdbPARDKfl4maFWep7pgSY6Jmp79pge2yZYvVO7CYoDH
         XOJTO1akRyNUsMJDlexLP5A8a60Po81f7iIz9mQZWmWd6CbqLEJGQkuQrvlp9jYK67hG
         MjQGqOWOB6YAIt116ixJX6IpkHxze0BucMqvgNW3XiBDLEzAy2IkS4KzImuPONkAG64C
         VGyt5i2+JYU95Yw9mN/U3GdgDdC9o8A3VWNhCJhihOzW/SiyhVYr8aXecsKxnWUmKxPv
         1wFp1wgF3TfSvTugIFM2F2UCQFxs0XH9o+sA2ECrPUWDZOiewuevrkdm6ClcPi+my7aB
         Ftbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lizOVy5JA8TKh5Yky6TmOsMP24uJtn6vdJB5vxQOYHE=;
        fh=wjUldT8VpsnelSVGqIpyU2T7cuxI+Dpk0wXed9m1ZUQ=;
        b=cgUNNEi3FQI36Wx32exJbYghQZg08LxKpTkGPaRplgzgK3g0HOsrNLw4NCFZ6ppbwG
         7wfLTbsaP7ZlYt4QLLofPEYjiUePj3HAiOiKsEOyM2GhaG93oQ1H4l1K5nbSOggM4O9Y
         5GCIH+xiU5IRmuq/KqKT2U4eIeysJZ4Jy81HBlEZQauSBiKREvhZMzIll+x2l1gSCb07
         JWgxecNfZkkpm73jXwy+ideBTJMm9/JRLqOLQUL6X6CGlfBftegeGkekdmgyVfnvISZU
         LRzv4F3jYH1jf5fzLnwr6s85k1yHfFtKUOtr5atvenYtP4L+OBU/gSRsGeggy3+0OwZz
         fhMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794192267; x=1794797067; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lizOVy5JA8TKh5Yky6TmOsMP24uJtn6vdJB5vxQOYHE=;
        b=H+kwyYZEDd0R4A0FTkVD3QYfw31uPv8dnVBZ+nh7D3zue5lQXWlApwrN2t+qKvMO5X
         fosgAAv/Ifq3+tVChuvpbuxpExpKsio1+YJch0/8Z04kTStr1ucu4edsg9igk5Dn457P
         7empY6zGNQ92virgcqoWC7E30OTFchyuOBibYsJjx+oYXRRCP+9tKQyyFqdxCWicxT8H
         rPocIhDVNE2NPXXgM7mjHyytT9R0+bs/xEulfCq5iA19tOwiwOVtTElJbNUoHlgf3fy/
         rtbvX8kbhobLvbBzEFhBY+Eomy6OI2ZFLIfJl95SXChKq0pPhutZE/WaoHTKW0CHj+7X
         MqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794192267; x=1794797067;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lizOVy5JA8TKh5Yky6TmOsMP24uJtn6vdJB5vxQOYHE=;
        b=suQFHwc8akcgu5QtpzmUJ3XA8JyEIrd4KgIk6+4MNuGUMvy+ACBTRVviPtoVm18ZSt
         Vx99dy72wKIlb4tKBY/NH+NCe1XcgDGdGw6ob5FVmTv4XWANZBI2kmTYJl1CUHqL+Deg
         qZYeJ2xi7G1NdS+QYVHq4Mig2R7JVthuKwneq2F8te9hRCsqxgvtkNWN/wEhaNTgmPPL
         wPLaFsspNy5vN9V81htGvliTFlLqY2Stoz/0FOXBQ+iyDU0mP7Wnce0eqfahq2z1A0d8
         tlPB3WpJ7TrckBPin9wf2iswN2fghmyKweA3i0PH4CPZGaEwkK9uNhkfnTFTZiQzJgTq
         iq3Q==
X-Forwarded-Encrypted: i=1; AL+hErFyz7golx1USX2otfnFpaQfz84yfCYvNtgtKDBNnlTHMkT/ol0UYrPvYykFBw8kZTx0pRgGfKvDDg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+uC/LbMvuoMtpRNfJRmtSfEpMy30TYmOp3Z1ZDVqFHvMhwBlVV
	KjcpTuZdAyN9PQ2qKrLVt/+VefY7RyrkZzMyABqiBuwcwO324liCLR5QZZbx2raj8svTCMxUc1J
	bAFKtdWt5b4+e8g84KxP7l6qJzqZgtnw=
X-Gm-Gg: AYBFou1FxGTGLCtSttvOd3c+DEgU+GDyZv9ep/J4HfDnQw1LtjizRc1k3FugOFjiGmr
	/okVjB2U0c0aKUeuP2+n5UQg/oIUp3Qe8efBJkRQ3xkiowWlBED5/UmIthSCWaP7wm71BXQAN6B
	NJJdqAL0xSi545T1oHeUbUvlB6pcw8w9J07MHU49SEEiyOf7dryDJscwaeaJo9YHS/p4jbn3e/u
	IQrwnNZjNA1PgzcbvL/93NjtKNSi/b8S7rvcze+4y1h8JUWmwcPwnL7ED6iWkwVa1y6n93WkdIu
	mNyN/EFHgNx6/3SvgmE2dHaVtVSqWkafQF1Nuoj/28LsJp0e1OioqLuW+rz4DeWgMRULzOpQ+Qi
	EQaw/hPeAtRBpcC6+7qQ1DGSiY2QrRoEbFEkqPXc=
X-Received: by 2002:a05:701b:2616:b0:1b2:558a:d781 with SMTP id
 a92af1059eb24-1b39fe291d2mr3839870c88.5.1794192266580; Sun, 08 Nov 2026
 18:44:26 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com> <20261106212939.GA1814035-robh@kernel.org>
In-Reply-To: <20261106212939.GA1814035-robh@kernel.org>
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Mon, 9 Nov 2026 09:44:14 +0700
X-Gm-Features: AclHuK-MtGA26JxVmDU8vwHD7H1Dr6pcTzIJGZiqmr_2gGFPDRoc8BRW2dGJq-o
Message-ID: <CAAq9HC7Fk-duB0LKaDDKeEmLYvZuvWTBab-YpjS9x9QHm0z+7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: psci: Add skip-suspend-mode-switch
 property
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Val Packett <val@packett.cool>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Alejandro Tafalla <atafalla@dnyon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

The failure isn't fatal on MSM8917/MSM8937, so a runtime fallback
would work there. My concern is other platforms. Today, a rejected
PSCI_SET_SUSPEND_MODE makes the driver stop, which is the safe
outcome when firmware misbehaves in a way we can't diagnose (PSCI
has no call to read back the current mode, so we can't tell what
state it's in).

A generic "try, and avoid on failure" would turn that into
"continue", for every platform, including ones we haven't verified,
unexpected things could happen after that. The property lets a
platform that is known to be safe opt in explicitly.

Best regards,
Reza

On Sat, Nov 7, 2026 at 4:29=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Oct 22, 2026 at 09:41:10AM +0000, Reza Kurniawan wrote:
> > From: Alejandro Tafalla <atafalla@dnyon.com>
> >
> > On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES reports
> > that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
> > call is rejected with NOT_SUPPORTED.
>
> Is that call fatal? Why can't you just try the call and if it fails,
> avoid it. Then you don't require a DTB change to fix the issue.
>
> Rob
