From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 29 May 2010 16:09:15 +0100
Message-ID: <20100529160915.051ab19f@lxorguk.ukuu.org.uk>
References: <20100529131810.5bb51bdd@schatten.dmk.lab>
	<Pine.LNX.4.44L0.1005290941060.30763-100000@netrider.rowland.org>
	<AANLkTimyLsldXoZ_egjybwS9kE_OcxsOuZwC0F-C2HjY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimyLsldXoZ_egjybwS9kE_OcxsOuZwC0F-C2HjY@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

> Could we have write(powerstate_fd, "qos",3) block until all
> QOS_EVENTUALLY constraints are lifted or the system successfully
> suspends and resumes or a signal arrives?

Yes - and you can then use alarm() or similar to do timeouts (or write
the timeout to the fd ?)
