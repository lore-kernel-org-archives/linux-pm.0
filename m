From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] PM: Print a warning if firmware is
 requested when tasks are frozen
Date: Mon, 2 May 2011 16:21:09 -0700
Message-ID: <BANLkTikCHO1ST27uhJLU5mBxtWPuuVkNKA@mail.gmail.com>
References: <201105030044.51661.rjw@sisk.pl> <20110502231234.GA6430@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110502231234.GA6430@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@suse.de>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 2, 2011 at 4:12 PM, Greg KH <gregkh@suse.de> wrote:
>
> But you can safely call this function with nowait set, and this warning
> should not be triggered, right?

Why would you want that?

It's _always_ wrong to ask for firmware during resume. "nowait" or not
is totally irrelevant. A driver that depends on the firmware being
built in to the kernel is a buggy driver, why would you want to
silently allow that kind of crap? It's just a timebomb waiting for
somebody to compile the kernel differently.

                      Linus
