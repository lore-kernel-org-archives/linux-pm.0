Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D83EFD05;
	Tue, 30 Jun 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816594; cv=none; b=gDM/f+0n0Ze3xnj/+lUrMUhRLdxKoU5sGdb+vUywi9V3b3NxnDgKBXy8ep8WcaSmJT1XWIcj+Te0aG5Qct7dgr+6ouJrFTmR8+ehcw6jbWNA0jC4PSLgYs5dpWnlZ0wFzbPECWjPYBK2NSY771YDnmWLuonntxmjS1uoYimT588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816594; c=relaxed/simple;
	bh=NlpX9UoWNyzeg59sSJOgZEL2fyaz1wj1pP8jjm6x70c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlExfJgFntQMek0cp2p8Fy097xYZELju7ByFy+8OYPj+qW6S25Ume+S9+Y9O9xy3fOwPF3KPrvd8CEBc40v2led4hMyOnD48m+fYNsfcbuM169Se55YVipLAEX2LmwatSgOUCx8CnDVNkpJ0CszhBJAzRNKysoW7UuKELj0z/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPrHpP1H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPrHpP1H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4231F000E9;
	Tue, 30 Jun 2026 10:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816590;
	bh=cs1BN/dc3jQRp4dvjVloKiR9L+c1KPbiqK4+0rv5KqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NPrHpP1HeqpMlV5o7zv2eO4akQdALJkAHY0EAFJoOog+PvC9fmMzgx47T5eARQr/c
	 r6pMIq+rQKrIOAtpmj28gu0/cbT9ZkaUEYTdLjHORNWTJlJWaPnyWu8npayp3PZOvK
	 BtO5HF9aq6vus7NSv06G0IR3oLcKDBWtOrPmP8gLBSfcWonDezYiPJDSTZOAM3aYEc
	 ZZQBu/n+ZysA2G58CQs/PC+gsGGGRfroOfJaefj7f29hwb+bR3ZoR1YL+TEw18jd8B
	 qmtWK40Cfhrv1Kj1v3FRjwp8DmrMzOuMx0FmSaD76ETizD+BdFbHdMFnRddIgiUr1Z
	 y+SQOeYrlWTlQ==
Date: Tue, 30 Jun 2026 11:49:45 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] ACPI/PCC: Preserve platform-populated PCC signatures
Message-ID: <20260630-loyal-gray-polecat-a68c0d@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <10fb88e6-02f8-46b8-9665-db94a4035c5d@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fb88e6-02f8-46b8-9665-db94a4035c5d@huawei.com>

On Tue, Jun 30, 2026 at 05:25:20PM +0800, lihuisong (C) wrote:
> Hi Sudeep,
> 
> On 6/28/2026 12:37 AM, Sudeep Holla wrote:
> > ACPI PCC shared memory layouts reserve the first dword for the PCC
> > signature. ACPI specification defines the signature as 0x50434300 ORed
> > with the PCC subspace ID, and ACPI 6.6 clarify that the signature is
> > populated by the platform and verified by OSPM.
> > 
> > This series centralizes PCC shared memory signature validation in the PCC
> > mailbox controller and stops PCC users from rewriting the signature before
> > each command. Clients that previously copied complete local PCC headers
> > now update only the mutable command/status/flags/length/payload fields.
> I am concerned that this may affect the functionality of drivers on some
> existed platforms.

One other option I was thinking is to not issue error but just log the error
message and let the client driver add that additional check if required.

> This largely depends on the implementation of the platform firmware.
> 

Sure. However I always expected it to be taken care by the platform, v6.6
just adds that clarification explicitly. It was never clear that the sender
or the OSPM needs to write that signature, so I disagree that it is platform
firmware dependent entirely. The clarification wouldn't have got added if
there was any disagreement on that fact.

> I think it's good for the signature to be filled in by the command initiator
> and then verified by the recipient, as this is how this field can serve its
> purpose.
> Otherwise, I really don't see what use it has.

Please get the spec updated accordingly, we can just change in the kernel
based on what we think is the best way to use it. It needs to be clearly
specified, otherwise it may cause issue for non-Linux OSVs.

-- 
Regards,
Sudeep
