From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up a
 battery node
Date: Thu, 31 Jan 2019 13:59:55 +0100
Message-ID: <20190131125955.GI6749@zn.tnic>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
 <20190110174005.1202564-3-lkundrak@v3.sk>
 <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
 <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, platform-driver-x86@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

+ the platform maintainers.

On Thu, Jan 31, 2019 at 01:26:16PM +0100, Lubomir Rintel wrote:
> Hi,
> 
> On Wed, 2019-01-23 at 21:56 +0100, Sebastian Reichel wrote:
> > Hi,
> > 
> > On Thu, Jan 10, 2019 at 06:40:00PM +0100, Lubomir Rintel wrote:
> > > The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> > > ambient temperature. Add a different compatible string to the 1.5
> > > battery.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > ---
> > 
> > I either need an Acked-by from the x86 platform maintainers, that I
> > can queue this through power-supply or a pull request for an immutable
> > branch (probably the better idea).
> 
> I'm happy to prepare a branch that could be pulled from. In fact,
> here's a branch with fixes for issues pointed out by the review that
> could be pulled from:
> 
>   git pull https://github.com/hackerspace/olpc-xo175-linux lr/olpc-xo175-battery-for-v5.1
> 
> What do really not understand is how does this help. This is probably
> just my unfamiliarity with the process; but perhaps you could help me
> get less unfamiliar. Would it somehow help with a potential (though
> unlikely) conflict resolution? Would an Ack from x86 crowd serve as an
> altenative way off making sure things in their tree won't conflict with
> this one?
> 
> > -- Sebastian
> 
> Thank you
> Lubo
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
