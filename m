From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] pm_qos: get rid of the allocation in
	pm_qos_add_request()
Date: Tue, 29 Jun 2010 11:20:37 +0200
Message-ID: <201006291120.37710.rjw__24632.1848979735$1277803434$gmane$org@sisk.pl>
References: <1277746434.10879.191.camel@mulgrave.site>
	<201006282359.18045.rjw@sisk.pl>
	<1277763049.10879.204.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1277763049.10879.204.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>, netdev@vger.kernel.org, linux-pm@lists.linux-foundation.org, markgross@thegnar.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 29, 2010, James Bottomley wrote:
> On Mon, 2010-06-28 at 23:59 +0200, Rafael J. Wysocki wrote:
> > On Monday, June 28, 2010, James Bottomley wrote:
> > > Since every caller has to squirrel away the returned pointer anyway,
> > > they might as well supply the memory area.  This fixes a bug in a few of
> > > the call sites where the returned pointer was dereferenced without
> > > checking it for NULL (which gets returned if the kzalloc failed).
> > > 
> > > I'd like to hear how sound and netdev feels about this: it will add
> > > about two more pointers worth of data to struct netdev and struct
> > > snd_pcm_substream .. but I think it's worth it.  If you're OK, I'll add
> > > your acks and send through the pm tree.
> > > 
> > > This also looks to me like an android independent clean up (even though
> > > it renders the request_add atomically callable).  I also added include
> > > guards to include/linux/pm_qos_params.h
> > > 
> > > cc: netdev@vger.kernel.org
> > > cc: Takashi Iwai <tiwai@suse.de>
> > > Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> > 
> > I like all of the patches in this series, thanks a lot for doing this!
> > 
> > I guess it might be worth sending a CC to the LKML next round so that people
> > can see [1/3] (I don't expect any objections, but anyway it would be nice).
> 
> I cc'd the latest owners of plist.h ... although Daniel Walker has
> apparently since left MontaVista, Thomas Gleixner is still current ...
> and he can speak for the RT people, who are the primary plist users.
> 
> I can do another round and cc lkml, I was just hoping this would be the
> last revision.

OK, let's see if there's any feedback on [3/3] from netdev and Takashi.
If there's none, I'll just put the series into my linux-next branch.

Rafael
