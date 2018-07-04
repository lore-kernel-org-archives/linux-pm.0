From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on supplier unbind
Date: Wed, 04 Jul 2018 12:44:20 +0200
Message-ID: <2991909.NMIP74eIIJ@aspire.rjw.lan>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org> <20180627125056.12851-2-vivek.gautam@codeaurora.org> <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
> Adding Ulf and Marek.
> 
> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
> > Add a flag to autoremove the device links on supplier driver
> > unbind. This obviates the need to explicitly delete the link
> > in the remove path.
> > We remove these links only when the supplier's link to its
> > consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-msm@vger.kernel.org
> > ---
> 
> Hi Rafael, et al.
> 
> Gentle ping.
> Do you have comments on this series. I would really like to conclude these
> device link additions sooner, and get things moving on the long awaited
> arm-smmu clock/runtime support series.
> 
> Thanks again for reviewing these patches.

They are fine by me.

I can queue them up for 4.19 if no one has objections (Greg in
particular).

Thanks,
Rafael
