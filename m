From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 00/11] CPUFreq Kconfig fixes
Date: Thu, 13 Jun 2013 00:55:03 +0200
Message-ID: <1869545.pIVrdam01k@vostro.rjw.lan>
References: <cover.1371022830.git.viresh.kumar@linaro.org> <CAKohpont-8ZNDWx0n1G8ks=evfoJi3kQ5idjmeguyT8BWgTY4w@mail.gmail.com> <201306121649.41656.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <201306121649.41656.arnd@arndb.de>
Sender: cpufreq-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 12, 2013 04:49:41 PM Arnd Bergmann wrote:
> On Wednesday 12 June 2013, Viresh Kumar wrote:
> > 
> > On 12 June 2013 18:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wednesday 12 June 2013, Viresh Kumar wrote:
> > >> Recently Arnd sent few fixes where drivers were using APIs from freq_table.c but
> > >> haven't selected CPU_FREQ_TABLE. Based on that, I just crossed checked all the
> > >> places where it should be selected and where it shouldn't be. These are fixes
> > >> around that.
> > >>
> > >> I have applied these in my cpufreq-kconfig-fixes branch. Will send you a pull
> > >> request separately once I get some Acks (will wait for few days).
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > I don't see a patch for big.LITTLE in either linux-next or this series. Did you
> > > miss that or has it just not made into linux-next yet?
> > 
> > My ARM branch was pulled in by Rafael, 2 days back. Don't know why didn't
> > you saw that.
> 
> 
> Ah, it seems we haven't had a new linux-next since friday.

Yup, no linux-next this week.

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
