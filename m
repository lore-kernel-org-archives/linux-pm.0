From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: LPC 2011 Power Management Session notes
Date: Fri, 9 Sep 2011 10:09:48 +0200
Message-ID: <CAORVsuWKd9uvTTNCr_k9W6DeA+z3ZEaD99bqit++4xUy9zqKSQ@mail.gmail.com>
References: <alpine.DEB.2.00.1109081827360.17022@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.00.1109081827360.17022@utopia.booyaka.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-pm@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Fri, Sep 9, 2011 at 2:28 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Available at
>
> http://pad.ubuntu.com/plumbers-2011-pwr-mgt
>
> in real time if anyone's interested
Thanks for the doc!


About the Device PM QoS user space interface:
1. Proposal: For every device, there will be a sysfs wakeup latency attribute
2. Proposal: Userspace processes should communicate their needs via sysfs

I assume there can be only one user app that can open a given sysfs
entry at a time, is that correct?

Let me think about it and propose a patch next week.

Regards,
Jean

>
>
> - Paul
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
