From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PULL REQ] PM / Devfreq for Linux-pm (Fixes)
Date: Tue, 13 Sep 2016 03:05:55 +0200
Message-ID: <1522837.MtqonNvh4x@vostro.rjw.lan>
References: <CGME20160906064335epcms1p75b85321b10ff6d8d045240a785375b23@epcms1p7> <1278751964.451375.1473145738891.JavaMail.weblogic@ep1ml102b> <1416949447.616813.1473240678090.JavaMail.weblogic@ep1ml102b>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59837 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1750934AbcIMA7v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2016 20:59:51 -0400
In-Reply-To: <1416949447.616813.1473240678090.JavaMail.weblogic@ep1ml102b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "hl@rock-chips.com" <hl@rock-chips.com>, "jszhang@marvell.com" <jszhang@marvell.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "yongjun_wei@trendmicro.com.cn" <yongjun_wei@trendmicro.com.cn>, Chanwoo Choi <cw00.choi@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>

On Wednesday, September 07, 2016 09:31:18 AM MyungJoo Ham wrote:
> > On Tue, Sep 6, 2016 at 9:08 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> > >> Dear Rafael,
> > >>
> > >> Here goes pull request from PM / devfreq for linux-pm.
> > >> (The first two patches are previously pull-requested, but not found in v4.8-rc5.
> > >> If you've already pulled them, you may skip the first two)
> > 
> > I haven't pulled them and I'd rather not at this point.  They are not
> > -rc6 time frame fixes.
> > 
> > I may pull the other two if you think they are urgent enough and send
> > a separate request to me for that.
> > 
> > Otherwise, I'll merge the whole thing as 4.9 material.
> > 
> > Thanks,
> > Rafael
> 
> It is ok to merge the whole thin as 4.9; nothing that much urgent I have.
> 
> If you want to merge the (previously) 4.8-rcX and 4.9 at once for 4.9 later,
> you can use "pull_whole_for_4.9" tag (for-next branch)
> 
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-next

OK, pulled from the pull_whole_for_4.9 tag, thanks!

Rafael

