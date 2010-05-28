From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 16:30:03 +0300
Message-ID: <4BFFC55B.5050908__21950.2673404806$1275052095$gmane$org@nokia.com>
References: <20100527222514.0a1710bf@lxorguk.ukuu.org.uk>	<Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>	<20100527220949.GB10602@srcf.ucam.org>	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>	<20100527223605.GB11364@srcf.ucam.org>	<20100527235546.09f3ce8a@lxorguk.ukuu.org.uk>	<20100528043114.GC26177@thunk.org>	<20100528103713.0a7952d9@lxorguk.ukuu.org.uk>
	<06439EEF-9404-45DC-AB37-5CC0486CCF6C@mit.edu>
	<4BFFBBE6.50604@nokia.com>
	<67B0FE92-F943-470C-9B23-27BF3F7E81DB@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <67B0FE92-F943-470C-9B23-27BF3F7E81DB@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Theodore Tso <tytso@mit.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

ext Theodore Tso wrote:

>
>
> Well, yes, if the company strategy is to have a walled garden ala the Apple iPhone App store, life is much simpler.   

No, the strategy is to try to merge commercial and community needs.

We do support signed repositories.

The community has control on the public one.

Members are encouraged to help by alpha/beta testing apps that are under 
development.
They even organize testing marathons.

> But if the requirements mean that apps don't need preapproval, the requirements on the platform get harder.

That's a wrong way to put it. By installing something on your phone you 
_do_ approve it.

>    I think the take-home here is we have a requirement that the platform behave well even without someone screening the applications for the "default SW repository".

What it meant is totally different. Regardless how much effort you put 
into twisting it.
It means that different repositories provide different level of trust.

As Debian user, I don't blame anybody other than myself is something 
I've pulled from unstable or experimental breaks my system.
Debian by default doesn't ship with either unstable or experimental enabled.

And using suspend blockers doesn't really solve the problem of who to 
trust to take the block and who not.

Or we'll have to have suspend-blockers-blockers and so on ...

Like it or not, QoS and resource management - in some form - are needed 
to allow trusted application to provide valuable feedback, while 
filtering requests from untrusted applications.

You might want to add dynamic profiling and try to use some heuristic to 
have the system doing runtime evaluation of good vs bad applications, 
but still some discrimination mechanism will be required.


igor
