From: David Brownell <david-b@pacbell.net>
Subject: Re: Wakeup-events implementation
Date: Tue, 17 Aug 2010 11:37:22 -0700 (PDT)
Message-ID: <324856.49167.qm@web180313.mail.gq1.yahoo.com>
References: <Pine.LNX.4.44L0.1008171109030.1656-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008171109030.1656-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



--- On Tue, 8/17/10, Alan Stern <stern@rowland.harvard.edu> wrote:

I wasn't
> aware that memory cards could generate wakeup events.

Almost all MMC/SD hardware can generate reliable
insert/remove events, in my experience.  So MMC/SD
drivers I've modified tend to treat them as wake
events ... userspace can respond without polling
constantly "did it change yet, huh, did it???"

Unfortunately Pierre spent a lot of time hard-wiring
UNSAFE_RESUME assumptions into the MMC core, so lots
of that stuff is currently (and needlessly) broken.

And of more experimental interest, something I don't
recall being discussed here:  I/O completions as
wake events.  Start an I/O, enter low power state,
and wake when it completes.  Easily done on lots of
embedded hardware..
