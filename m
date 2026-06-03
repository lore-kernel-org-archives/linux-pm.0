Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833F54657C0
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513060; cv=none; b=LmIEDtHnkDJrM9nYXsp2oR+FVmHLeQa6O6MGtR2oXaVU6s1HeNFYPACXUIzihFEUPjOEFCD8X9SEzmqCcn6VUbTm8zeW9JQQAR4ftLaCRy2EIJhS9p11xwGZ+173LKiHI58DZz/BlK11WjyVcJyP3x6o26IgrenlQMfyTexXg1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513060; c=relaxed/simple;
	bh=SiSt8hzbmakPRnV2hYaVnDksCH6hLKmZrGANCxDcjRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=retAYHqc62d77wvrlycJcRGHPS9SX6d1RXMnm6ZW7NbX+nZpJXpPGhSYd54dxJFN4737BvEMCMVN93ujWA7Hr+RBKfg3l4X4BS1hSDb3ckvozrec5L2fL2ObYa5AlTpYxrEyG+G1+EuC16+yPuBDQo0E+diWba6XzERPW9OQx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh/9bV69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh/9bV69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30FF1F00893;
	Wed,  3 Jun 2026 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780513059;
	bh=RX4d74f04pepuZEZJcA0ouLh0KVGVghTY0anwHnl4Tk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hh/9bV69EVBuhDHu90HITcwQlCmpoacIztc7OLK9M+haohvn2WMOkX2DXl7HTLCGI
	 NsYXG43bFSKgOiGGnq2UCtch3bKyCsO6Wg8Y9d/1WfTQwx54afsg5Qs43iXxSr9Zqd
	 Aluf2gmIprsbz/VImR9xfo/7R6lkqExhbxsfBovVRKroeyyw8yjsa/BCapz5d/DSSd
	 XoSwFDLOhvD2F0r9bRK8pDYnT2bDrHFOnjqZaR89f6c0UHvxXGcc7rHXgQrtWVnEWV
	 eUa3Z7IoqJZFae1QWZ0hOsmv2CDPuI/Fyc4iGdDKJPxvdGb9DLHvI6CBr/DE/luyIT
	 kzJI/aoFqgRzg==
Message-ID: <57ac3334-a7c4-41f3-ac9b-99993162ae55@kernel.org>
Date: Wed, 3 Jun 2026 13:57:38 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] amd-pstate fixes for 7.1 (2026/06/02)
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <2167c764-6159-4a51-b3f0-f0fbf6c147ce@kernel.org>
 <CAJZ5v0ghALXyU8tf0gcT+qirhde7ah8_rQ9+FryuArfbLTe01A@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0ghALXyU8tf0gcT+qirhde7ah8_rQ9+FryuArfbLTe01A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/3/26 13:49, Rafael J. Wysocki wrote:
> On Wed, Jun 3, 2026 at 8:36 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:
>>
>>     Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)
>>
>> are available in the Git repository at:
>>
>>
>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
>> tags/amd-pstate-v7.1-2026-06-02
>>
>> for you to fetch changes up to 5629eec1a2829871d496f3042884cdc267612f6a:
>>
>>     cpufreq/amd-pstate: Fix setting EPP in performance mode (2026-06-02
>> 12:32:06 -0500)
>>
>> ----------------------------------------------------------------
>> amd-pstate fixes for 7.1 (2026-06-02)
>>
>> * Fix a kdoc issue
>> * Fix an issue setting performance state in EPP mode introduced earlier in
>>     the cycle from new 7.1 content
>>
>> ----------------------------------------------------------------
>> Mario Limonciello (AMD) (1):
>>         cpufreq/amd-pstate: Fix setting EPP in performance mode
>>
>> Zhan Xusheng (1):
>>         cpufreq/amd-pstate: drop stale @epp_cached kdoc
>>
>>    drivers/cpufreq/amd-pstate.c | 2 +-
>>    drivers/cpufreq/amd-pstate.h | 1 -
>>    2 files changed, 1 insertion(+), 2 deletions(-)
> 
> I won't be able to pull it this week, so it will become post-rc7 material.

OK!  Thanks for letting me know.
