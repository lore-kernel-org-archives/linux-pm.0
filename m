Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3350AC08;
	Tue, 29 Sep 2026 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790680339; cv=none; b=jA0bbrF3tw4TZgA6B5t3wWSBiK2wbz+GYcAKTlHaVduI/2+TH5BitYcFPiFFCHHCqmGJogKNNmvDRBRZD+3B/0ksZDmSlmmMYk1wyy7qLm0847gd/JQxQ5jf48gWXvj0YmmCtFFuBs0DHP6DhGdCQRGkS1iUpYAcZFZsc5ZvoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790680339; c=relaxed/simple;
	bh=qziH1maXlZXu8N/Fc9Re0uUZuZBPmpl2JbmoTKWIChU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtrpLWS2qH1oH/t5nNXO4yfByzhtntY/AwiY4v6dcEYA0zm7/LGwGsc7j6hzgMhGazoaL/+t4dBeQl0ln7ssnUt2t+/JPJs+McO9FijRUE5uup73NORGuhA4S3Pghj/D2FCkWZrhZfecKGaBEjFymR/zXMU7rOkEdbj9IE6R42U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol1ewM9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol1ewM9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952F01F00893;
	Tue, 29 Sep 2026 11:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790680338;
	bh=Bst6USAkA6sIXmKeO0hWSOGJL34EWLELwIC/MqzvmhI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ol1ewM9EdzBE+UGAu7v5dkt/N4OMxTumhv8y5HfGBanntaOfLezSXeo/1ZCn1wkiv
	 /ltr2ET8VQ4T9pPvKiY9M2eD+baGYf729R8kerIbAzJhl3l2ou/omItdgjLA+4nTIs
	 12GoMhrLtP4bRcJaOs6OKi5jO0CnxC9nlD72EvIeyg4+yotoNfVqsZLEiOXznPr9dw
	 0g7pE7I91B7nV+u7OYwzGB4SJNzu6mz+1ffVea6PGySu/nqICg0UwOJtBFbzNlPore
	 hcdmYRJUAPSxtXM1vPfKyN8kuvXaAmKJ3UbDftlVGOkqUI30vvVzETX0vqcPB+UGa7
	 gJNSikyCnWIdw==
Message-ID: <e1069657-439f-4296-964c-5ccd10a068ac@kernel.org>
Date: Tue, 29 Sep 2026 14:12:14 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] interconnect fix for 7.3-rc
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>
References: <20260922135416.1414403-1-djakov@kernel.org>
Content-Language: en-US
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20260922135416.1414403-1-djakov@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 4:54 PM, Georgi Djakov wrote:
> Hello Greg,
> 
> This pull request contains a fix for the current cycle. The details are in
> the signed tag. Please pull into char-misc-linus.
> 

Hello Greg,

Just a quick follow-up on this fix in case it got missed. It's addressing
a boot failure on some devices.

Thanks,
Georgi


> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>    Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.3-rc5
> 
> for you to fetch changes up to 2cc67425a97eead2e3248b6d5415c13b768ec295:
> 
>    Revert "interconnect: qcom: x1e80100: enable QoS configuration" (2026-09-16 15:55:38 +0300)
> 
> ----------------------------------------------------------------
> interconnect fix for v7.3-rc
> 
> This contains a revert that resolves a boot failure and instability on
> some Snapdragon X Elite machines (based on Hamoa and Purwa).
> 
> - Revert "interconnect: qcom: x1e80100: enable QoS configuration"
> 
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> 
> ----------------------------------------------------------------
> Marc Zyngier (1):
>        Revert "interconnect: qcom: x1e80100: enable QoS configuration"
> 
>   drivers/interconnect/qcom/x1e80100.c | 485 --------
>   1 file changed, 485 deletions(-)

