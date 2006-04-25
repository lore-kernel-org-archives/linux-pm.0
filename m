From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 00:43:02 +0200
Message-ID: <200604260043.03481.rjw@sisk.pl>
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl>
	<20060425222526.GG6379@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060425222526.GG6379@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday 26 April 2006 00:25, Pavel Machek wrote:
> > > It does apply to all of the LRU pages. This is what I've been doing for years 
> > > now. The only corner case I've come across is XFS. It still wants to write 
> > > data even when there's nothing to do and it's threads are frozen (IIRC - 
> > > haven't looked at it for a while). I got around that by freezing bdevs when 
> > > freezing processes.
> > 
> > This means if we freeze bdevs, we'll be able to save all of the LRU pages,
> > except for the pages mapped by the current task, without copying.  I think we
> > can try to do this, but we'll need a patch to freeze bdevs for this purpose. ;-)
> 
> ...adding more dependencies to how vm/blockdevs work. I'd say current
> code is complex enough...

Well, why don't we see the patch?  If it's too complex, we can just decide not
to use it. :-)

Greetings,
Rafael
