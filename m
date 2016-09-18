From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [RFC/RFT][PATCH v2 0/7] Functional dependencies between devices
Date: Sun, 18 Sep 2016 13:23:22 +0200
Message-ID: <20160918112322.GA2169@wunner.de>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan>
 <CGME20160913095858eucas1p267ec2397c9e4577f94557e4a38498164@eucas1p2.samsung.com>
 <291f428a-da27-1c69-b0fb-c78f7a4665eb@samsung.com>
 <7509218.TxKN3m4AN5@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7509218.TxKN3m4AN5@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.og>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 14, 2016 at 12:41:33AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 13, 2016 11:58:56 AM Marek Szyprowski wrote:
> > Rafael, BTW, didn't you plan to change the name of the device_link_add()
> > function to device_dependency_add() to avoid confusion with network device
> > "link"?
> 
> I was concerned about the "devlink" name in particular, but I thought that
> struct device_link would be distinct enough.  If not, I can still change it.

The "links" term has already been established, in a sense, by commit
5063ce1571b7 ("PM / Domains: Allow generic PM domains to have multiple
masters").

However the genpd links introduced by that commit use a master/slave
terminology, rather than supplier/consumer.

Best regards,

Lukas
