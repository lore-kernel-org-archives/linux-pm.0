From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 11:09:45 -0600
Message-ID: <49A81E59.6010105__8159.20235259018$1235754969$gmane$org@nortel.com>
References: <200902191356.53584.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902190956570.3012-100000@iolanthe.rowland.org>
	<20090222140311.GF1387@ucw.cz>
	<200902231504.27879.oliver@neukum.org>
	<20090227101818.GH4582@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090227101818.GH4582@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Mon 2009-02-23 15:04:22, Oliver Neukum wrote:

>> We can just as well have a class of tasks less important than power
>> saving. They'd just run when power saving is not active for some other
>> reason. Just like other such schemes we end up with the problem
>> of priority inversion with locking.
> 
> Ok, I guess this could be interesting in some cases... maybe. What are
> real examples of such tasks?

Some people might put casual system monitoring tools into this 
category--top, xload, gkrellm, xclock, etc.

It'd be nice if the animated banner ad in my web browser could be 
treated this way. :)

Chris
