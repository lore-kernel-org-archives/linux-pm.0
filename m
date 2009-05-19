From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: cpuidle C-state accounting
Date: Tue, 19 May 2009 16:08:39 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162038BED6777@dlee02.ent.ti.com>
References: <20090519162504.GA26660@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090519162504.GA26660@linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Surinder P Singh <srplsnh@gmail.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
> bounces@lists.linux-foundation.org] On Behalf Of Surinder P Singh
> Sent: Tuesday, May 19, 2009 11:25 AM


> I have a question about cpuidle C-state accounting in
> cpuidle_idle_call() as implemented in kernel v2.6.29.
>
> I understand it is possible for the target state entering callback to
> return 0, if for some reason it could not enter the requested C-state
> as decided by the governor. In this case, shouldn't the usage count be
> updated conditionally to reflect the fact that the state may or may
> not actually have been entered ? essentially, something like this:

If it fails state due to bus master check you can do like the reference acpi driver does.  I validated the same on OMAP3 a while back.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=addbad46ed0906cd584784423b9d0babc7476446

In code I've used I don't demote other states.  But there are state aborts.  In those cases residency is low or 0.

Regards,
Richard W.
