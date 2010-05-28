From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Fri, 28 May 2010 15:02:37 +0100
Message-ID: <20100528140237.GD25798__10560.5358411141$1275055480$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.1005271730180.3239-100000@iolanthe.rowland.org>
	<20100527230806.4deb6de3@lxorguk.ukuu.org.uk>
	<20100527220949.GB10602@srcf.ucam.org>
	<20100527232357.6d14fdb2@lxorguk.ukuu.org.uk>
	<AANLkTil6Bo7qZltbLzHJjIDyruKHFQEURpe5LPJEpTws@mail.gmail.com>
	<20100528101755.7b5f6b8a@lxorguk.ukuu.org.uk>
	<AANLkTilYHKKmQePBGW3LVLjUZy7HXHQku2Iub-LWGBm6@mail.gmail.com>
	<20100528132138.2d802d77@lxorguk.ukuu.org.uk>
	<20100528123110.GA23930@srcf.ucam.org>
	<20100528145420.1c06e4a3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100528145420.1c06e4a3@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Fri, May 28, 2010 at 02:54:20PM +0100, Alan Cox wrote:

> I am not convinced at this point. If the app gets put into the important
> group by the driver then you don't need to poke a policy manager.

Ok, I think I've misunderstood you. You're actually saying that only 
applications that are trusted to behave well are allowed to receive 
wakeup events? Yes, that makes implementation significantly easier. If 
that maps reasonably well onto the existing Android application space, 
it may even be an acceptable compromise.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
