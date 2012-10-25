From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] Thermal: Add ST-Ericsson DB8500 thermal dirver.
Date: Thu, 25 Oct 2012 15:41:54 +0530
Message-ID: <CAKohpo=nET=Y+wdpOuBeuXj9gbVUOvg9NChLpbDrBS3QgMrn_Q@mail.gmail.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-6-git-send-email-hongbo.zhang@linaro.com>
	<CAKohpo=L-Xz90h90Q78gr7enOHK3u1TwHSs-QPQNE=0896SjRA@mail.gmail.com>
	<CAJLyvQxEAeP__drUAAz6D_UeeDRvdqKdmim3xAO7sXP8cCM8=g@mail.gmail.com>
	<CAKohpomZZiXnnkUC=9ZQoux1BVh+uJZw_oM1Ahndua2PZaKiDw@mail.gmail.com>
	<CAJLyvQw7=ucSTXH8YyPrm6LS8uDyxJkWGEVP2jQ3FL=cYN7frg@mail.gmail.com>
	<CAJLyvQzpo19hhwG9a4GEv0HCdJtfSJz_ASRnE-WKbwbMa58Akw@mail.gmail.com>
	<CAKohpo=grLyatiDEvSi_P+atRJ=JBVs_eWKbtumEkWenPr3EDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42743 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935290Ab2JYKLz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Oct 2012 06:11:55 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1147831iag.19
        for <linux-pm@vger.kernel.org>; Thu, 25 Oct 2012 03:11:54 -0700 (PDT)
In-Reply-To: <CAKohpo=grLyatiDEvSi_P+atRJ=JBVs_eWKbtumEkWenPr3EDg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, kernel@igloocommunity.org, linaro-kernel@lists.linaro.org, "hongbo.zhang" <hongbo.zhang@linaro.com>, patches@linaro.org

On 25 October 2012 15:34, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25 October 2012 15:26, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:

This is what your prcmu driver's routines are doing:

int db8500_prcmu_config_hotmon(u8 low, u8 high)
{
...
	wait_for_completion(&mb4_transfer.work);
...
	return 0;
}

This is why others in STE have used threaded_irqs... Because the
routine you guys call from interrupt handlers actually sleeps.

So, they can't be called from interrupt context.

I wanted you to knew this :)

Its okay now, you need to use threaded irq only and you can't use
normal request_irq(). Its not that you want to make things fast that's why
you used threaded irqs... If you try to sleep from interrupt context
(i.e. if you
have registered your handler with request_irq()), you will see a kernel crash.

--
viresh
