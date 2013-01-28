From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq, highbank: add support for highbank cpufreq
Date: Mon, 28 Jan 2013 16:37:18 +0800
Message-ID: <20130128083716.GE31689@S2101-09.ap.freescale.net>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1359143205-20279-5-git-send-email-mark.langsdorf@calxeda.com>
 <20130126143950.GA7079@S2101-09.ap.freescale.net>
 <1523559.2KevGvelzH@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1523559.2KevGvelzH@vostro.rjw.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Langsdorf <mark.langsdorf@calxeda.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rafael,

On Sat, Jan 26, 2013 at 11:24:12PM +0100, Rafael J. Wysocki wrote:
> > As we are moving to multiplatform build, this init function will run
> > on all other platforms built together with highbank.  We should
> > probably eliminate that effect.
> 
> That change can be made on top of the Mark's patches I think, right?
> 
Yes.

> If so, I'd prefer it that way.  The Mark's patches have been in a limbo for
> too long already and that issue doesn't seem to be serious enough to block
> them any longer.
> 
Ok, I will take care of the changes needed on highbank.  Do you have
a branch with Mark's series and the EXPORT_SYMBOL() one applied,
so that I can start my patch from there.

Shawn
