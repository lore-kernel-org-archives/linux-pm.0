From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] Thermal Management updates for 3.19-rc1
Date: Thu, 18 Dec 2014 15:54:06 +0800
Message-ID: <1418889246.22607.1.camel@rzhang1-toshiba>
References: <1418807145.5983.27.camel@rzhang1-toshiba>
	 <CA+55aFyLpbx8MhNYvQvp74VjmvPEeJTFAw25cnPYFG1B-CLexQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:47764 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857AbaLRHyO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 18 Dec 2014 02:54:14 -0500
In-Reply-To: <CA+55aFyLpbx8MhNYvQvp74VjmvPEeJTFAw25cnPYFG1B-CLexQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

On Wed, 2014-12-17 at 10:29 -0800, Linus Torvalds wrote:
> Pulled, but:
> 
> On Wed, Dec 17, 2014 at 1:05 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> >
> >  Documentation/devicetree/bindings/thermal/armada-thermal.txt   |   8 --
> >  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt |  68
> > ++++++++++++++
> 
> Please fix your pull request generation.
> 
> It *looks* like you are doing the diffstat in a very wide window, and
> then doing a cut-and-paste into email.
> 
exactly.

> Resulting in all these huge long lines that wrap in a very ugly way. Like this:
> 
> >  drivers/thermal/rockchip_thermal.c                             | 693
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 
> that's not exactly legible, is it?
> 
> In order to use your screen estate to full advantage, "git diff
> --stat" will default to the terminal width, but it does default to the
> normal 80 columns if you just output to a file.
> 
yes, this works. I will output to a file next time.

thanks,
rui

> Or if you really want to cut-and-paste and do this from a terminal,
> just use "--stat=72" instead of just plain "--stat". Or use "export
> COLUMNS=80" or something.
> 
>                            Linus


