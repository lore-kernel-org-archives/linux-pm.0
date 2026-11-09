Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245998;
	b=fbUeAmZAiEyIVceHPEgEI9vsfpsSlQuZX9iBpYTwp8qZ/N7V54gIXe+uq4/XPd9W7NMY
	 11CE6rgRF19VInbKeWwX5CEWcOFIVOJFakvLGdUSFrJidIClzvGpBfNOWuWQu6+GPtorq
	 JjfHYb2ged9bCuWZUUlHtnM1BgpIF87IhdQZCuVS6g02MvveURqimhBCoGAOVIUHTIqd7
	 wUrMoMCuQpNchfGC1XmoCe/tfkLJ+b25IbnYm0X8NSgj6ZtDa5COapWW2KlbndHM1IvPK
	 7N3ceTiaQXS1j67T/Zo+Iio6PlxTpIRaxLCn5bpL6HxG5KCziOqiWIL3l98447FS36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245998;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=o5Udb0XWqFBLDvZNe6CnQotNEj65tbZoPfPX1A5XjZQ=;
	b=X77SC5PWyxVncsktC8zokMfiC5Kn/3GK+5LhyWQ37aJ6AH87DRjkgLURgAZQ7iu6hTRw
	 Z0I7TaC684ShSUSu/huQ/wV9eV4xKS+7Hr0SVs3dbDrZqarL4aPoNiQFHBfRdi9C5zeFp
	 mMIlAcy12aX4VFyv2vIKTubbK5CaMZ7HRbpg+kADtNnoiH9GHxrbcuHjbaq2jwai3KdCF
	 rWnJGm+Ord7+fjifuGnqEL52uLxz5ojvYWIDOzOA3EAoRvsvYiHvPCaVv23sJU6Nd8qBO
	 p3gD2cHGwM228XqKgO4lGaWqyf9BYw/0uj+KefxxYJ5uTEZkl6atKnvjkzGoveufcIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcZce49I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6031606A32A;
	Mon,  9 Nov 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mcZce49I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960C91F008A2;
	Mon,  9 Nov 2026 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245997;
	bh=o5Udb0XWqFBLDvZNe6CnQotNEj65tbZoPfPX1A5XjZQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mcZce49IknFj31vX4Xra8sKoPHS+KWe0CPypUVmYctDDPIfVyg6WGQcd567XIWafz
	 pMQ9dKpJaRrXQD963nd+n9G4wzQvQ5zo6pjrlqeo2Hxgv3xz4lDTl1KiY0bOBqyxO0
	 LYfUjeFGfIQDHcHQ+IIlVIQTp853nXxRlMN21vRlTUCV30+txQ8Vq5UPXsRU8KQ+5s
	 DTDYNnOuCb0olwpTj7dJlsJVwhMkWxSR+sNphtL7PH+Tvl/C7nIXCo9C8Mx6zU1UiY
	 C0DFl2Jw5PkhzuZZ0S2kI75jZqTfg7RLumyIOs/BsmlaKnhmW1bmsxl6tWoc0b7Ife
	 wGMkuTnUaP1gQ==
Message-ID: <34c23beb-88d5-4456-b84f-f00e31578468@kernel.org>
Date: Mon, 9 Nov 2026 11:39:54 -0600
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Make platform profiles firmware independent
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>,
 Jai Luthra <jai.luthra@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jack Wu <jackbb_wu@compal.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com>
 <ed4aac63-ac58-4e2a-ae45-ebf4da158228@oss.qualcomm.com>
 <CAJZ5v0gGeKEqMWvP3cQrXztZt-faFZJF+yNfygcBPT57f-a8Lw@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gGeKEqMWvP3cQrXztZt-faFZJF+yNfygcBPT57f-a8Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/9/26 10:46, Rafael J. Wysocki (Intel) wrote:
> On Mon, Nov 9, 2026 at 5:37 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>>
>> Hi,
>>
>> sashiko validated this series
>>
>> Is there any other comments for these changes I should take care of ?
> 
> I'd love to see some feedback from someone having a vested interest in
> this interface.  Mario?  Mark?
> 
I am onboard with the new approach.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
