From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] i2c-s3c2410: Add stub runtime power management
Date: Sun, 22 Jan 2012 18:27:11 +0100
Message-ID: <CADkCAusScak6gH4BBowrOpveGG=eDjZdj+X8vF4D5+yi8gv5PA@mail.gmail.com>
References: <1327171600-5489-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F1C082D.2080005@gmail.com>
	<20120122152234.GA2915@opensource.wolfsonmicro.com>
	<4F1C45C6.1040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F1C45C6.1040003@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Guys:

On Sun, Jan 22, 2012 at 6:22 PM, Sylwester Nawrocki
<sylvester.nawrocki@gmail.com> wrote:
> The best solution would be to force platform to enable PM_RUNTIME if they want to
> use a driver which does runtime PM. But this has to wait, yet, probably
> infinitely.. :)

Probably easier to motivate platforms to enable PM_RUNTIME if there
are drivers that require it.  :)

I for one would rather see in-kernel drivers that require it, and then
patches in mailing lists that show how to un-require it.  Make it more
painful to avoid PM_RUNTIME, and less painful to use it.

b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
