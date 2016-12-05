From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/2] Device links documentation
Date: Mon, 5 Dec 2016 06:09:10 -0700
Message-ID: <20161205060910.36a4c6c6@lwn.net>
References: <cover.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1480849144.git.lukas@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Tomasz Figa <tomasz.figa@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[Trimming the CC list a bit; claws-mail chokes on the full thing for some
reason]

On Sun, 4 Dec 2016 13:10:04 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> @Jonathan Corbet:  Is core-api the right place to put this? An
> alternative would be Documentation/driver-api, but unlike core-api
> it contains less prose text but mostly just bare API docs gleaned
> from kernel-doc.

The amount of prose isn't really the determining factor here...  To me,
this is very much driver-oriented documentation, so I would rather see it
going into the driver-api sub-book.

Thanks for putting it together,

jon
