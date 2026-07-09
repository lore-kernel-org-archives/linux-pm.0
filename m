Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780013A86C
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606105; cv=none; b=ops6Xijw2a2ypEKqdXu70n5I4eOZEfmIgYzUw3gjcCsUiv3Zh/aQi3GEN7Fa9hB89ai1OQLI6yXAAKp0WeE1NyCDi1Al1XX3Awt4a1YCPU0HtxN2OGyr1x0bsZVdl8IRseEPpXUwxIncadO0vVhBZ9p4x2LXfwxI1W4Wru+9BEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606105; c=relaxed/simple;
	bh=r2KEbaIYMvEb703ZoY/upN24L5a4qT0tZxJYL70jFWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMDt0jnhO9htGRbGIi0JykQkUsp8a3bETmftRq7yY8KYLv41bW14IOCPMom451ApFg/C84jj9GFMECu3PxF9vrBCsxrpM7m+QIDpPOIcgmcfhp0th5dtbfbzSozdYB6IUvtnGeln7kXa3yjB5AgI4iMwrYgij4me54t/nYhjv8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2xSMwan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2xSMwan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB831F00A3D
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 14:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606104;
	bh=miqBAjBMjMby7RjQA22juFYqHJJmMC91rdSwlG2O7vU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V2xSMwanyqguDEJoQCeHCPBHLr0GrjgZYR58RHGV4bMRHroMEIdizpw97G9NL2L3G
	 2s6he1mUkEU7Vk/Wyn9qYu3/2mJ0Me+cGYLibBMBL+TWov1o/31KS9hZEmVVL0SNJi
	 ndXWvCav/xhqazmafDEEgHzRHLPh1gZMjOGLX5Ko1FqPL3K9zT52/7eyZ5dmSEGNC+
	 IMVCbFKH6xR0lKv5RBWsdEYMZM2t3Qqxo0FgOcOP+wk0rZjn8KYP4DPcFZqxogziWc
	 rOEqcXzhlBT/fdN509TByptmyV4xTe6dTznLpxE5zxZo/wQBTgRoK37zgN3gz88SrY
	 E1vZbaDQSH5Ow==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39b349ae174so16245541fa.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 07:08:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVUtGx+m2y3T6cKfchuB9pEI2xhcHJztD/3N13tD/XVY9DEdeU
	pYAgMj7VqhuJQ+DDzfk5ThgIFjUStv48z6kmZru15jJ08WHp0DSxGScHVXBFXEJ9m6YyuUL6qFp
	HEQlVyBhFlIDXAF8TziK5xmbRaQwQg1w=
X-Received: by 2002:ac2:5694:0:b0:5b0:11b4:fd7f with SMTP id
 2adb3069b0e04-5b011b4fec8mr1661780e87.10.1783606102924; Thu, 09 Jul 2026
 07:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708083803.80734-1-trenn@suse.de>
In-Reply-To: <20260708083803.80734-1-trenn@suse.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 9 Jul 2026 16:08:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gT8n-+3tjq6hRz65D1Eu0c8kzkO2F_rZkhHJ4893zjKQ@mail.gmail.com>
X-Gm-Features: AUfX_mw1l5TQt1jEVsMa0wj4omsn9H4lZ5T_tJUPkxk6otemLF4Rsi4-2JakkAY
Message-ID: <CAJZ5v0gT8n-+3tjq6hRz65D1Eu0c8kzkO2F_rZkhHJ4893zjKQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix sysfs duplicate filename if multiple BERT tables exist
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, msuchanek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 8, 2026 at 10:38=E2=80=AFAM Thomas Renninger <trenn@suse.de> wr=
ote:
>
> Cmp with:
> https://bugzilla.suse.com/show_bug.cgi?id=3D1270211
>
> dmesg | grep BERT
> ACPI: BERT 0x00000000DD695238 000030 (v01 AMD    AMD BERT 00000000      0=
0000000)
> ACPI: BERT 0x00000000DD6955C8 000030 (v01 AMI    AMI.BERT 00000000 AMI. 0=
0000000)
> ACPI: Reserving BERT table memory at [mem 0xdd695238-0xdd695267]
> ACPI: Reserving BERT table memory at [mem 0xdd6955c8-0xdd6955f7]
> sysfs: cannot create duplicate filename '/firmware/acpi/tables/data/BERT'

This is a bit terse, so it took me some time to understand what it is about=
.

But OK.

First off, these are ACPI patches, so please send them to linux-acpi.

> Thomas Renninger (3):
>   Use correct region size for BERT region size check

This is sort of misleading because the compiled code before and after
the patch is exactly the same AFAICS.

So I would just plain say "Use struct acpi_bert_region size for BERT
region size check" in the subject and in the changelog I would say
something like "The structure representing BERT data is struct
acpi_bert_region, so its size should be used in the BERT region size
check.  Adjust the code accordingly."

>   ACPI: Pass table_attr instead of table_header to create acpi data
>     tables
>   ACPI: Properly map BERT and CCEL acpi tables to their data tables

And I would merge the other two patches because splitting them is kind
of artificial.
