Return-Path: <SRS0=maSn=A6=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AF2C433E2
	for <linux-pm@archiver.kernel.org>; Sun, 19 Jul 2020 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C9720724
	for <linux-pm@archiver.kernel.org>; Sun, 19 Jul 2020 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595157752;
	bh=Qx6lWarWNiLh4For226TTfWEa+8pX9+5m2BQ6f4eXyg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Eap0t3c8qPzNvAKas8QiYXhRO0D1o/KTOryznW4CnfrPVoKz+J0VmXQQq7kNKJEtq
	 2Ji7Si3gRFTADo8aKbC+gD9Bws8zvh5BS6SENqR3N44di9zDwaHdPMcBoEQyL+bvYd
	 xzBpZ0i2c9TLu3CrxB7T0F1DI5IwpRd640rU3vv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgGSLWb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 19 Jul 2020 07:22:31 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33160 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSLWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jul 2020 07:22:31 -0400
Received: by mail-ot1-f45.google.com with SMTP id h13so10111115otr.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jul 2020 04:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fijpbbur1S++KIUSFgM8srzJEnK9yXo2y7NPk8w0gK4=;
        b=A3REqtPJibfOJQiAMSkRb9/gEP9aA5qUO64r1oNJP0NhHmimVIteq6lZDwVtaWkbil
         YD34+Au/ZtHo3ZsP5o6jKFS7wChrJaLgn7+9b2PficEY9s+G3nlOeitI/T0RpKHHIwQc
         bqXYIJBbRI1BwS70LojIaytYDYuC2t8GylymJz6w4tTiJR8CzO/LkWXv9Uszm2CNFCaz
         tM5XT+HoybiDPmuaNBtVAgcQXtH4TSHW6B4Qg2sq03JwXTKhkdlJ9+WR5OC8eXtxYiEy
         lgC7z5q0l58iQGQCgoop1hJeNknTh/rM1QEmqO/6B76/T/o2d3Vp81AW26YYM8dwsMxg
         3MOg==
X-Gm-Message-State: AOAM530mvN+d1wxkEk9+kzsJbykMSPe1XmmcNaAM+3LbaQFvClVmWTx+
        Vd7aHDfNbm3RNOgloQysEyNAaoobxrmgleBnNPc=
X-Google-Smtp-Source: ABdhPJyzFj0qUvHL85U021kTWXRigg2UzqIIUBxK6jasu/ktsnKrdrEx73kMpRhQqZK4muYEMHMqDSSmjpNP3ras7J8=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr15964334oth.262.1595157750375;
 Sun, 19 Jul 2020 04:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <000701d656be$c48083e0$4d818ba0$@net> <CAJZ5v0hKeHBNC2Bzdizm=42jtOqq8VOswCNNNk5HA9x_Y2T_Ng@mail.gmail.com>
 <001d01d65af9$6dd46180$497d2480$@net> <CAJZ5v0gvqhfHDDzVHNP4ODMfujaWA8Y8OuLF_i4JoM_1jVh=2w@mail.gmail.com>
 <004401d65c80$7254fcf0$56fef6d0$@net>
In-Reply-To: <004401d65c80$7254fcf0$56fef6d0$@net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 19 Jul 2020 13:22:19 +0200
Message-ID: <CAJZ5v0gBtMSCtj4Kh-sSS3uAiybnXhFBSH8SBpN7sys-xbOgYQ@mail.gmail.com>
Subject: Re: cpufreq: intel_pstate: EPB with performance governor
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 17, 2020 at 11:23 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> Thank you for your reply.
> I'll give it up after this, I promise.
>
> On 2020.07.16 05:00 Of Rafael J. Wysocki
> > On Thu, Jul 16, 2020 at 12:44 AM Doug Smythies <dsmythies@telus.net> wrote:
> > > On 2020.07.15 09:47 Rafael J. Wysocki wrote:
> > > > On Fri, Jul 10, 2020 at 3:34 PM Doug Smythies <dsmythies@telus.net> wrote:
> ...
> > > > you can simply set the EPB to 0 via
> > > > energy_perf_bias for all CPUs and it should stick.
> > >
> > > And I am saying I should not have to do that, or even know about it,
> > > when I want to use the performance governor.
> >
> > Again, cpufreq governors are on top of the EPB.
> >
> > > But yes, I expect the driver to remember the default, or otherwise set,
> > > value of EPB for all the other governors.
> >
> > We clearly don't agree here.
>
> Agreed. (That we disagree.)
>
> It is done with EPP in active mode with HWP between performance
> and powersave governors, so I struggle with treating the EPB
> case differently.

