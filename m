From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: power draw depending on PHY speed
Date: Fri, 28 Aug 2009 21:03:59 +0200
Message-ID: <200908282103.59159.rjw__34102.6245886043$1251486324$gmane$org@sisk.pl>
References: <76FA3B279DD9DA48896E2B40494495720368E449@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76FA3B279DD9DA48896E2B40494495720368E449@USA7061MS02.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: martyleisner@yahoo.com, NetDEV list <netdev@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday 28 August 2009, Leisner, Martin wrote:
> While doing some current probe measurements (i.e. to measure the effects
> of NAP and frequency scaling with a freescale processor) I noticed some
> very
> significant differents if we ran on 100Mbit of 1000Mbit ethernet.
> 
> The hardware guys like at their data sheets and agreed.
> 
> Does anyone "drop ethernet speed" to save power?
> (when a system is idle, is isn't necessary to run 1G ethernet).

I don't know, really.  This is a netdev question IMO (CC added).

> When a system has WOL capability, what speed does it run at when the
> system is sleeping?

That's a very good question.  I bet that depends on the NIC in question, at
least I'm not sure if any spec regulates it.

Thanks,
Rafael
