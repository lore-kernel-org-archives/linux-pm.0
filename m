From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on supplier unbind
Date: Wed, 11 Jul 2018 11:46:33 +0200
Message-ID: <1982222.Z9Wz93BAKD@aspire.rjw.lan>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org> <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com> <1c0f5cb8-4805-4200-406f-0725122b524f@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1c0f5cb8-4805-4200-406f-0725122b524f@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, July 5, 2018 6:28:16 AM CEST Vivek Gautam wrote:
> 
> On 7/5/2018 4:49 AM, Rafael J. Wysocki wrote:
> > On Wed, Jul 4, 2018 at 8:09 PM, Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >>
> >> On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
> >>> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
> >>>> Adding Ulf and Marek.
> >>>>
> >>>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
> >>>>> Add a flag to autoremove the device links on supplier driver
> >>>>> unbind. This obviates the need to explicitly delete the link
> >>>>> in the remove path.
> >>>>> We remove these links only when the supplier's link to its
> >>>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
> >>>>>
> >>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
> >>>>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>> Cc: linux-doc@vger.kernel.org
> >>>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>>> Cc: linux-pm@vger.kernel.org
> >>>>> Cc: linux-arm-msm@vger.kernel.org
> >>>>> ---
> >>>> Hi Rafael, et al.
> >>>>
> >>>> Gentle ping.
> >>>> Do you have comments on this series. I would really like to conclude
> >>>> these
> >>>> device link additions sooner, and get things moving on the long awaited
> >>>> arm-smmu clock/runtime support series.
> >>>>
> >>>> Thanks again for reviewing these patches.
> >>> They are fine by me.
> >>>
> >>> I can queue them up for 4.19 if no one has objections (Greg in
> >>> particular).
> >>
> >> Hi Rafael,
> >>
> >> I will resubmit these 2 patches as part of the arm-smmu series, as one
> >> of the patch in the series depends on addition of
> >> DL_FLAG_AUTOREMOVE_SUPPLIER.
> >> So these 2 patches and arm-smmu series should go together.
> >> Can you please consider givnig your Ack?
> > I would prefer to apply them myself to be honest and put them on an
> > public git branch for you to pull from.
> 
> Sure. Fine with me. I will base the smmu patches on your branch.

The patches have been applied and are available for pulling in the pm-core
branch of the linux-pm.git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-core

Thanks,
Rafael