First, it is a different scope.  The EPP is the processor only (and
specifically the CPU whose HWP request is updated) and the EPB is the
whole SoC (at least).

Second, the EPB is still there on HWP systems, so the EPP is not a
replacement for it.  It is a separate control on top of it.

Hence, whatever is done to the EPP has no bearing on what should be
done to the EPB.  Moreover, because the other cpufreq drivers don't
update the EPB, there is no reason for intel_pstate to do that.

> > Also in the passive mode of intel_pstate, when the regular cpufreq
> > "performance" governor is in use, it's all about setting the frequency
> > to the max alone through min = max without touching any other knobs
> > which need to be adjusted separately.  That's how it's been always
> > working and changing it now may confuse the users who have learned to
> > rely on this behavior.
>
> But the behaviour is inconsistent anyhow.
>
> How can we possibly claim that this:
>
> doug@s18:~$ sudo ~/turbostat --quiet --show Busy%,Bzy_MHz,PkgTmp,PkgWatt,GFXWatt,IRQ --interval 6
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 18.12   3700    25782   38      13.94   0.00
> 0.55    3701    3000    38      13.94   0.00
> 0.01    3701    49
> 19.29   3700    5529
> 35.97   3700    6051
> 26.99   3700    5177
> 25.92   3700    5976
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 18.12   3700    27042   40      14.15   0.00
> 0.55    3701    2978    40      14.15   0.00
> 0.01    3701    22
> 30.01   3700    6042
> 28.09   3700    6044
> 29.18   3700    6046
> 20.91   3700    5910
> Busy%   Bzy_MHz IRQ     PkgTmp  PkgWatt GFXWatt
> 18.13   3700    27195   40      14.06   0.00
> 0.55    3701    2983    40      14.06   0.00
> 0.01    3701    20
> 27.64   3700    6039
> 20.31   3700    6043
> 36.12   3700    6056
> 24.18   3700    6054
>
> is "performance" mode?
> There is plenty enough load on 4 of the CPUs.
> In performance mode I would expect 4.6 GHz.
>
> You can see the request for pstate 46,
> But only pstate 37 is granted:

Well, that's how it goes, on this particular system.

What a "regular" cpufreq driver can do (and which also applies to
intel_pstate in the passive mode) is to ask for the frequency selected
by the governor.  Anything else is beyond the scope of its use.
Anything else would be inconsistent and so it may be confusing.

> root@s18:/home/doug# /home/doug/c/msr-decoder
> 8.) 0x198: IA32_PERF_STATUS     : CPU 0-5 :  37 :  37 :  37 :  37 :  37 :  37 :
> B.) 0x770: IA32_PM_ENABLE: 0 : HWP disable
> 9.) 0x199: IA32_PERF_CTL        : CPU 0-5 :  46 :  46 :  46 :  46 :  46 :  46 :
> C.) 0x1B0: IA32_ENERGY_PERF_BIAS: CPU 0-5 :   6 :   6 :   6 :   6 :   6 :   6 :
> 1.) 0x19C: IA32_THERM_STATUS: 883E0000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OOB Bit 8 reset OOB Bit 18 reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 883C0000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 0
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disable

As a general rule, on Linux you'll never see EPB==0 after a fresh boot
and so it needs to be adjusted via sysfs.

If you get better results with EPB==0, set it to 0, but that may not
match everybody's needs (which is why it is never 0 after a fresh boot
in the first place).
