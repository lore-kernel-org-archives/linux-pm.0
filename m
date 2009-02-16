From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFD] Automatic suspend
Date: Sun, 15 Feb 2009 19:30:37 -0800
Message-ID: <20090215193037.3e3ebeab__47582.6392801993$1234755180$gmane$org@infradead.org>
References: <200902160010.16955.rjw@sisk.pl>
	<20090215164456.34aef7e8@infradead.org>
	<1234750360.26036.115.camel@pasglop>
	<20090215182012.3bc6b292@infradead.org>
	<1234754621.26036.120.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1234754621.26036.120.camel@pasglop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, mark@smtp1.linux-foundation.org, Brian@smtp1.linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 16 Feb 2009 14:23:41 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sun, 2009-02-15 at 18:20 -0800, Arjan van de Ven wrote:
> > what this needs is a separation between "interface down, all off"
> > and "interface down enough so that link detection works".
> > Some NICs can go all the way down and still do link detection,
> > others cannot. This is obviously something the driver will know,
> > nothing else in the system should know.
> 
> Sure, my point was just that the driver cannot make the decision to go
> all-off (and thus not detect link) without some kind of user setting
> allowing it to do so.

to a very large degree, "want linkdetection" is a form of keeping the
device open.. even if the current code doesn't quite work that way
(maybe it should)



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
