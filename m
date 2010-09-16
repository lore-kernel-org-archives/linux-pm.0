From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [2.6.36-rc4/HEAD] unable to handle kernel NULL
	pointer dereference?(plist_add)
Date: Thu, 16 Sep 2010 20:26:16 +0200
Message-ID: <201009162026.17003.rjw__26692.8118690432$1284662083$gmane$org@sisk.pl>
References: <20100913070034.GA4820@hostway.ca> <201009142238.25840.rjw@sisk.pl>
	<20100915234633.GW23979@hostway.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100915234633.GW23979@hostway.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Simon Kirby <sim@hostway.ca>
Cc: Takashi Iwai <tiwai@suse.de>, linux-pm@lists.linux-foundation.org, James Bottomley <James.Bottomley@suse.de>, linux-kernel@vger.kernel.org, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, September 16, 2010, Simon Kirby wrote:
> On Tue, Sep 14, 2010 at 10:38:25PM +0200, Rafael J. Wysocki wrote:
> 
> > Hmm, interesting.  This looks like a plist corruption to me, but can you please
> > check (using gdb) what line of code corresponds to the address
> > plist_add+0x36/0xa0 ?
> 
> I ended up rebuilding since then, and I enabled a bunch of debugging
> stuff.  Does this help make it more obvious?  I'll try your other patch
> tonight, but I still don't get what's wrong with the existing code.

That's not necessary, since the https://bugzilla.kernel.org/show_bug.cgi?id=17922
patch works for you.

Thanks,
Rafael
