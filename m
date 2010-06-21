From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: Suspend hangs since 2.6.34
Date: Tue, 22 Jun 2010 00:27:38 +0200
Message-ID: <20100621222738.GA7166__11634.262026246$1277159300$gmane$org@mac.home>
References: <20100609175356.GA17332@x61.home> <201006100142.13131.rjw@sisk.pl>
	<20100620225601.GA15589@x61.home> <201006212124.09076.rjw@sisk.pl>
	<20100621213224.GA5723@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100621213224.GA5723@mac.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

another observation:

As the the computer suspends if I kill the hanging suspend script, I
tried to see that the suspend script is doing. So I attached strace to
it:

$ strace -f -p 6652

After this, the computer suspended.

Regards,
Tino
