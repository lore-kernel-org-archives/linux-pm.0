Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237F2DC334;
	Fri, 28 Nov 2025 21:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764366522; cv=none; b=l6wcHbsDlT5KsS+pvl0wRNYh4HwzymFuL1kdqYGS9yFwOznpCrnhkIzMJrApoNGrF+EOTnd1HdLm94N1AWLFb85IP+G9a5CS8MVu0nZ5xKiTVtXnz8ubcYZmqAwy/BQU5TpLEvUHSVgkDc8/tjB69AxUHGmsOC99pbwe27hHVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764366522; c=relaxed/simple;
	bh=Tx0Qw3xQh9++IV3pmMkC/NoM1bk28feF8F2RtIPrlR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmiKnfh6EvS8+UsQtWpTgqYzAidZ7un31SiwFbnCtRBKAPezCZucYRCpz/FUMeXF9KxUrpnRYNcIj/0F7oELVwmUZdwdKjKXwHb4N1hVs9eFDujVyLTXMEIMBjNR6gTp8Fb/vIK7k5NhLhGCjiJzUrLOvMArVfn4ptuklRy/Hd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=pOop7/G5; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="pOop7/G5"
DKIM-Signature: a=rsa-sha256; bh=uolVDxZ9uNM6iJV67STmTU/q18EXFVQS2j96RNuR9Ic=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1764365527; v=1; x=1764797527;
 b=pOop7/G5LS5cpY5MSUX3qUDcOdPAycyzEdsXPPf7x67JCzZLV9ldpc0iMIFFEbLdlLoE4tbf
 eYmISdewALW/Cg7aNWmuKFSBAtLPeiGOwr+8JbnzHdwPUbElB5oLclYWGI+ZBhsE2lvS5vD95z4
 jfubpV2hCn2i327e2eQBm0qUW/KwPvK8GchqBmAi/AH2XZHLEyyziVSgB2iqYKLUzXUw8EPxbe3
 vJ14vBu4qVI1WbQoDgBTfuerEzkUrB5xvJtfuaikbeQAGFUJ+vJ39zlK30Z3dsI9O3+1eq9xBOI
 KbSksq5HOZi7ftCZipw+U9UjrbiEoOKQSOLeEGK0BHH6g==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 0e1da1da; Fri, 28 Nov 2025 22:32:07 +0100
Message-ID: <8167f52b-0a2a-4f7f-8fc3-30673f7197b3@dujemihanovic.xyz>
Date: Fri, 28 Nov 2025 22:32:06 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: power: define ID for Marvell PXA1908
 audio domain
To: Karel Balej <balejk@matfyz.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20251127190237.745-1-balejk@matfyz.cz>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
In-Reply-To: <20251127190237.745-1-balejk@matfyz.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/27/2025 8:02 PM, Karel Balej wrote:
> Define an identifier for the SoC's audio power island so that it can be
> referenced through device tree.
> 
> Signed-off-by: Karel Balej <balejk@matfyz.cz>

Reviewed-by: Duje Mihanović <duje@dujemihanovic.xyz>

Regards,
--
Duje
