From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
Date: Mon, 08 Apr 2013 18:15:09 +0900
Message-ID: <2ccd01ce3439$911b51b0$b351f510$%kim@samsung.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
 <CAKohpokk1Q+0gRpeW=ts0a8D+rGAUpHu62X+7ejdpfom_B6FYA@mail.gmail.com>
 <1769336.FkfMpuXqqb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58710 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759250Ab3DHJPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Apr 2013 05:15:11 -0400
In-reply-to: <1769336.FkfMpuXqqb@vostro.rjw.lan>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'Viresh Kumar' <viresh.kumar@linaro.org>
Cc: robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, 'Ben Dooks' <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Rafael J. Wysocki wrote:
> 
> On Friday, April 05, 2013 12:36:34 PM Viresh Kumar wrote:
> > On 5 April 2013 12:18, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > > Basically, this moving looks good to me, but should be re-worked based
> on
> > > for-next of samsung tree because this touches too many samsung stuff
> so this
> > > should be sent to upstream via samsung tree.
> >
> > Hmm... Its already applied in Rafael's tree. But it doesn't mean that
> > it can't be
> > moved to your tree if there is a issue.
> 
> Well, I'm dropping it.  Please merge via the Samsung tree.
> 
OK, I will.

I got patch file from Viresh, and there is a sign from Rafael, but it should be ack. So Rafael, let me use your ack on this patch when I apply. If any problems, please let me know.

Thanks.

- Kukjin

