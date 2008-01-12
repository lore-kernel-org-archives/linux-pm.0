From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at
 least with snd_cs4236
Date: Sat, 12 Jan 2008 18:00:22 +0100
Message-ID: <4788F226.7040101__16679.5670906597$1200325243$gmane$org@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>	<20080111080141.75aaad5f@poseidon.drzeus.cx>	<47877B83.5040604@keyaccess.nl>	<200801111940.22023.linux@rainbow-software.org>	<4788168F.8070403@keyaccess.nl>	<20080112121256.0f2e96ad@poseidon.drzeus.cx>	<4788C323.6090206@keyaccess.nl>
	<20080112162150.1ec9cad0@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080112162150.1ec9cad0@poseidon.drzeus.cx>
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
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org

On 12-01-08 16:21, Pierre Ossman wrote:

> Ah, sorry. It was a different thread. Look for a mail with the subject 
> "PNP: do not stop/start devices in suspend/resume path" in the LKML och 
> linux-pm archives.

Right, and I see that the removal of start/stop is already in -mm. That's 
not going to work. Something (such as removing power) disabled Ondrej's 
CS4236 and the pnp_start_dev() is needed to re-enable it upon resume.

>> But we certainly need the pnp_start_dev() in the current flow of
>> things. It not being called is the problem this fixes...
> 
> I think the previous suggestion was that the drivers should call this,
> not the core, so that it behaved more like other parts of the kernel
> (e.g. PCI).

It seems all PnP drivers would need to stick a pnp_start_dev in their resume 
method then which means it really belongs in core. One important point where 
PnP and PCI differ is that PnP allows to change the resources on a protocol 
level and I don't see how it could ever not be necessary to restore the 
state a user may have set if power has been removed. Hibernate is just that, 
isn't it?

Rene.
