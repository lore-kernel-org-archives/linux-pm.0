From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at
	least with snd_cs4236
Date: Sat, 12 Jan 2008 17:46:53 +0100
Message-ID: <200801121746.57177.linux__39597.1955186271$1200325235$gmane$org@rainbow-software.org>
References: <200801092343.48726.linux@rainbow-software.org>
	<4788C323.6090206@keyaccess.nl>
	<20080112162150.1ec9cad0@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080112162150.1ec9cad0@poseidon.drzeus.cx>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 12 January 2008 16:21:50 Pierre Ossman wrote:
> On Sat, 12 Jan 2008 14:39:47 +0100
>
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> > On 12-01-08 12:12, Pierre Ossman wrote:
> > > I'm a bit confused here. Bjorn Helgaas wanted to remove the
> > > pnp_start/stop_dev() calls completely, and you want them called all the
> > > time. :)
> >
> > Wanted where? Haven't seen a coment from Bjorn? But -- while removing
> > them both looks (as) sensible from a mirror-image viewpoint, this
> > wouldn't fix the problem.
>
> Ah, sorry. It was a different thread. Look for a mail with the subject
> "PNP: do not stop/start devices in suspend/resume path" in the LKML och
> linux-pm archives.
>
> > But we certainly need the pnp_start_dev() in the current flow of things.
> > It not being called is the problem this fixes...
>
> I think the previous suggestion was that the drivers should call this, not
> the core, so that it behaved more like other parts of the kernel (e.g.
> PCI).

I don't think that drivers should call pnp_start_dev() on resume. All drivers 
would need to call it as all PnP cards are disabled after boot. No driver 
does that currently.

3c509 driver doesn't seem to register as pnp_card_driver so that's probably 
why it's not enable after resume. I guess that more ISA PnP drivers have this 
problem. I have some other PnP network and sound cards so I'll test them.

-- 
Ondrej Zary
