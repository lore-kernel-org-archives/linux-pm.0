From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: enable the DT cpufreq driver on the
 Integrators
Date: Mon, 7 Nov 2016 16:21:37 +0100
Message-ID: <CACRpkdbmaUaQibmTEmORw3mTGLQOfDUwg8zx=wRd3UvFcEtZvg@mail.gmail.com>
References: <1477380085-6929-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477380085-6929-1-git-send-email-linus.walleij@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 25, 2016 at 9:21 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This enables the generic DT and OPP-based cpufreq driver on the
> ARM Integrator/AP and Integrator/CP.
>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Rafael could you merge these two patches so that I can merge the
corresponding DTS files into the ARM SoC tree?

Yours,
Linus Walleij
