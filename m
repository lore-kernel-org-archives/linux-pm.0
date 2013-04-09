From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for Apr 9 [cpufreq: NULL pointer deref]
Date: Tue, 09 Apr 2013 16:03:50 +0200
Message-ID: <31778276.CDMUtaAAnc@vostro.rjw.lan>
References: <CA+icZUU_K9PiFMqMsOEk1+c2DX8LrUojZptPiRVarv4dcB2qFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CA+icZUU_K9PiFMqMsOEk1+c2DX8LrUojZptPiRVarv4dcB2qFA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.orgLinux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 09, 2013 02:47:39 PM Sedat Dilek wrote:
> On Tue, Apr 9, 2013 at 11:30 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > Changes since 20130408:
> >
> > The vfs tree still had its build failure so I used the version from
> > next-20130405.
> >
> > The wireless-next tree lost its build failure.
> >
> > The mfd tree still had its build failure so I used the version from
> > next-20130405.
> >
> > The ftrace tree gained a conflict against Linus' tree.
> >
> > The arm-soc tree gained conflicts against the omap_dss2 and gpio-lw trees.
> >
> > ----------------------------------------------------------------------------
> >
> 
> On reboot I see hanging cpufreq with the help of kdb/kgdb?
> See screenshot.
> 
> I have also a screenshot with next-20130326, so this issue seems not to be new.

This is during CPU offline.  Does it only happen on reboot?  What about trying
to offline/online CPUs from sysfs?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
