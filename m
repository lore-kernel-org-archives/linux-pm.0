Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.212
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795857924;
	b=ucrdTlE5yE1HGBoOzNLq3P3b3AxJiJ7WMbyr24qxFZd6wCdXcEC4LnMnr6DLJQNqU0WX
	 kXkxxpG5ZHLl88biDo3UdjkkzHdGQAUV3v5otLyfszEGAdDJ5SurC+EdA2rIbSUykXaVs
	 Ju8hA8bPVdmeBn4mXlPlah/kVYQ9cKIkFqCS6TroNBKImBkNh/bmOiyXBHqEILhEG2c1Q
	 vmlqICdYIBbW9DVPbARcfh3TvKh1mb9vzYF19K562Qfe2R14yUOLDKq9UGCPn+TT4s+n6
	 pVdWN25IZgxP450Z4szZmeMmzg+Beyrhsgse7ZJv8mtRi8B9k+CxiMkIkaL+B5srHHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795857924;
	h=DMARC-Filter:Date:X-Lima-ML-UUID:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dWy5vppk5Bd5EKXu+uZhGipgVqabP9s6/+f0QID0eVs=;
	b=B/gGcF7i5iDRxKddHXBmDVR7DkWRn9jptqDwfV0qcL1i4aK4wFQr4Omx+ujqkqux3LQf
	 sYTjHZNleaXzBBdg7Hse096eZxAs18NzHyMBU664ejuKRTp47ZBCUBKqMC6rZ77tLh1WH
	 rNYFWKEkpMAh9oVAlDeprbStdSG+9ZvzfUeigU13V3aMrqOCAEyp/B5SlQRxkQzPNaZyn
	 i5CnvTGf+/xNzaOl+iuu/D7npY1d822oLsb2S/l8U/aX0q2UgS0LkrSh6Hn9BmH/kYuV0
	 yhZ0/cf0EfxRxU8m3eYRhxogWthIkjI7McYNMjbMN19ZFRTEeGy0TIEehH0Y3rl7+YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=bDpsaei+;
	arc=none smtp.remote-ip=91.216.248.212
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8FE606A31C;
	Sat, 28 Nov 2026 09:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=bDpsaei+
Date: Sat, 28 Nov 2026 10:25:14 +0100
X-Lima-ML-UUID: 1454ecc1-9183-4fb8-a07c-019e95145569
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1795857919;
	bh=Og3u6C4I0eE4pTOJQJ6ILXthej354cxUmnYcEgJpV5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDpsaei+xs+AQRBejgA6MnnP3A+7i6QsfywCpCf/beA7C3nS5TR38Gh5IkXGDALvB
	 Q0+F0N4GAsiScsz4R9C2g/PFreeXUREAZtWQVz6FhsG83DBYwY7qLl3/vCBAGF71OH
	 hLzMz4oYCy2vi1gRTbFVb8vEQCEyK4M6ZTIU33F0MK1eK08VYlHT6PH3DzM3QjbWoI
	 jOKMlgaxyC0eLnNMH1v02t/C4tc2Yo9VXJzu/jt41HmPKPd1vlRPXrsd1w3a+3LlJv
	 BbRysuAc+8wHClfNBsfF8ewCQdASq8UtvbXZjS5NpMdij7GKON4zHwS7yYUzem/oLS
	 2bgyaY/DOrptA==
From: =?UTF-8?B?QW5kcsOp?= Eikmeyer <dev@deq.rocks>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 rafael@kernel.org, linux-pm@vger.kernel.org, lukas@wunner.de,
 yu.c.chen@intel.com
Subject: Re: [PATCH] x86/cache: Restore AP cache state while bringing CPUs
 online on resume
Message-ID: <20261128102514.30252d9b@kait2en-mbp15-1>
In-Reply-To: <20261128011842.GBawor8g-JODmLyVCY@fat_crate.local>
References: <20261111123747.49446-1-dev@deq.rocks>
	<20261127150014.285304-1-dev@deq.rocks>
	<20261128011842.GBawor8g-JODmLyVCY@fat_crate.local>
Organization: KaiT2en
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 17:18:42 -0800
Borislav Petkov <bp@alien8.de> wrote:

> Yes, why is your change correct for all x86 out there?
> 
> Yu Chen in his original patch at least tried to do some git
> archeology, you're simply axing them off because works-for-me.
> 
> Sorry.

Hi Boris,

No worries, I get you. I should have provided more background info. I am
not trying to axe them off. I could simply use your help.

The patch refers to this discussion with Lukas and Chen Yu on a patch I
sent for early CPU offlining on T2 Macs

https://lore.kernel.org/all/aoCJGj8HixmJ9oaZ@wunner.de/

This is what I found in the history

- d0af9eed5aa9 made each AP init a stop_machine() rendezvous as the SDM
  requires. Boot and resume delay the AP init until all APs are up. So
  one rendezvous covers all of them.

- The delay assumes that the APs come back from S3 with usable MTRRs.
  Some firmware leaves them uncached and each AP then runs uncached
  until thaw_secondary_cpus() ends. Lukas saw this on his older
  Macbook Pro 9,1, I see it on the T2 Macs.

- Chen Yu's v4 from 2018 did one rendezvous per AP on resume and
  reprogrammed only the incoming CPU. It slipped through the cracks.

- Since 0b9a6a8bedb, a rendezvous outside the delayed phase
  reprograms only the incoming CPU. Without the thaw hooks resume
  takes the same path as CPU hotplug.

You will agree that a resume from S3 taking longer than rebooting is
annoying. Especially on a portable device. It's getting worse the more
cores a CPU has. Like exponentially worse. We see 30 seconds on a 10th
gen I5 and around 3 minutes on a Coffee Lake I9.

However, the only drawback I see is one rendezvous per AP instead of one
for all. I can only test what the T2 community and I have. If this has a
downside on systems that are not affected, please point me to it. As
is, the patch is small and fixes our stuff, from what I thought was a
good thing to begin with. And we could go from here.

Best,
Andre
