From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 15:39:19 +0200
Message-ID: <200906081539.20459.oliver__24445.3295636506$1244468456$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608132235.GC13214@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 8. Juni 2009 15:22:35 schrieb Ingo Molnar:

> What will the 'user space policy' bit do what the kernel cannot?
>
> If you mean the user has to configure something manually - that wont
> really happen in practice. We are happy if they know where to put
> those USB sticks in ;-)

User space need not be the user. Currently user space doesn't tell
the kernel how much functionality it needs. open/close give a binary
opposition which badly maps onto the graduated capabilities devices
have.

For example do you really need every key pressed while the screen saver
is running or is it enough for the keyboard to be able to generate a wakeup
event?

	Regards
		Oliver
