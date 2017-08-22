From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3 v3] mfd: db8500-prcmu: Get rid of cpufreq dependency
Date: Tue, 22 Aug 2017 15:43:11 +0200
Message-ID: <22468782.O1RHkarIGQ@aspire.rjw.lan>
References: <20170822131741.23473-1-linus.walleij@linaro.org>
 <7661350.vR4F4a82RE@aspire.rjw.lan>
 <CACRpkdZ91zUPE8Oyf+ZALekCUbAakM=PX6DiYTO-VZewGGNFmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZ91zUPE8Oyf+ZALekCUbAakM=PX6DiYTO-VZewGGNFmg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 22, 2017 3:44:18 PM CEST Linus Walleij wrote:
> On Tue, Aug 22, 2017 at 3:25 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, August 22, 2017 3:17:40 PM CEST Linus Walleij wrote:
> >> The ARMSS clock, also known as the operating point of the
> >> CPU, should not cross-depend on cpufreq like this. Move
> >> the code to use just frequencies and remove the false
> >> frequency (1GHz) and put in the actual frequency provided
> >> by the ARMSS clock (998400000 Hz) as part of the process.
> >>
> >> After this and the related cpufreq patch, the DB8500 will
> >> simply use the standard DT cpufreq driver to change the
> >> operating points through the common clock framework using
> >> the ARMSS clock.
> >>
> >> Acked-by: Lee Jones <lee.jones@linaro.org>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > Well, I've already applied the v2, so do you want me to replace the
> > commit with this patch?
> 
> If you can, else tell me and I can send a fixup patch.

I can. :-)

Done already, but the replacement will show up in linux-next when I re-merge
the branches, which may be in a few days.

> I want to keep Lee happy!

Fair enough.
