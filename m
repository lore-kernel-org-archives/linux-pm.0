Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632A384230;
	Wed, 15 Apr 2026 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776286559; cv=none; b=RpwpXCNqez6bhisgI+gqIW9Xk6gaudoixwEvO65lv7lJzP/EgPTtI468gneDB09ZJBLNGpTivKjYh2bJ7//qkdGQBS9+sHhQWpsPcEmrV+qa0L1aotZh6FVcr7RthQg83SwFxBXzsScTen8i1j/H471N3gUeGUYpZt/mL7A/oPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776286559; c=relaxed/simple;
	bh=pbqwwy4NxzhrF4enJfL+nV8l3Ps+/9ycKs1kbdLoA6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e1i/Hr6njhXSMhYIc77SfK008N92unELVAMXbHN29+A9c27C4YdjoExjDXTa6xJVzcZP612stqCD0FKRVlP7/XzYNfIiHfbN24l5UWWuECpMjNlyHXNclH9gUI6DpVYytyHsrR80LMI1UlTkLseORIueSn354LItAlmmVUdxefo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=kl9jocne; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="kl9jocne"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+9KYnEyxN8xMc4xcXrYwHXbZ0cOWiEHuyUA8s4aa2lE=; b=kl9jocne4s6G21CoVG4idCDYRC
	uyMLg3sfvRBm3Pn/UlfRFdWWEuvSFcjnoUY4o4X2pqnuLicYYLQF3FbVhq7h61TIpKxSTbRDTZ9aY
	tl9xh4FJBulSbOVqbRWutgNnbDN7C80NCn9FnmfQ87e/pTLp31QkWKJhBf9OkrWD4iAbLtPdIROoD
	RLZwtLY1pKbm3qLdqvJLPRw3mI9UQTs09WiQVTeqNlaysv80zVUhgaGOl9SdnbPdFwC4AT8xKHMrR
	yo/vEoWz6rNSjtzMf7oMQXVtfk6sRN7lL68qTDovS5LELinVv0Jggxo3ln0cjeW/U/dMtMJAfwZ4J
	HBoYvNlA==;
Date: Wed, 15 Apr 2026 22:13:58 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bd71828: add input current limit
 property
Message-ID: <20260415221358.59574987@kemnade.info>
In-Reply-To: <a4c43b29-a1bf-4709-8521-c21ce4ee3e46@gmail.com>
References: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
	<a4c43b29-a1bf-4709-8521-c21ce4ee3e46@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Apr 2026 09:33:25 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> I am afraid I don't know your use-case for the control of the DCIN input 
> limit well enough to decide, if the BD72720 would need something similar 
> - or if the VBUS_INLIM should be tied to the same knob. If you have the 
> enthusiasm to write some more words ... I am keen on learning! :)

Justification for this patch is mostly: there is a standard interface
for this functionality and the chip has that functionality.

The bigger picture: Attach a power source with changing properties causes
mess. To repreduce issues at my desk, I have played around with a labor power
supply with changeable current limitation, turining it down to zero (so
power is off) then turning it on slowly again, no charging will happen. My
usual way around such a problem is to clear DCIN_ILIM_EN (will add a sysfs
attribute for that) and set some conservative current.

Regards,
Andreas
