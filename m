From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 4/9] drivercore / platform: Keep PM domain powered
 during ->probe()
Date: Fri, 31 Oct 2014 10:23:00 +0100
Message-ID: <CAPDyKFpjYkBcW4XMO0CmgOiLux9=iw2=DEHkBG9OVZh5T5CgQg@mail.gmail.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<1413208930-26019-5-git-send-email-ulf.hansson@linaro.org>
	<7hoast8eu8.fsf@deeprootsystems.com>
	<20141031000749.GK36444@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141031000749.GK36444@dtor-ws>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron
List-Id: linux-pm@vger.kernel.org

On 31 October 2014 01:07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Oct 30, 2014 at 01:47:27PM -0700, Kevin Hilman wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>
>> > To sucessfully probe some devices their corresponding PM domains may
>> > need to be powered.
>>
>> Isn't that what pm_runtime_get*() is supposed to be doing?  Why isn't
>> that working?
>
> Also, I do not understand why we placing device into a power domain only
> when we probe it. Why if I unbind device from its driver (or do not have
> a driver for it) it disappears from its power domain? To me power domain
> and having driver bound to a device are 2 orthogonal concepts.

That's a different discussion, I don't think we want to go there
within this context.

Kind regards
Uffe
