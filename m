From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 2/9] PM / Domains: Add generic OF-based PM domain
 look-up
Date: Mon, 08 Sep 2014 22:53:09 +0200
Message-ID: <540E1735.9010603@gmail.com>
References: <1409838756-31963-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFovLmajQORVT1Mf01J5L7O73JNDFz=gr3fXKvF5xZGCdQ@mail.gmail.com>
 <5191943.peyCs6gZVs@vostro.rjw.lan> <3105400.7vSnq2rA6s@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3105400.7vSnq2rA6s@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Philipp Zabel <philipp.zabel@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
List-Id: linux-pm@vger.kernel.org

On 08.09.2014 23:08, Rafael J. Wysocki wrote:
> On Monday, September 08, 2014 11:04:23 PM Rafael J. Wysocki wrote:
>> On Monday, September 08, 2014 09:26:20 AM Ulf Hansson wrote:
>>> On 8 September 2014 00:13, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>>> On Thursday, September 04, 2014 03:52:29 PM Ulf Hansson wrote:
>>>>> From: Tomasz Figa <t.figa@samsung.com>
>>>>>
>>>>> This patch introduces generic code to perform PM domain look-up using
>>>>> device tree and automatically bind devices to their PM domains.
>>>>>
>>>>> Generic device tree bindings are introduced to specify PM domains of
>>>>> devices in their device tree nodes.
>>>>>
>>>>> Backwards compatibility with legacy Samsung-specific PM domain bindings
>>>>> is provided, but for now the new code is not compiled when
>>>>> CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code.
>>>>> This will change as soon as the Exynos PM domain code gets converted to
>>>>> use the generic framework in further patch.
>>>>>
>>>>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>> [Ulf:Added attach|detach functions, fixed review comments]
>>>>> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>>>>
>>>> However, for this one (and consequently the rest) I need an ACK from the
>>>> people who maintain the bindings.
>>>
>>> These DT bindings have been discussed between Tomasz and devicetree
>>> maintainers previously. So I think there are fine.
>>>
>>> Also, when browsing the mail-archives, I found an ack from Rob Herrring:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/237989.html
>>>
>>> I realize that I didn't put the DT maintainers on the to-line when
>>> posting this patch, but just the devicetree list. I have now included
>>> them on this reply, but maybe I should repost instead. What do you
>>> think? Are you happy with the above ack from Rob?
>>
>> That should be sufficient, but I wonder why you didn't add it to the patch
>> to start with?
> 
> BTW, I get bounces from t.figa@samsung.com, so I won't apply the patch with
> that as the "From" field.  And the s-o-b from a bouncing address is worthless
> too.

Yes, that e-mail address is no longer valid, as I'm not at Samsung
anymore. I'm not sure what's the right thing to do with From and SOB in
this series, though.

If it's of any help, my private address (and the one I use for things I
maintain and any open source activity on my own) is this one.

Best regards,
Tomasz
