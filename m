From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/RFT][PATCH v2 2/7] driver core: Functional dependencies
 tracking support
Date: Fri, 9 Sep 2016 16:13:32 +0200
Message-ID: <CAPDyKFqnEeyj6AtyFSTu6g0os2q2i=-1mdGofa_PaUiT=p-jFA@mail.gmail.com>
References: <27296716.H9VWo8ShOm@vostro.rjw.lan> <2169291.li0uc2Ryoq@vostro.rjw.lan>
 <CAPDyKFpTeB8MLXihpTnyk9RerVC_PNp8ogXG6aATLT2xLkp9mA@mail.gmail.com> <20160909120621.GP27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160909120621.GP27946@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Lukas Wunner <lukas@wunner.de>, Kevin Hilman <khilman@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>
List-Id: linux-pm@vger.kernel.org

On 9 September 2016 at 14:06, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Sep 09, 2016 at 10:25:30AM +0200, Ulf Hansson wrote:
>
>> BTW, as I am mostly working on DT based platforms, I guess we would
>> later on need to discuss with the DT maintainers how to describe
>> device links.
>
> I think the expectation had been that since DT tends to get right down
> to the hardware details we already have the information in there in
> order to use things so the problem becomes figuring out how/when we
> parse the existing bindings to tell the driver core about links.

I guess what we need from a functional point of view, is to be able to
first initialize all devices (device_initialize()) then add the
relevant device links before we add the devices (device_add()). That
seems like a piece of cake to fix. :-)

Kind regards
Uffe
