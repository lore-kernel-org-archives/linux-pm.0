From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: PM: cannot hibernate -- BUG at
	kernel/workqueue.c:3659
Date: Wed, 25 Jan 2012 15:25:29 +0100
Message-ID: <4F2010D9.5040900@gmail.com>
References: <4F1EC8D5.5040102@suse.cz> <201201250002.37916.rjw@sisk.pl>
	<4F1F4717.2090704@gmail.com> <201201250110.44360.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201201250110.44360.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>, LKML <linux-kernel@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 01/25/2012 01:10 AM, Rafael J. Wysocki wrote:
> On Wednesday, January 25, 2012, Jiri Slaby wrote:
>> Yeah, 100%. Just try it with a small enough swap.
> 
> Ah, thanks, so that's an error code path problem and most likely in the Linus'
> tree.

Just to emphasize what I wrote earlier. I would apprectiate this fixed
in 3.2 stable too.

-- 
js
