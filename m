Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EF71E230F
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500138; cv=none; b=E5vWJBPC9/IVrgSz4Zo5XfnQ1mt5S6ayy7Qel3D9JvpCnsHRXnyDawSnlobFHWiOa/vCeoJjFKqCUA4lwMCyirRkYVFscLLUe/RywHxFkCZD5RKno4jlrB25Y41BQvNbUEYVhVXaWufTMN4xazBuKKeEBHDWsnEjkFgBy7XCVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500138; c=relaxed/simple;
	bh=WEDmHysJVhid3afxmi1NKI2Wun7Qn4aO8oEdozEJrWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zk9pdPiHf3E/KNkMI25wmiXXIXignoKNkwFzCnZpRxuczQMCh6in4S5uByQKm+egXgagAkkHFsgcxuf9t8olkbl8PnaA1py+4H3RhyM0qqfj+CFwBDyfSkLWzNPXBrCmEUp1IODiHMFTQ4fJtI4TXUleVukdvila+5OZzx6ESuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA88DA7;
	Mon, 21 Oct 2024 01:42:46 -0700 (PDT)
Received: from [10.57.65.103] (unknown [10.57.65.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D9973F528;
	Mon, 21 Oct 2024 01:42:15 -0700 (PDT)
Message-ID: <b87693fd-4c24-4fcc-81fc-24ae5feda6b9@arm.com>
Date: Mon, 21 Oct 2024 09:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] Add thermal user thresholds support
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <af8d8c7d-2f98-4607-a096-f85a9390489d@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <af8d8c7d-2f98-4607-a096-f85a9390489d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

On 10/21/24 09:28, Daniel Lezcano wrote:
> 
> Hi,
> 
> as there are no more comments and I think I took into account all the 
> feedback, is it possible to merge this series so I can get rid of 
> monitoring its status ?
> 

My apologies, give me 1 day. Today I will test it and review.
I've seen some previous version and haven't seen any major issues,
so this one should be good IMO.

Regards,
Lukasz
