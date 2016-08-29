From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH v6 0/8] power: add power sequence library
Date: Mon, 29 Aug 2016 19:10:45 +0800
Message-ID: <20160829111045.GB3736@b29397-desktop>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <b1848eb2-9298-9089-ee4d-5356998c6c08@linaro.org>
 <20160824085335.GB27233@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160824085335.GB27233@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, robh+dt@kernel.org
Cc: Peter Chen <peter.chen@nxp.com>, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, shawnguo@kernel.org, dbaryshkov@gmail.com, dwmw3@infradead.org, mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, linux-usb@vger.kernel.org, oscar@naiandei.net, pawel.moll@arm.com, arnd@arndb.de, linux-pm@vger.kernel.org, festevam@gmail.com, s.hauer@pengutronix.de, stephen.boyd@linaro.org, linux-kernel@vger.kernel.org, troy.kisky@boundarydevices.com, stillcompiling@gmail.com, p.zabel@pengutronix.de, mail@maciej.szmigiero.name, mka@chromium.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2016 at 04:53:35PM +0800, Peter Chen wrote:
> On Tue, Aug 23, 2016 at 04:02:48PM +0530, Vaibhav Hiremath wrote:
> > 
> > 
> > On Monday 15 August 2016 02:43 PM, Peter Chen wrote:
> > >Hi all,
> > >
> > >This is a follow-up for my last power sequence framework patch set [1].
> > >According to Rob Herring and Ulf Hansson's comments[2], I use a generic
> > >power sequence library for parsing the power sequence elements on DT,
> > >and implement generic power sequence on library. The host driver
> > >can allocate power sequence instance, and calls pwrseq APIs accordingly.
> > >
> > >In future, if there are special power sequence requirements, the special
> > >power sequence library can be created.
> > >
> > >This patch set is tested on i.mx6 sabresx evk using a dts change, I use
> > >two hot-plug devices to simulate this use case, the related binding
> > >change is updated at patch [1/6], The udoo board changes were tested
> > >using my last power sequence patch set.[3]
> > >
> > >Except for hard-wired MMC and USB devices, I find the USB ULPI PHY also
> > >need to power on itself before it can be found by ULPI bus.
> > >
> > >[1] http://www.spinics.net/lists/linux-usb/msg142755.html
> > >[2] http://www.spinics.net/lists/linux-usb/msg143106.html
> > >[3] http://www.spinics.net/lists/linux-usb/msg142815.html
> > (Please ignore my response on V2)
> > 
> > Sorry being so late in the discussion...
> > 
> > If I am not missing anything, then I am afraid to say that the
> > generic library
> > implementation in this patch series is not going to solve many of
> > the custom
> > requirement of power on, off, etc...
> > I know you mentioned about adding another library when we come
> > across such platforms, but should we not keep provision (or easy
> > hooks/path)
> > to enable that ?
> > 
> > Let me bring in the use case I am dealing with,
> > 
> > 
> >                               Host
> >                                |
> >                                V
> >                            USB port
> > ------------------------------------------------------------
> >                                |
> >                                V
> >                       USB HUB device (May need custom on/off seq)
> >                                |
> >                                V
> >               =============================
> >              |                             |
> >              V                             V
> >          Device-1                       Device-2
> > (Needs special power               (Needs special power
> >  on/off sequence.                   on/off sequence.
> >  Also may need custom               Also, may need custom
> >  sequence for                       sequence for
> >  suspend/resume)                    suspend/resume)
> > 
> > 
> > Note: Both Devices are connected to HUB via HSIC and may differ
> >           in terms of functionality, features they support.
> > 
> > In the above case, both Device-1 and Device-2, need separate
> > power on/off sequence. So generic library currently we have in this
> > patch series is not going to satisfy the need here.
> > 
> > I looked at all 6 revisions of this patch-series, went through the
> > review comments, and looked at MMC power sequence code;
> > what I can say here is, we need something similar to
> > MMC power sequence here, where every device can have its own
> > power sequence (if needed).
> > 
> > I know Rob is not in favor of creating platform device for
> > this, and I understand his comment.
> > If not platform device, but atleast we need mechanism to
> > connect each device back to its of_node and its respective
> > driver/library fns. For example, the Devices may support different
> > boot modes, and platform driver needs to make sure that
> > the right sequence is followed for booting.
> > 
> > Peter, My apologies for taking you back again on this series.
> > I am OK, if you wish to address this in incremental addition,
> > but my point is, we know that the current generic way is not
> > enough for us, so I think we should try to fix it in initial phase only.
> > 
> 
> Rob, it seems generic power sequence can't cover all cases.
> Without information from DT, we can't know which power sequence
> for which device.
> 

Vaibhav, do you agree that I create pwrseq library list using postcore_initcall
for each library, and choose pwrseq library according to compatible
string first, if there is no compatible string for this library, just
use generic pwrseq library.

-- 

Best Regards,
Peter Chen
