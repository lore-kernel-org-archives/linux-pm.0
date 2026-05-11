Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A33E5EC9;
	Mon, 11 May 2026 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505479; cv=none; b=AvWFBa5meVmu99sPTmxvSSghAR+NmKpHTX4I0Kp+H+tlO/O3DcTnLdl/PklKepf3BY4EhHAq09Q1FlhTNrSiRvcr2XTIB6VbdLJuCo1eIcopHIYLYPBJnc7CgPPl/t93ABaxOyFF0IQaJIvEwa5ofHaSybL+g9OrvMeniL/qsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505479; c=relaxed/simple;
	bh=1xM0Do21lUkMcZwS8TniHLHa4V5X/K9v0bdKRc6dvnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMLT1tj9qFZW1zSi22f0045fc1/S/ab9GfPcruRl8Obxa1l8DkR1ydbkXWqzimiqXEr1mUyW9W366cZTAR+BOzYRDI9XNDC+khd5rcWNT95+QO9DKsrHoiiyzukvfr8NUICMebzOp9RDG7IT7c9MBPp1J2ERyWNdZYqKoikUg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV0+gL+/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV0+gL+/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C273BC2BCB0;
	Mon, 11 May 2026 13:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778505478;
	bh=1xM0Do21lUkMcZwS8TniHLHa4V5X/K9v0bdKRc6dvnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MV0+gL+/NiF2hgdeRsE21e6vCy7M64tt8HfSrxS4ffJZ+5fusvFgztGFu3JXUVeuI
	 ZY0vil+QPsWlCWDVVcLy2HaHoYEChq2I+BnNitpeQfDt6NhHYykzgE4Yst7indnAZr
	 NWtSSBo3pr/f33WHSoXlcXl/RlF9h2nby/ja6iyWp/3tTVKR7ZM1nDuDodRmy1Lyjt
	 17CMspMOx22/Xlc36PNivhIeliR50e2kcyQyKhRWKbBjrzszkXMysMWszl2sSWiLcU
	 LZsv7YicsXGj946Ev/XZbfVX32a/VJdAFSJxRga71DKLawFltZRany2c94/Iie2b+s
	 +LJ9dxwtDxylQ==
Date: Mon, 11 May 2026 14:17:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org,
 sboyd@kernel.org, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com,
 quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
 luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
 mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH RESEND v8 00/10] SPMI: Implement sub-devices and migrate
 drivers
Message-ID: <20260511141743.251a47e4@jic23-huawei>
In-Reply-To: <20260511100805.121432-1-angelogioacchino.delregno@collabora.com>
References: <20260511100805.121432-1-angelogioacchino.delregno@collabora.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:07:55 +0200
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

Hi Angelo,

Why the resend?  If marking a series with that I expect to see it
called out as first thing in the cover letter.

Jonathan

> Changes in v8:
>  - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
>  - Changed kerneldoc wording to "error pointer" for function
>    spmi_subdevice_alloc_and_add() (Andy)
>  - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
>  - Used device_property_read_u32() instead of of_property_read_u32()
>    in all of the migrated drivers (Andy)
>  - Changed .max_register field in all of the migrated drivers from
>    0x100 to 0xff (Andy)
>  - Kept `sta1` declaration in reversed xmas tree order in function
>    iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)
