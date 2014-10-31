From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ safe
 option
Date: Fri, 31 Oct 2014 10:33:26 +0100
Message-ID: <1414748006.7705.2.camel@AMDC1943>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
 <1413795888-18559-2-git-send-email-k.kozlowski@samsung.com>
 <1414746895.6797.3.camel@AMDC1943>
 <CAPDyKFpz2Finv0BUmp1pQtihUzUULCfj7hmOJW3CJ_cWErLySQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAPDyKFpz2Finv0BUmp1pQtihUzUULCfj7hmOJW3CJ_cWErLySQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-10-31 at 10:29 +0100, Ulf Hansson wrote:
> On 31 October 2014 10:14, Krzysztof Kozlowski <k.kozlowski@samsung.co=
m> wrote:
> > On pon, 2014-10-20 at 11:04 +0200, Krzysztof Kozlowski wrote:
> >> Add a simple getter pm_runtime_is_irq_safe() for querying whether =
runtime
> >> PM IRQ safe was set or not.
> >>
> >> Various bus drivers implementing runtime PM may use choose to susp=
end
> >> differently based on IRQ safeness status of child driver (e.g. do =
not
> >> unprepare the clock if IRQ safe is not set).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Rafael, Len, Pavel,
> >
> > Is proposed API ok? Do you have any comments?
> >
> > I'll upload whole patchset to Russell's patch tracking system. Howe=
ver
> > an ack from PM maintainer is probably needed.
>=20
> I would actually prefer the opposite. It's better if we can take thes=
e
> patches through Rafaels tree.
>=20
> 1) I have posted patches for the amba bus, these may have merge
> conflicts with your changes.
> 2) We may start using the new runtime PM API within genpd as of now.

I don't mind and it makes sense to me.
This way I need an ack from Russell or Vinod...


Best regards,
Krzysztof
