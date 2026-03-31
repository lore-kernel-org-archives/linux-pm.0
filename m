Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDE942048;
	Tue, 31 Mar 2026 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774958319; cv=none; b=QYEeIot2rZluDBe94yM57J21qChsqTMfW94QUS0vq0CuvJlVYv544dVVdI1egn8v7V86oSAJAgOLTRDQ49kDCXzvMNISVP55zKo2V5YM3M1qtFlo2YxYZB6+Qw+4F65lHsPk8FO74XnHqHIxkaIOAX72o2XqWEHgrInp8LL3sg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774958319; c=relaxed/simple;
	bh=xdWvgxD2CoLZZjCxaljNPQR7rHS+ImRdwhpqkAKT3uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbVMjEMCy8Jf2V9jZmfu1KEWSG92CO7jxY3XhXFFSVw8uQBmnt6XSwpqnKKNoV2lKmVMPFDnZyhxDwm7PmWFf7h7VE1erhCIEOV32FtZqI8iWQw86ou0EfC99GxjmczrZD6E4x9NUKRBLB4ZEzSlWEydqtqBtLEmwNXGHkdsKbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LredU0K7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LredU0K7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E0CC19423;
	Tue, 31 Mar 2026 11:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774958319;
	bh=xdWvgxD2CoLZZjCxaljNPQR7rHS+ImRdwhpqkAKT3uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LredU0K7h0+/PPX44Bxn9931KV/cYWm4TMLInOXzkTXc3ZewY4vKkX0beNFeE3tUR
	 3XXPxY4hlVordcsQxisj9Ktdsml55oMSelcja22F1swlPC0WlDFOLZsPbHAmxkEsEQ
	 mlqQ3ksZuz7JBG/P/i0ptiUArm9/1DP+rjOVujNlLD3J30cLnzpC0DIXyqxh0kt7md
	 68Aa7J1tyOtV1JyvIKwhMtKMpYxpiB1H7KLRszARcQ3uKl2usNOPl0Mw0w80Fgl/2w
	 071nMMC+HslHQZb/lIZTepUSWK/dkeAH9ui4CHbmOL7WGQQFwxeHMMpAWpx9vWU3MA
	 THwa7V2LnUaWw==
Message-ID: <9945098c-d384-461f-9c20-41ea8be42c84@kernel.org>
Date: Tue, 31 Mar 2026 06:58:37 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: amd-pstate: fix dead links in the
 reference section
To: Ninad Naik <ninadnaik07@gmail.com>, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 corbet@lwn.net, skhan@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, me@brighamcampbell.com
References: <20260330190855.1115304-1-ninadnaik07@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260330190855.1115304-1-ninadnaik07@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/26 2:08 PM, Ninad Naik wrote:
> The links for AMD64 Architecture Programmer's Manual and PPR for AMD
> Family 19h Model 51h, Revision A1 Processors redirect to a generic page.
> Update the links to the working ones.
> 
> Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>

Applied.

> ---
>   Documentation/admin-guide/pm/amd-pstate.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index e1771f2225d5..13d6580894bc 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -790,13 +790,13 @@ Reference
>   ===========
>   
>   .. [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming,
> -       https://www.amd.com/system/files/TechDocs/24593.pdf
> +       https://docs.amd.com/v/u/en-US/24593_3.44_APM_Vol2
>   
>   .. [2] Advanced Configuration and Power Interface Specification,
>          https://uefi.org/sites/default/files/resources/ACPI_Spec_6_4_Jan22.pdf
>   
>   .. [3] Processor Programming Reference (PPR) for AMD Family 19h Model 51h, Revision A1 Processors
> -       https://www.amd.com/system/files/TechDocs/56569-A1-PUB.zip
> +       https://docs.amd.com/v/u/en-US/56569-A1-PUB_3.03
>   
>   .. [4] Linux Kernel Selftests,
>          https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html

