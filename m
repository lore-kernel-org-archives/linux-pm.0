From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 17:12:09 +0300
Message-ID: <4BFFCF39.3010507__37735.7691330419$1275055107$gmane$org@nokia.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>	<20100527220949.GB10602@srcf.ucam.org>	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>	<20100527223605.GB11364@srcf.ucam.org>	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>	<20100528043114.GC26177@thunk.org>	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>	<20100528114123.GA22947@srcf.ucam.org>	<4BFFB681.1000105@nokia.com>	<AANLkTim04ZfMcPHRB2D_bqcAuguaGwySH2b6repuYLkk@mail.gmail.com>	<4BFFC5DF.5030504@nokia.com>
	<AANLkTikKGeGHHL6AYC7uBuT7Zihj7lozfidWQ8zRHwab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikKGeGHHL6AYC7uBuT7Zihj7lozfidWQ8zRHwab@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Brian Swetland <swetland@google.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>, Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

ext Brian Swetland wrote:

> How is it flawed?  Serious question.
>   

I would avoid repeating all the good arguments given so far, but to make 
it short:

* I believe runtime PM is a much better starting point (at least for the 
type of HW targeted at mobile devices) because it mimics an always-on 
system toward userspace, which requires less disruption in the way apps 
are designed

* QoS is closer to the apps pov: fps if it is a media player or a game, 
transfer speed if it is a file manager, bandwidth if it is a network 
app, etc
The app is required to express its opinion by using a format that it 
understands better and is less system dependent.
Actually the kernel should only be concerned with 2 parameters at most 
for any given operation: latency and bandwidth/throughput

* Some form of resource management is needed as trust mechanism to 
discriminate "trusted" vs untrusted apps that can give reliable info 
(but in your case you should give trust to whom prevents the suspend)

* Most of this could be done in userspace with the kernel merely 
providing the means to enforce the decisions taken by the userspace manager.

* The kernel wouldn't even have to try to outsmart the "evil application 
writer"

igor
