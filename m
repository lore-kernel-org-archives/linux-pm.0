From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v8 1/5] PM / Runtime: Add getter for querying the IRQ
 safe option
Date: Fri, 31 Oct 2014 09:33:18 +0000
Message-ID: <20141031093318.GS27405@n2100.arm.linux.org.uk>
References: <1413795888-18559-1-git-send-email-k.kozlowski@samsung.com>
 <1413795888-18559-2-git-send-email-k.kozlowski@samsung.com>
 <1414746895.6797.3.camel@AMDC1943>
 <CAPDyKFpz2Finv0BUmp1pQtihUzUULCfj7hmOJW3CJ_cWErLySQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpz2Finv0BUmp1pQtihUzUULCfj7hmOJW3CJ_cWErLySQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 31, 2014 at 10:29:36AM +0100, Ulf Hansson wrote:
> On 31 October 2014 10:14, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> > On pon, 2014-10-20 at 11:04 +0200, Krzysztof Kozlowski wrote:
> >> Add a simple getter pm_runtime_is_irq_safe() for querying whether runtime
> >> PM IRQ safe was set or not.
> >>
> >> Various bus drivers implementing runtime PM may use choose to suspend
> >> differently based on IRQ safeness status of child driver (e.g. do not
> >> unprepare the clock if IRQ safe is not set).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Rafael, Len, Pavel,
> >
> > Is proposed API ok? Do you have any comments?
> >
> > I'll upload whole patchset to Russell's patch tracking system. However
> > an ack from PM maintainer is probably needed.
> 
> I would actually prefer the opposite. It's better if we can take these
> patches through Rafaels tree.
> 
> 1) I have posted patches for the amba bus, these may have merge
> conflicts with your changes.
> 2) We may start using the new runtime PM API within genpd as of now.

Stop this broken thinking.  The solution is simple.

Put the generic runtime PM changes into the PM tree in a separate /clean/
branch.  Merge them into the PM-next branch.  Notify me where I can
pull that /clean/ branch.

I pull that clean branch into my tree, and then apply the AMBA specific
patches on top.

That means Rafael has the PM changes, I have the dependent PM changes,
and I also have the AMBA changes, and no one ends up carrying changes
which are inappropriate.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
