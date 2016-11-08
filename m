From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Tue, 8 Nov 2016 07:45:41 +0100
Message-ID: <20161108064541.GA13024@kroah.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <13957403.ZrB4mMbICz@vostro.rjw.lan>
 <2715729.9U1nlcpFb3@vostro.rjw.lan>
 <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
 <20161107212250.GH1764@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107212250.GH1764@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 07, 2016 at 10:22:50PM +0100, Luis R. Rodriguez wrote:
> We have no explicit semantics to check if a driver / subsystem
> supports deferred probe.

Why would we need such a thing?

thanks,

greg k-h
