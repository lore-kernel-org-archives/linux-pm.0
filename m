Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343B355F57;
	Thu,  2 Jul 2026 10:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987705; cv=none; b=i7CNq74B/0ZdKv/eiw5x2Y2PaPY3mmXo4aEGCkbAlaB0kQH4guFxzjYAaNkbD+y7EPBtXezHZvpbPbCaeyBJHuBza/GGz1TIiw+npyTKdpcj7ZRcZSdboTb9yym0uX+qdqCpz8eR+BZkLt1/qI+9gTNkSB62w1tC4h2Zvzui8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987705; c=relaxed/simple;
	bh=cGr4f7bR5VMBK84qrv00rsz03dvLqLgQ0AaUzlh7PLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+eFR7Hoi1f+S0iCua26udFvJxn3Q9PgV+NJq/8LGLNoLcl41RpjlwJlhPMoXHPnjWNr9S2Qp0SPIsKp2nKQs6OvMjqNZkTgu9wKbPlw8XMGTrHpIdW2llgemNme9Z2JSCK1sFYxpeE5knUJbKzW3G3ZO5OEN77fGOJyxgoRdyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofvt0Nm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofvt0Nm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877F81F000E9;
	Thu,  2 Jul 2026 10:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987703;
	bh=1p0c92EUzb/HOdHALw9qhTbLmRIjo2ME3rKWvKGRpK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ofvt0Nm6Bas+d/2UTjYhNGvaHZR6DuUTk6QdlQ4eJj5Sa62ZTlls5XBujAkjuFHgE
	 7f4m8Tyj39LO1uVY7asLyDR27BtBJgboxv4LAtfbH5HOAzR7viZVvd2Dk53GvR05ee
	 5iAv+Z+qcblReRrDG6NMlGdK+o+yo4uhT7nUxkCBeNoOqTElqD4gz3FDI0JdXNNh3l
	 CAicILNWxwNVbozdBGWpdwvYq/SY+u0NhWxawO+EDjeecrnclYhpHehdq0erfL+N91
	 rZrZI6HOMNeg0kiIJBC3T00dE08/U+34sbyJtPjdOo935BzBH1g5V7j42z1FA9Kcq7
	 1omWR4S/8IyOA==
Date: Thu, 2 Jul 2026 11:21:39 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/6] ACPI/PCC: Preserve platform-populated PCC signatures
Message-ID: <20260702-secret-gifted-pheasant-34be3a@sudeepholla>
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <10fb88e6-02f8-46b8-9665-db94a4035c5d@huawei.com>
 <20260630-loyal-gray-polecat-a68c0d@sudeepholla>
 <6e5e36e0-c470-469e-bb16-a5faaf055463@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e5e36e0-c470-469e-bb16-a5faaf055463@huawei.com>

On Wed, Jul 01, 2026 at 03:38:21PM +0800, lihuisong (C) wrote:
> 
> On 6/30/2026 6:49 PM, Sudeep Holla wrote:
> > On Tue, Jun 30, 2026 at 05:25:20PM +0800, lihuisong (C) wrote:
> > > Hi Sudeep,
> > > 
> > > On 6/28/2026 12:37 AM, Sudeep Holla wrote:
> > > > ACPI PCC shared memory layouts reserve the first dword for the PCC
> > > > signature. ACPI specification defines the signature as 0x50434300 ORed
> > > > with the PCC subspace ID, and ACPI 6.6 clarify that the signature is
> > > > populated by the platform and verified by OSPM.
> > > > 
> > > > This series centralizes PCC shared memory signature validation in the PCC
> > > > mailbox controller and stops PCC users from rewriting the signature before
> > > > each command. Clients that previously copied complete local PCC headers
> > > > now update only the mutable command/status/flags/length/payload fields.
> > > I am concerned that this may affect the functionality of drivers on some
> > > existed platforms.
> > One other option I was thinking is to not issue error but just log the error
> > message and let the client driver add that additional check if required.
> The patch 1/6 is not good to our platform.
> Yeah, suggest to use gentle approach to do this if we have to clarify this
> signature.

Fair enough, we can just log the warning for now.

> After all, all client drivers work well before.

Sure, but not doing anything will just make the bug carry on for ever in
the firmware. SO logging warning is minimum we should do IMO.

> > > This largely depends on the implementation of the platform firmware.
> > > 
> > Sure. However I always expected it to be taken care by the platform, v6.6
> > just adds that clarification explicitly. It was never clear that the sender
> > or the OSPM needs to write that signature, so I disagree that it is platform
> > firmware dependent entirely. The clarification wouldn't have got added if
> > there was any disagreement on that fact.
> The reasons I say this largely depends on the firmware are as follows:
> 1> The previous ACPI spec did not clearly require that the platform firmware
> needs to fill in this signature first.
>      The client driver working on these platform doesn't work anymore if use
> the way in patch 1/6.

Fair enough.

> 2> We are not sure if some firmware verify this signature or clear this
> signature field in shared memory.

Anyways, better to check that for current and future platforms if not the
legacy ones.

> > 
> > > I think it's good for the signature to be filled in by the command initiator
> > > and then verified by the recipient, as this is how this field can serve its
> > > purpose.
> > > Otherwise, I really don't see what use it has.
> > Please get the spec updated accordingly, we can just change in the kernel
> > based on what we think is the best way to use it. It needs to be clearly
> > specified, otherwise it may cause issue for non-Linux OSVs.
> Agree.
> 
> Yeah, I found spec v6.5 just said how to compute it and didn't specify how
> to use it for platform and OSPM.
> I saw the update of v6.6 for the signature field in "Generic Communications
> Channel Shared Memory Region" and "Extended PCC Subspace Shared Memory
> Region".
> like: "The signature is populated by the platform and is verified by OSPM."
> But please note v6.6 didn't say above words in "Reduced PCC Subspace Shared
> Memory Region".
> 

Ah, that's just inconsistency I believe. I will raise a defect.

> I don't know why v6.6 specify like that.
> After all. all PCC application parties (client drivers) in Linux have
> already filled this field.
> 

I don't think what Linux drivers should be the reference as there are other
OSVs.

> According to my understanding of normal signature in communication,
> it is generally filled by the initiator (sender) and verified by the
> responder (receiver).
> In this way, the data is valid, and the signature is meaningful.
> 
> If it is only initialized by firmware, and OSPM verifies it, its lifecycle
> ends there.
> I don't think this signature has much significance.
> 
> The signature field is just in shared memory and may be cleared due to some
> other exception.
> Some similar case also need to be considered.
> How to make it work better and more resilient may also be something we need
> to consider.

Not sure if I follow that. The way I expect is platform won't populate the
signature if everything is not initialised and running at it's end which
implies it is not ready to accept the request.

-- 
Regards,
Sudeep
