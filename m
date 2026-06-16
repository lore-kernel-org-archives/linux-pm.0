Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE003EEAC0;
	Tue, 16 Jun 2026 09:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602945; cv=none; b=J5jefLcFkcUtRn4GZyU+ua89K05SW6aiQJQDYt4mCpmcyVbnJ7k7+nWihhFWVQJBbsFwLQyiS+czxz1aegC5lFL4iZb5ahh2AoLu19uRPniWLGX1OUXSH8gfhiLeSrVU0tGrPgYcistPiZbXt0TsNpxLDqRuIr70Gjp9OTMGr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602945; c=relaxed/simple;
	bh=pAMCVaYjf+h6/ijxuN8w5wEj6ksTCi+qS5Xt9mo7CxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZvkLmrWfZ42I28F4KEof+smqMgRSvjjZ6d/AlFtTMRmTRNvee7SdbE20uG+Wfjo2UaeQZ1C8+0uf4f3LYC+LNeAkf22apG73GsQ3EGX65Y5u/m4Pb9R9uK6lXZwLLOxqXL6dv1mC6uCdszJBgAdf5AgwWW0MilA1oW9Ua2PAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hu2jNgoT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hu2jNgoT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5531F000E9;
	Tue, 16 Jun 2026 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781602944;
	bh=J9fFKVacnJ6zTMMVUBUlx2JF601P5wSA/Cn6i+psLjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hu2jNgoTqjoNmSwTJfx0C+Okoq9QjDeW92jiDnMNUX80r0Kx/bQatAiJRwCQn6v9l
	 wy8Ruo7sVB7xDiU3s18jhRX6OgnpIijVrP5fp4OMIWqvW/1nQ9eMlx/vCuwZlRgGaJ
	 oQKfWf1h3HgLkYtBOrBBbguhvC10UAtKaz6YJ6pXX5+wVXYeu5klGp6Amy4AxM5qvr
	 ddyB2EEBX/uzTJIjcL17JOBVwzGDBBLZn+I7Z0VGICAR4J5pjsxeB8FeULwZCFpO7d
	 XffWAp0sUW08+ML609IwIyXyzM3E9BAhPfkkk4wcIRb9IAh8NADARnlKoBFaV48Qt5
	 wzKK9kX8B6CYQ==
Date: Tue, 16 Jun 2026 09:42:21 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: hexlabsecurity@proton.me
Cc: Benson Leung <bleung@chromium.org>, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH] power: supply: cros_usbpd-charger: bound the EC-reported
 port count
Message-ID: <ajEafasi2g-K0ysc@google.com>
References: <20260615-b4-disp-e0930b21-v1-1-c9ffbac7c9bb@proton.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-disp-e0930b21-v1-1-c9ffbac7c9bb@proton.me>

On Mon, Jun 15, 2026 at 04:04:07AM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> cros_usbpd_charger_probe() reads two port counts from the EC and uses
> one of them, num_charger_ports, as the loop bound when populating a
> fixed-size array:
> 
> 	struct port_data *ports[EC_USB_PD_MAX_PORTS];	/* 8 entries */
> 	...
> 	for (i = 0; i < charger->num_charger_ports; i++)
> 		charger->ports[charger->num_registered_psy++] = port;
> 
> Both num_usbpd_ports (from EC_CMD_USB_PD_PORTS) and num_charger_ports
> (from EC_CMD_CHARGE_PORT_COUNT) are u8 values reported by the EC. The
> only validation is a sanity check that compares the two EC-reported
> values against each other:
> 
> 	if (num_charger_ports < num_usbpd_ports ||
> 	    num_charger_ports > num_usbpd_ports + 1)
> 		return -EPROTO;
> 
> It never checks either count against EC_USB_PD_MAX_PORTS, the size of
> the ports[] array. A malfunctioning, malicious or compromised EC that
> reports num_usbpd_ports == num_charger_ports == N for any N > 8 (for
> example both 255) passes this check, and the loop then writes N pointers
> into the 8-entry ports[] array embedded in the devm_kzalloc()'d
> charger_data, overflowing it by up to 255 - 8 = 247 entries (~1976
> bytes): a slab out-of-bounds write.
> 
> Reject a port count larger than the ports[] array can hold.
> 
> Fixes: f68b883e8fad ("power: supply: add cros-ec USBPD charger driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

With or without the minor comment:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
> index 7d3e676a951c..d639957f9775 100644
> --- a/drivers/power/supply/cros_usbpd-charger.c
> +++ b/drivers/power/supply/cros_usbpd-charger.c
> @@ -589,10 +589,12 @@ static int cros_usbpd_charger_probe(struct platform_device *pd)
>  
>  	/*
>  	 * Sanity checks on the number of ports:
> -	 *  there should be at most 1 dedicated port
> +	 *  there should be at most 1 dedicated port, and the count is
> +	 *  reported by the EC, so it must not exceed the ports[] array.
>  	 */

Nit: The mention of EC is redundant.  I'd suggest:

"...must not exceed the maximum number of supported ports
 (EC_USB_PD_MAX_PORTS)"
