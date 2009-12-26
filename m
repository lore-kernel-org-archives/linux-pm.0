From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Sun, 27 Dec 2009 09:03:25 +1100
Message-ID: <4B36882D.5070002__13745.508172042$1261865107$gmane$org@crca.org.au>
References: <200912210140.19713.rjw@sisk.pl> <200912242310.42615.rjw@sisk.pl>
	<4B35272D.7040207@crca.org.au> <200912262233.45626.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912262233.45626.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

Hi.

Rafael J. Wysocki wrote:
> Yes, it did.  Please compare these lines:
> 
> (from the "sync" dmesg):
> [   31.640676] PM: freeze of devices complete after 709.277 msecs
> [   37.087548] PM: restore of devices complete after 4973.508 msecs
> 
> (from the "async" dmesg):
> [   25.600067] PM: freeze of devices complete after 620.429 msecs
> [   29.195366] PM: restore of devices complete after 3057.982 msecs
> 
> So clearly, there's a difference. :-)

Oh okay.

It still feels like a long time. How do I find out which device took the
longest? It looks to me like the patch is only recording when things
start their restore, not when they finish.

> Of course, in terms of total hibernate/restore time this is only a little
> improvement, but if that was suspend to RAM and resume, the reduction of
> the device resume time by almost 2 s would be a big deal.
> 
>> I'll see if I can find the time to do the other computers, then.
> 
> I'd appreciate that very much.

I'm not sure I'll find the time now - it's Sunday morning here and we
still have packing and so on to do after I take this morning's service.

Sorry!

Regards,

Nigel
