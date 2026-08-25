Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC6B37204C;
	Tue, 25 Aug 2026 05:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637446; cv=none; b=VQLzo8T4tD/nU5VhWCl97ecKz0C/LxU+xwWycdVTze2f5GMCtZAJIk4bqN7Ek2mL1Js1FlOiOSpMxNGSELxsYC1lOdIWhVFTXdAYbRYmcrs3kM0f7gK7Ga2z7iFn77xPdDjJo/hr97LSg+nzKs0cJ9/kpy+f+y+fe1Nhv5pvSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637446; c=relaxed/simple;
	bh=HHyoZmKAyq1ZXFc/LOCAsbbUZ458WyvzttvbfYRR5pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtxUMtQOZFphfgvjmMSQrM//KxtPkyngQhBRn2SF97MOk+r8OYxwzxlevgw7h1ZboRU0AfAhqjoGZWVoc7Lv/fnBqV2YVowmGP1cjMm2M8XjqH3h61YQAbkM09PdAple2H/gGTarig2UIxU4ACgm2edfrJPlKGYh6RODd8NeFmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNv1uCN4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNv1uCN4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89DF1F000E9;
	Tue, 25 Aug 2026 05:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787637444;
	bh=lS6vp4F9ZRJmYMfQdWK1IeuTaTjxFSNso4dKRTnCrLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XNv1uCN44RUNmgEGdAA6rOnrmLdM3D4P9+/W5CxeYTPtuty9X6iWyTItXY9wL7Bh8
	 6TpiCY89Czm9vWkdUnDXblMQkQlq7c3JiKTErLokhUiSf7PDnn+ym49jaN5vo466DP
	 nkFXvWNo9HEoHKZ/TRfuPWy7MIQs0lFrUiy4riRI=
Date: Tue, 25 Aug 2026 07:55:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1 0/2] thermal: core: Revert two cosmetic update that go
 against driver core changes
Message-ID: <2026082534-armband-stout-3d19@gregkh>
References: <12960456.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12960456.O9o76ZdvQC@rafael.j.wysocki>

On Mon, Aug 24, 2026 at 07:50:52PM +0200, Rafael J. Wysocki wrote:
> Hi All,
> 
> Two recent thermal core commits restored the usage of class_create()
> into the thermal core as a cleanup matter, but that goes against the
> driver core plans to get rid of that function.
> 
> Revert these two commits and let class_create() be eliminated.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
