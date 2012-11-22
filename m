From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCHv9 1/3] Runtime Interpreted Power Sequences
Date: Thu, 22 Nov 2012 18:55:16 +0900
Message-ID: <CAAVeFuLL28y89VGU4EfPdW-fKDZCFnyQ37UdhGpeZE3cn0Cbzg@mail.gmail.com>
References: <1353149747-31871-1-git-send-email-acourbot@nvidia.com>
 <1353149747-31871-2-git-send-email-acourbot@nvidia.com>
 <20121120215429.B621F3E1821@localhost>
 <20121121013133.GE4673@opensource.wolfsonmicro.com>
 <CACRpkdaNmBpfONDpt7zFqLaqfiGm+ELpO-v5gZmM0rEi_AzijQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdaNmBpfONDpt7zFqLaqfiGm+ELpO-v5gZmM0rEi_AzijQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ola LILJA2 <ola.o.lilja@stericsson.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Thierry Reding <thierry.reding@avionic-design.de>, Mark Zhang <markz@nvidia.com>, Rob Herring <rob.herring@calxeda.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Anton Vorontsov <cbouatmailru@gmail.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 22, 2012 at 5:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> I have the same (limited by experience) opinion. Working sort of
> near som audio drivers I have understood that power sequencing
> is a big issue not only for things like this backlight example, but
> even more so in the area of audio to avoid clicks and pops.
>
> Is it correct to assume that this library will be useful also for ALSA
> SoC type of devices?

There should be nothing against that - provided ALSA's needs remain
similar to the current set of actions (regulators, gpios, ...) it
should be perfectly usable. Can you think of any usage that involves
more than dumb regulator/gpio manipulation?

If power seqs are to be used this way (as opposed to through the DT),
it will become urgent to implement that gpio handlers library we were
talking about in another thread, as we don't want to have GPIO numbers
hard-coded into the sequences.

Alex.
