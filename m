From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] Documentation/core-api/device_link: Add initial
 documentation
Date: Mon, 5 Dec 2016 06:05:07 -0700
Message-ID: <20161205060507.6bd6e944@lwn.net>
References: <cover.1480849144.git.lukas@wunner.de>
        <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
        <20161205100720.5156a4d2@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:35816 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbcLENGC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Dec 2016 08:06:02 -0500
In-Reply-To: <20161205100720.5156a4d2@vento.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Silvio Fricke <silvio.fricke@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>G

On Mon, 5 Dec 2016 10:07:39 -0200
Mauro Carvalho Chehab <mchehab@osg.samsung.com> wrote:

> > +Usage
> > +=====  
> 
> You should be using, instead:
> 
> Usage
> -----
> 
> (and the same '-' symbol for all sections of this chapter)
> 
> The way you did, in thesis, ReST should be putting all tags at the
> same level as the first one, as they're all using '='. 

Actually, he did exactly what the documentation guide says to do.  Since
it only has the markers below the heading, it will still be at a lower
level than the top heading, which has markers both above and below.

jon
