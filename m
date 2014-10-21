From: Arun KS <getarunks@gmail.com>
Subject: Re: understanding cpuidle
Date: Tue, 21 Oct 2014 17:03:33 +0530
Message-ID: <CABOM9Zpzx11gQ+ontBxY6MhrYW=AxtRdGhdybsEpp=gxwHxWLQ@mail.gmail.com>
References: <CAJ2oMhK_BccGQe9m1bHAc4St_jaBfaSFvyPnTRKxJwzGkfk-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:58373 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039AbaJULd4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 07:33:56 -0400
In-Reply-To: <CAJ2oMhK_BccGQe9m1bHAc4St_jaBfaSFvyPnTRKxJwzGkfk-6Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-pm@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ran,

On Thu, Oct 16, 2014 at 1:12 PM, Ran Shalit <ranshalit@gmail.com> wrote:
> Hello,
>
> I try to understand the cpuidle main concept but have some
> difficulties. I could not find any documentation to explain the
> cpuidle.
>
> what does it mean that it enters idle when "no thread to run" ?if I
> have only one process which does only
> while(1)
> {
>  printf("C");
> mdelay(1000);
> }
> Can I expect it to enter idle for 1 second and then print "C" and get
> again to idle ?


Your code will not go to cpu idle, because it is mdelay(), which is a
busy looping.

If you have used msleep(), you are relinquishing the cpu.
Considering the fact that you have only one process running in your
system, no other process in runnable state, kernel schedules the
swapper(or idle) process.
And you will enter into cpu idle.

Thanks,
Arun

>
> Thanks
> Ran
>
> _______________________________________________
> Kernelnewbies mailing list
> Kernelnewbies@kernelnewbies.org
> http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
