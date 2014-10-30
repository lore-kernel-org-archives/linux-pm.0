From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/4] PM / Domains: Improve error handling while
 adding/removing devices
Date: Thu, 30 Oct 2014 12:27:40 +0100
Message-ID: <CAPDyKFp=Xky_Cjxkj_gGTzMOQnipPkubjVroAAU1yR9mnnNTKw@mail.gmail.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
	<1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
	<7h8ujy5t69.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <7h8ujy5t69.fsf@deeprootsystems.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

On 30 October 2014 00:53, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> To improve error handling while adding/removing devices from their PM
>> domains, we need to restructure the code a bit. Let's do this by moving
>> the device specific parts into a separate function.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> This looks like just restructuring, but with these kinds of patches, its
> hard to be sure that it's just refactoring, with no functional changes,
> so it's nice to be clear in the changelog whether there are (meant to
> be) any functional changes.

According to the commit header it's not just restructuring. I will
update the commit message to reflect this better.

Br
Uffe
