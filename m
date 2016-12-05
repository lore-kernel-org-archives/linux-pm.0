From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: [PATCH 0/2] Device links documentation
Date: Mon, 5 Dec 2016 10:03:37 -0200
Message-ID: <20161205100243.65b54d63@vento.lan>
References: <cover.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1480849144.git.lukas@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Silvio Fricke <silvio.fricke@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Lukas,

Em Sun, 4 Dec 2016 13:10:04 +0100
Lukas Wunner <lukas@wunner.de> escreveu:

> Here's my suggestion for initial documentation on the device links
> feature that's queued for 4.10 on Greg KH's driver-core-next branch.
> Please let me know if you have any additions or corrections.
> 
> To read this in rendered form:
> http://wunner.de/kernel-doc/core-api/device_link.html
> 
> Patch [2/2] could go in via driver-core-next, but patch [1/2] would
> need to go in via docs-next (because the core-api directory doesn't
> exist yet in driver-core-next).
>
> @Jonathan Corbet:  Is core-api the right place to put this? An
> alternative would be Documentation/driver-api, but unlike core-api
> it contains less prose text but mostly just bare API docs gleaned
> from kernel-doc.

Just my 2 cents here, but, IMHO, this belongs to driver-api.
Yeah, it contains less prose, with is, IMHO, something that should
be improved ;)

Regards,
Mauro
