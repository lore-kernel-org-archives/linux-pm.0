From: Roland Dreier <rdreier@cisco.com>
Subject: Re: [Bug 12713] Hang on resume from hibernation,
	apparently as result  of 213d9417fec
Date: Sun, 15 Feb 2009 17:28:42 -0800
Message-ID: <adahc2v6ugl.fsf__23289.2075706788$1234800217$gmane$org@cisco.com>
References: <8f53421d0902151605v56c92642ib8c2dcf34fd92ad1@mail.gmail.com>
	<8f53421d0902151607w2985dce6yc1bef7e717166fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8f53421d0902151607w2985dce6yc1bef7e717166fc@mail.gmail.com>
	(Michael S. Tsirkin's message of "Mon, 16 Feb 2009 02:07:59 +0200")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>
Cc: axboe@kernel.dk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, pavel@suse.cz, bugme-daemon@bugzilla.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

 > I haven't read the code in depth, but taking running numbers and doing
 > bitwise "or"
 > on them looks a bit strange to me.
 > So here BIO_RW_SYNC is (3 | 4) = 7, that is the same as BIO_RW_FAILFAST_DEV.
 > So for example bio_failfast_dev and bio_sync are the same.

Yes, this is clearly wrong.  The fix seems to be to delete the
definition of BIO_RW_SYNC, and everywhere that breaks, replace

	1 << BIO_RW_SYNC

with

	(1 << BIO_RW_SYNCIO) | (1 << BIO_RW_UNPLUG)

 - R.
