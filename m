From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 14:55:59 -0800
Message-ID: <20090216145559.5412b909__10955.8533913971$1234825103$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org>
	<200902162248.34287.rjw@sisk.pl> <20090216225116.GG1370@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216225116.GG1370@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, mark@smtp1.linux-foundation.org, Brian@smtp1.linux-foundation.org, Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 23:51:16 +0100
Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
> > > Userland should never ever control the state of a device like this
> > > directly. It should do so by a) closing the device and b) setting
> > > latency / functional requirements.
> > 
> > The user, however, may want to forcibly put a device into a low
> > power state without stopping all of the applications that depend on
> > it (eg. have it open). Do you think that we shouldn't allow users
> > to do such things?
> 
> I don't think we should do this... of you want device to be powered
> down, just don't keep it open. revoke should be enough :-).
> 
> ...one execption here is the disk driver; unmounting filesystems to
> let the disk spin down is probably too heavy.

but spin down happens on non-activity ;)
it's more a slumber than a power down



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
