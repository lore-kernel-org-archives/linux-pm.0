From: Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v5 2/7] x86, olpc: Use a correct version when making up
 a battery node
Date: Mon, 11 Feb 2019 12:37:19 +0100
Message-ID: <48f658a78ddcd6cc67f6eb280dc2c3aa3399c459.camel@v3.sk>
References: <20190110174005.1202564-1-lkundrak@v3.sk>
         <20190110174005.1202564-3-lkundrak@v3.sk>
         <20190123205627.nbddtfuy6qdo2bgb@earth.universe>
         <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0adff00d4c4797fe1f9d593a7ba7c772ac3312c4.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, x86@kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi Sebastian,

perhaps the message slipped through the cracks? I'm happy to do
whatever is needed to get the patch set into 5.1, but it seems I need
some help and clarifications.

Thank you,
Lubo

On Thu, 2019-01-31 at 13:26 +0100, Lubomir Rintel wrote:
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
