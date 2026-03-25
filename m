Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4E3DB65B
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444398; cv=none; b=MxQmCtiaYwVmdNo3XO/s0yf3NNcY4t7OMPU0xug3PBPIRllsFX5aQklGlVnM/iKgRTczMnPJfQdx3NJDkhY1YBBgWvUxNNvqw3mYlWRijiNgZOVf9+RMNwajGjEoe/51CBsGDzY9A5sdKdXm+jSx08W0zJKZcm4yaBSqRNFsZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444398; c=relaxed/simple;
	bh=p1CgH2aPFFSSIU0nL8Z5QCpMo08bn0aEmyIzHWVtXmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FK5oP0USfRw+UQ+++Bh/SASMBsDS5XUpY7Sj0c89/7scF7kX+ZqhpXcOdUYSej/sI15mKJ5Fa+/+sgiA7lh6OLdhVfepofI57MsXLfL08q9DAQAiE4o09gJQCAgZoDB3/U4gyeBSKqWFjTdGYfdHNWRgyYL04xWjHr/Qd2lxA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S073oI7S; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S073oI7S"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0586d5bb8so47259475ad.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774444397; x=1775049197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXlIM/W5QtMeF1TTKLDLvCNleh8kdupGPpwsdQWbjac=;
        b=S073oI7ScH7/nc3zKWmse8udWnKtrGdCsWrr8dgh9LYJJ74D8lufB3vCnmkc6tPk2M
         AOdcwVsIIzbiJPz22C+YHPEw9+Gu09/daKM3dTg8j+QNFxh4DmCFEkP/noHxC7JZTMP5
         nV0O8aivE8zffMIW6avzwckbPgJjBEglWLiy5sxcgbKU7oz09Aa7DHp7tBFzFDMfG246
         1y0i4VaUmypb5AZj0pk0tixkRr/b4xy3JYgFafdlKJ3fDcrfUJG9eBIryKoNYVbxidD7
         fMHa+5PoWvAG1sF3Fml9TbDlcQSD3kn+rHYbV2Ib5Y3AnT+jdjvpb1xHy2CUaqhTfPr3
         nTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444397; x=1775049197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXlIM/W5QtMeF1TTKLDLvCNleh8kdupGPpwsdQWbjac=;
        b=MOuNEAKtXpi46ttLrTz1DSO+w9EPYbWZMgZ3o5bRXpKPoGgsn9TZR5JMn26XA7R7Wr
         eKmZW+X7sZCQrJR7KzTUbQI7gZ+O0JYMGhfcaCMibELkuB2/ISfzLMpGHyarFzQsrvoA
         3rqm33B73Viea16KTiCaS+UsmE8YIk4HeziOyH1aow82WM6Hp5s6XlcoxUhpo06Z1VVX
         GarE0RL+OMNEWV74ayV/eOf1/QKInCUBWfYoIGSfRvHXt5tsC8JGOx+P/oqT/CUP3Xrs
         DQNBxTDRdvZsn+6kmS1Q2+AyPJeFGjI2gGfgKmDr9BHCgfqXhuj529FOfBczI/v6upgy
         QVcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKVQ+G85FRScbes7Owd/GXSC53YP4YurNCuTU+bCKxGVFjXz4FGFIvNmJdacsMDr5p2NrFz/vzLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP5/9zp9E4Xr68CTMYg9lktdf6D82pE+ZVlsN0nlAWG7Uz7TnP
	JB4iVm/Cdxz0Y8UGh1SwsO85STw+MS+6/qu35XHuKuTM2HLeslpTIG+h
X-Gm-Gg: ATEYQzxFeWBsc2VcPmi8HYUk1rkTtYd10O6/UQdS5E4TDUhVZH9gQFMLSJNxAze5u9g
	Um1Q5t783RDU5Ey+QhzNUpIcHhvs9iOwgdCHBGohjmGPGeJibdgwF3+FVPYquFF6eQ3LuDtPvjl
	i9BsEvIvvmSfgq4w4FQ6GFBXNKoSOQxnG8G6rsXVa0YVdhcmL4H4ZOQVw1WNvJ+WinHHrYllfae
	6PO9Wtqp3hizzel/lVzmmkCBeykIkFpxndzAagYe49QCAg2T+wKXomCvL1BRKEaCdozf0ArzsVk
	GtCVVOcQtel/hdjMlM8OJglv3aGEbW/wNzcIrnhpQfwrPHFJAZNv5o9xir0fP+mhNiKzmMLgf7e
	6iEo4FYjfia2Zx+wn3EIQGyaNhj/8l3GimH1rDG1qH6Q+RWjbSgRs1yaLF/ms5LjIXJEKLfsOIR
	dY5wS2YKLxxITHotpahk16fPtqbAMQEcznjybVGKd4VCtFRrsTwU0OI44ytKk=
X-Received: by 2002:a17:902:f550:b0:2ab:230d:2d96 with SMTP id d9443c01a7336-2b0b0a0f86cmr37207665ad.11.1774444396928;
        Wed, 25 Mar 2026 06:13:16 -0700 (PDT)
Received: from localhost ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836ace98sm182577905ad.80.2026.03.25.06.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 06:13:16 -0700 (PDT)
Date: Wed, 25 Mar 2026 18:43:11 +0530
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sre@kernel.org, robh@kernel.org, krzk+dt@kernel.org, lee@kernel.org, 
	conor+dt@kernel.org, daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: st: convert to dtschema
Message-ID: <acPebHSUdu16bzw-@toolbx>
References: <20260324155935.183952-1-krishnagopi487@gmail.com>
 <20260325-speedy-amethyst-beaver-08a3a4@quoll>
 <acPMx9NZBehAzkBp@toolbx>
 <57e3e846-d679-4201-921c-69cdd4040d13@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e3e846-d679-4201-921c-69cdd4040d13@kernel.org>

On Wed, Mar 25, 2026 at 01:36:15PM +0100, Krzysztof Kozlowski wrote:

> On 25/03/2026 13:04, Gopi Krishna Menon wrote:
> > On Wed, Mar 25, 2026 at 12:39:36PM +0100, Krzysztof Kozlowski wrote:
> > 
> >> On Tue, Mar 24, 2026 at 09:29:30PM +0530, Gopi Krishna Menon wrote:
> >>> Convert the STiH4xx reset controller bindings to DT schema.
> >>>
> >>> Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
> >>> Suggested-by: Dhruva Gole <d-gole@ti.com>
> >>
> >> Both suggested you to write this patch?
> >>
> > Hi Krzysztof,
> > 
> > Thanks for the review, They helped me to improve the PATCH,
> > 
> > - Dhruva suggested me to change the subject from dt-bindings: power:
> >   reset: st: convert to dtschema to dt-bindings: reset: st: convert to
> >   dtschema as that was the general trend followed with similar files.
> > - Daniel suggested me to use the word 'reset' instead of 'restart' in
> >   the patch (whereever possible) as that is more accurate here.
> > 
> > That's why I added those Suggested-by tags.
> 
> This is not the meaning of Suggested-by. Drop the tags.
> 
Understood. Will remove it and send the v2.
> I gave you now review, so you will add "Suggested-by: Krzysztof ..."?
> 
Earlier I would have. Didnt understand the use and meaning of this tag properly.
But will take care not to let this happen in future.
> Best regards,
> Krzysztof
