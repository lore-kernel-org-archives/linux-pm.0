From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] thermal: imx: depend on imx SoC arch
Date: Sun, 21 Aug 2016 21:39:45 +0800
Message-ID: <1471786785.2188.5.camel@intel.com>
References: <1464183950-7035-1-git-send-email-pbrobinson@gmail.com>
         <CAAQ0ZWQoF6bw0V841OJoJ+oyV26ocYub80nRPYj-6AYLhQC9TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:63198 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752809AbcHUNt2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Aug 2016 09:49:28 -0400
In-Reply-To: <CAAQ0ZWQoF6bw0V841OJoJ+oyV26ocYub80nRPYj-6AYLhQC9TA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Peter Robinson <pbrobinson@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 六, 2016-08-20 at 08:43 +0800, Shawn Guo wrote:
> On Wed, May 25, 2016 at 9:45 PM, Peter Robinson <pbrobinson@gmail.com
> > wrote:
> > 
> > Not much use unless the SoC is selected so depend on the ARCH_MXC
> > and COMPILE_TEST like all the other thermal drivers.
> > 
> > v2: drop extraneous OF
> > 
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

patch applied.

thanks,
rui
