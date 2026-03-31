Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5837BE85;
	Tue, 31 Mar 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982892; cv=none; b=pr/sUpaMCPRsT4SyFZ3TqpABJOU/R1FQKnl+4d5j4DD7bfhuJNkkdmBDPGYlLZKRWx4X60NMEsO8MLT2S7fedLIDEFxy5ILGOloPCKYJg4wv+DCyMGFf6hGglfvgA6PK6YYn20KS3wzaElILJOK/+dOR0ClsFI43dTpzjZjxltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982892; c=relaxed/simple;
	bh=7+xDVT/euOPXgMgFvCjqYEx67RTjkmTYbuu61ObPj1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwdeWIciWurkabyLSymL9mf71mIHKrzq4kl7lin6smVp23URhLqnHPOY3P8wNQoDG9zS9KwaJSh551k0TmSJxaYU1ZIh5RxJt1R059t3nXK44aiOLNW3efeVwW3+ljhuk4lTePf685btBSdT7FAOVSUIMJi2qn3AZnOcu45eV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP7+OLzj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP7+OLzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B421C19423;
	Tue, 31 Mar 2026 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774982892;
	bh=7+xDVT/euOPXgMgFvCjqYEx67RTjkmTYbuu61ObPj1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eP7+OLzjPolPtRkW0vBfijoMnIfCaTckBsBnsuwBWoanWTvbblJeN1+yCd2SYyYAg
	 Ku1wsFn50A56yYxpJXgNotO3OmV0b6h5A6pKrWYA8tKbQyZHq8PO9/UvJOmDU3hUOY
	 DEXpUGOfAycl73By74MnjXLXHeYDVktghQy00WcLXq8929B44Ov0o6eHMKALZNNzWn
	 32PurqdxxJZUTDWWWkPETNwoUZeStSOp81GOKBemLH3GijZHfbP4TTG9bf8CuEJClb
	 9uGpdRceAq84zBd/9Pqyh7mKxtGEn8eFBRcMeaiRtPuEoup+oWsN2+uwVBqDlIwI5a
	 HMlUoxZ7+cBXw==
Message-ID: <d2dff661-caa5-4c6f-a886-18990cbed43f@kernel.org>
Date: Tue, 31 Mar 2026 13:48:10 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] cpufreq/amd-pstate: Add support for raw EPP writes
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20260329203811.2590633-1-superm1@kernel.org>
 <20260329203811.2590633-5-superm1@kernel.org>
 <acwAGPB/38cv2oB7@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <acwAGPB/38cv2oB7@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks! I forgot to update this documentation when I changed the 
behavior in an earlier version.  Great find, thanks.
