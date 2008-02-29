From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [RFC][PATCH] cpuidle: avoid singing capacitors
Date: Fri, 29 Feb 2008 16:44:07 -0500
Message-ID: <20080229214407.GC1289__6959.83852861008$1204383720$gmane$org@csclub.uwaterloo.ca>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 29, 2008 at 07:38:12PM +0100, Pierre Ossman wrote:
> +/*
> + * The minimum number of ticks needed to not oscillate faster than
> + * 500 Hz.
> + */
> +#define MIN_DEEP_INTERVAL (HZ / 500)

What happens here if HZ < 500?  Or does the fact that you have less than
500HZ jiffies automatically imply that you can't go to sleep more than
the jiffy rate times per second?

--
Len Sorensen
