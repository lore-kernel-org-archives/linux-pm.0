From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RESEND PATCH] PM: add a config that give warnning
 if driver take too long on suspend/resume.
Date: Mon, 11 Apr 2011 14:42:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1104111439430.1975-100000@iolanthe.rowland.org>
References: <BANLkTincwnm_2DBKibNP-JC5fqKJf5MWXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTincwnm_2DBKibNP-JC5fqKJf5MWXQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-pm@vger.kernel.org

On Tue, 12 Apr 2011, Jiejing.Zhang  wrote:

> > Bear in mind that rotating disk drives typically take several hundred
> > milliseconds to spin down.  The warning would always trigger.  That
> > doesn't seem particularly useful.
> >
> 
> I think it's better change the default value 0 to disable it, enable it only
> some one write a threshold.
> 
> First of all, it's a debug function (depends on PM_DEBUG), It's useful
> in embedded area, like mobile phone or e-book, they are suspend/resume very
> frequently and required resume as quick as possible. This debug function
> can used to figure out which driver(s) is/are slow on suspend/resume.
> 
> I fact that embedded engineer meets a lot is, after some development the
> total time of suspend/resume is become slow, since there was a lot driver
> may affect the total time, it's function can help them to figure out which
> driver is slow, and it's make life easier.

Maybe you should mention this in the patch description.

You know, the "initcall_debug" boot parameter will cause the kernel to 
log the amount of time each device spends doing suspend and resume.

Alan Stern
