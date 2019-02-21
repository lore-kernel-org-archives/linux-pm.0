From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 06/10] Platform: OLPC: Add XO-1.75 EC driver
Date: Thu, 21 Feb 2019 15:28:26 +0200
Message-ID: <CAHp75VcWMf086oGrJHWOCgYFy-J-KLw+jzFoAwuXaHtS7dgdvA@mail.gmail.com>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-7-lkundrak@v3.sk>
 <20190221012231.GC5838@wrath>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190221012231.GC5838@wrath>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Darren Hart <dvhart@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Platform Driver <platform-driver-x86@vger.kernel.org>, Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <andy@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 21, 2019 at 3:22 AM Darren Hart <dvhart@infradead.org> wrote:
>
> On Thu, Jan 10, 2019 at 06:58:41PM +0100, Lubomir Rintel wrote:
> > It's based off the driver from the OLPC kernel sources. Somewhat
> > modernized and cleaned up, for better or worse.
> >
> > Modified to plug into the olpc-ec driver infrastructure (so that battery
> > interface and debugfs could be reused) and the SPI slave framework.

> > Basically all of the above is based on the review by Andy Shevchenko.
>
> Andy, I am happy to merge this series - but this patch includes a lot of changes
> driven by your feedback. Are you satisfied with the changes, would you like to
> add your Reviewed-by?

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Open minors:
 - u8 vs. unsigned char in a cases when it's about command to send to
HW (including unnecessary & 0xff parts)
 - _TIMEOUT w/o units a bit odd (perhaps _TIMEOUT_MS ?)

I think this may be addressed later on.

-- 
With Best Regards,
Andy Shevchenko
