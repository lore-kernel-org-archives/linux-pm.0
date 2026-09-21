Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9E3ACA41;
	Mon, 21 Sep 2026 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026607; cv=none; b=Utx7Eqr/bFjWJbyYyhJSCyilSsqTM9WUSZW9sj9UVi3TtVFEDDtoLv6qNT4fS+9ourbHeyQuYeJ5dSdLVvYAN3WGwLBNCFVKUNtlNyqzGrQc6g9nuyFfhvAKlG38rFESlopu1YDePqn1/ezxKofDB0t5VarP2cWON2m+CnuQwIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026607; c=relaxed/simple;
	bh=KwPXynyHS2UagXRCNTbG9yWIUZvfJFfM8OpM9Eonpfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IsAE2Lfcej28bnGEKN8/VLd9IJNHNJwWFuk5g2BqkXoh9r8gPgifiUSvQttE40HBFBSLMx8gR5GVfhDdx4v7N31hi0X7q97lzC14faFQQQ1oSXVQXk7qMUxl6cwdHctyye0jYpeGazM1ekECptIuvJSeMLsS/LuwcZ+yydZQQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qb8tIQ7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qb8tIQ7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1141F000FF;
	Mon, 21 Sep 2026 21:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026606;
	bh=xULTrItvM78QwpURJTrqOt7JvDij45NylIm1v/3WIYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qb8tIQ7JCIa03jC3bRG4tMPUgmfSAJuJYp3gP9LkZ9/cAzIC4/kSd48QerP+CYLgz
	 GJk+fa1+MkHOCYaoAL8ST46dWt3dX3alDlY4L16qe7DVp6Lsy8KgSa7k5x3GiUpUsD
	 ZbRCz9zIFJO3a5nTapWcF43G0IoZW9SPQt5Rw2LwPD3jZzBiLpIAdbVUgp6DOYdBaF
	 9gU5nubqiNXUpdhkbB16Q8E1oXtqJu14eDu4e84GXaoUDGX49N8uWILY7iC+LNpCJ2
	 NfncUDA7HQGMa+PL6hbBUTIk8/GeRDqDair3Hadx+R0zteIY4iRIovbyRekBccH9FQ
	 WU41cJP7NsHQQ==
Message-ID: <2e666363-9a57-41a0-9605-db0dee304f52@kernel.org>
Date: Tue, 22 Sep 2026 00:36:36 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "interconnect: qcom: x1e80100: enable QoS
 configuration"
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abelvesa@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mostafa Saleh <smostafa@google.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>
References: <20260915123703.3228329-1-maz@kernel.org>
 <86y0cu49iv.wl-maz@kernel.org>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <86y0cu49iv.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 11:47 PM, Marc Zyngier wrote:
> On Tue, 15 Sep 2026 13:37:03 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> This reverts commit 5a8b2cc36e796d595c9d97eab23c2be22805cc1c.
>>
>> Since the introduction of this QoS change, X1 machines based on the
>> Purwa SoC (such as the Lenovo Mini X) take a hard reset at boot time.
>>
>> Other machines based on Hamoa (such as the X1E001DE Snapdragon Devkit)
>> end-up with a similar hard reset while under load, most likely due to
>> the PCIe ports being starved of traffic.
>>
>> Revert the whole thing until someone figures out what magic parameters
>> allow QoS to work in a sensible manner, as a usable machine is somehow
>> preferable to one that crashes efficiently.
>>
>> Link: https://lore.kernel.org/all/apgeBNSiP01YfNcs@google.com
>> Link: https://lore.kernel.org/all/86ld9d4h4n.wl-maz@kernel.org
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Cc: Georgi Djakov <djakov@kernel.org>
>> Cc: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Cc: Abel Vesa <abelvesa@kernel.org>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Cc: Mostafa Saleh <smostafa@google.com>
>> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
>> ---
>>   drivers/interconnect/qcom/x1e80100.c | 485 ---------------------------
>>   1 file changed, 485 deletions(-)
> 
> Any update on applying this? These machines have been broken for the
> past 4 release candidates, and it'd be great to get them back to a
> working state.
> 
The revert is in linux-next already and i will propagate it as a fix in
a couple of days. Thank you for the report and for sending the patch!

BR,
Georgi
