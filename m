From: Andreas Mohr <andi@lisas.de>
Subject: Re: select with timeout across S3
Date: Thu, 28 Aug 2008 22:57:36 +0200
Message-ID: <20080828205736.GA11743__19201.7232221135$1219957290$gmane$org@rhlx01.hs-esslingen.de>
References: <556445368AFA1C438794ABDA8901891C09639B7A@USA0300MS03.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <556445368AFA1C438794ABDA8901891C09639B7A@USA0300MS03.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

dito.

This also happened to me a couple (4?) months ago, likely on 2.6.24 or
2.6.25.
And for me it had the "very nice" effect of not obeying DHCP lease time,
with a red-faced IT guy appearing in my door the next morning thusly... ;)

>From examining it more closely, it was rather obvious that select timeout
happened maybe 10 hours later than it should have (with 12h lease time),
due to hitting nightly S2R about two hours into the lease time.
Annoying, to say the least.

I think I then privately asked some timer guy about it, but I didn't get
a reply.

The DHCP client to hit this was pump, IIRC (can re-check).

Andreas Mohr
