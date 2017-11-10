From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v5 0/7] PM / devfreq: Use OPP interface to handle the
 frequency
Date: Thu, 9 Nov 2017 16:12:59 -0800
Message-ID: <20171110001259.GD28761@minitux>
References: <CAOCOHw5+TtrCrnDUVj1QjBYb5tivsgTFL_8MgDGocAp0uWoEUw@mail.gmail.com>
 <1508722332-10628-1-git-send-email-cw00.choi@samsung.com>
 <CGME20171023013213epcas1p165faa416f69659b60ec4c3f18ea251d8@epcms1p2>
 <20171109235654epcms1p29b8d05dce899f1b11919823ed66cbd1c@epcms1p2>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:53987 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755091AbdKJANE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 19:13:04 -0500
Received: by mail-pg0-f68.google.com with SMTP id s2so6036480pge.10
        for <linux-pm@vger.kernel.org>; Thu, 09 Nov 2017 16:13:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171109235654epcms1p29b8d05dce899f1b11919823ed66cbd1c@epcms1p2>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "chanwoo@kernel.org" <chanwoo@kernel.org>, Inki Dae <inki.dae@samsung.com>, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vinayak Holikatti <vinholikatti@gmail.com>, Vivek Gautam <vivek.gautam@codeaurora.org>

On Thu 09 Nov 15:56 PST 2017, MyungJoo Ham wrote:

> > On Sun, Oct 22, 2017 at 6:32 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > > These patches makes the devfreq to use the OPP interface and clean-up codes.
> > >
> >
> > Hi Chanwoo,
> >
> > This patch series breaks UFS support on modern Qualcomm platforms
> > (e.g. MSM8996).
> 
> Could you please show us the code location of it? 
> 

The driver is drivers/scsi/ufs/ufshcd.c function ufshcd_probe_hba()
calls devm_devfreq_add_device() without there being an opp table
associated with hba->dev. This used to return fine and
ufshcd_devfreq_target() was called with *freq = UINT_MAX.

Unfortunately the driver seems to be designed in such a way that without
a call to ufshcd_devfreq_target() with *freq 0 or UINT_MAX some clock is
left off, causing my board to reboot; so there's unfortunately a few
levels of issues to fix here.

Regards,
Bjorn
