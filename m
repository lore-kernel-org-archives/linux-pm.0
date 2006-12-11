From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: question about process freezing
Date: Mon, 11 Dec 2006 21:33:36 +0100
Message-ID: <200612112133.36302.rjw@sisk.pl>
References: <bac9789c0612101805t72dfe5ecyb4cc610955ef55da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <bac9789c0612101805t72dfe5ecyb4cc610955ef55da@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Bob YANG <lostleuven04@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 11 December 2006 03:05, Bob YANG wrote:
> Hi,
> =

> Could anybody explain to me what process freezing is? I mean, what will
> happen to a frozen process? I tried to understand the codes in
> kernel/power/process.c and found one thing freeze_process() does is to set
> PF_FREEZE flag. What is that for?

This is to tell the process to go to the refrigerator.

The function used by processes to check if we want them to go to the
refrigerator is called try_to_freeze() and defined in either sched.h or
freezer.h (in newer kernels).  User space processes call try_to_freeze()
in get_signal_to_deliver() and kernel threads (that are freezeable) should
call it explicitly wherever appropriate.

The refrigerator itself is a function defined in process.c.  Processes that
enter it set their PF_FROZEN flags and change their states to
TASK_UNINTERRUPTIBLE.   They are in this state until we clear the PF_FROZEN
flag for them, in thaw_processes().

Greetings,
Rafael


-- =

If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
