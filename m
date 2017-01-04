From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv6 0/4] thermal: add driver for R-Car Gen3
Date: Thu, 5 Jan 2017 00:41:42 +0100
Message-ID: <20170104234142.j4tyhhxbfjk4dz5j@ninjato>
References: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35850 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbdADXlq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Jan 2017 18:41:46 -0500
Content-Disposition: inline
In-Reply-To: <20161222103823.8300-1-niklas.soderlund+renesas@ragnatech.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, Dec 22, 2016 at 11:38:19AM +0100, Niklas Söderlund wrote:
> Hi all,
> 
> The series adds thermal support to Renesas R-Car Gen3 SoCs. It's tested
> on Salvator-X H3 and M3-W SoC.
> 
> Wolfram asked me to have a look at the comments for v4 and to try and
> rework the temperature formulas to work with only ints and if it worked
> out resend the series. I have reworked code in 2/4 but kept Wolfram as
> the author and added my SoB, hope this is OK.
> 
> Reworking the formulas involved moving from s64 to int as the data type
> used to store coefficients used in binary scaled fixed point
> calculations. By examining the largest values which could be produced in
> these calculations a shift of 7 is the maximum scaling which is
> possible and still fit inside an int, previously with s64 the decimal scaling
> was 1000.
> 
> Changing the decimal scaling also reduces the accuracy of the
> calculations. In my tests this was hardly noticeable as the granularity
> of the reported temperature to user-space is 0.5C, comparing the value
> reported in the s64 vs int implementation only differ very slightly when
> it rounded the value to the next 0.5C level.
> 
> However the formulas used to calculate the coefficients are not
> documented and none obvious (at lest not to me) so given different
> initial values to calculate the coefficients the error might become
> larger. Therefore I would like to ask Morimoto-san and/or Khiem to
> provide or proxy testing of this less accurate formula and feedback if
> it's OK, let me know if there is anything I can do to help out.

Tested on H3 and M3-W. The temperatures I get when plugging the fan
on/off are very very similar to previous versions of this driver. Thus:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

