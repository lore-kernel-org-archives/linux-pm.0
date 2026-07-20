Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54CD42EECE;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784583828; cv=none; b=iVfZNW4Fgcz3lDaQChXCc1Dnqqu+/ZTeCN2Qj9JcQTwG2CrL4cWfBrN3p/j51mBKlQq3TV2X5JEfyyc4/DasMpRPNIbS+O8hbCLEtgv+sJSkd1IFcaHbGQ8LGgpxQNS4mYe0qf/xd9xdqqQ5IL1ubBHhrBWF2NTIBmxrRFILKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784583828; c=relaxed/simple;
	bh=e0zYnZmXkTOMWY2gscabgbK6CS2bHi1y54DFSnlDU2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ShQOLBZyO+1yS/02PoyuyyfPdyeLmjRQMjAVNlwm94hh+aUX3UWT/VyBYXlXrswsqP2FjSkwBRs0FeXnSrbTdRm7KhLWR6JV/W/Oh+cTTFbBzTu11WaZ+guRDIeHfyE/y2xHk51ocoy2gosYuxXKFH+c1glfsz1OrkAOWE79o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F28A1F00A3A;
	Mon, 20 Jul 2026 21:43:47 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id DCA44180D23; Mon, 20 Jul 2026 23:43:45 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, Bryam Vargas <hexlabsecurity@proton.me>
Cc: chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org, 
 Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20260616-b4-disp-5e197080-v2-1-8aa5bffce945@proton.me>
References: <20260616-b4-disp-5e197080-v2-1-8aa5bffce945@proton.me>
Subject: Re: [PATCH v2] power: supply: cros_usbpd-charger: bound the
 EC-reported port count
Message-Id: <178458382589.311390.16573073501669977911.b4-ty@collabora.com>
Date: Mon, 20 Jul 2026 23:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 16 Jun 2026 23:59:45 -0500, Bryam Vargas wrote:
> cros_usbpd_charger_probe() reads two port counts from the EC and uses
> one of them, num_charger_ports, as the loop bound when populating a
> fixed-size array:
> 
> 	struct port_data *ports[EC_USB_PD_MAX_PORTS];	/* 8 entries */
> 	...
> 	for (i = 0; i < charger->num_charger_ports; i++)
> 		charger->ports[charger->num_registered_psy++] = port;
> 
> [...]

Applied, thanks!

[1/1] power: supply: cros_usbpd-charger: bound the EC-reported port count
      commit: 90610021a9e92ab2b81979e3d474ca64bc31bf90

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

