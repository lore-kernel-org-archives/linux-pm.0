From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] PNP_DRIVER_RES_DISABLE breaks swsusp at
 least with snd_cs4236
Date: Sat, 12 Jan 2008 14:39:47 +0100
Message-ID: <4788C323.6090206__17798.180707223$1200325248$gmane$org@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>	<20080111080141.75aaad5f@poseidon.drzeus.cx>	<47877B83.5040604@keyaccess.nl>	<200801111940.22023.linux@rainbow-software.org>	<4788168F.8070403@keyaccess.nl>
	<20080112121256.0f2e96ad@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080112121256.0f2e96ad@poseidon.drzeus.cx>
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

On 12-01-08 12:12, Pierre Ossman wrote:

> On Sat, 12 Jan 2008 02:23:27 +0100
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> Pavel, Rafael -- the attached fixes snd-cs4236 not coming back to life for 
>> Ondrej after hibernation due to the PNP_DRIVER_RES_DO_NOT_CHANGE test 
>> triggering in pnp_bus_resume() and keeping the card in a suspended state.
>>
> 
> I'm a bit confused here. Bjorn Helgaas wanted to remove the pnp_start/stop_dev() calls completely, and you want them called all the time. :)

Wanted where? Haven't seen a coment from Bjorn? But -- while removing them 
both looks (as) sensible from a mirror-image viewpoint, this wouldn't fix 
the problem.

As fas as I understand things, "hibernation" is basically "save state, shut 
down machine" where the latter step is going to disable the card inevitably. 
On resume, you're going to need to restore the resources (that were saved in 
pnp_dev->res) that it was using to the card, which is what pnp_start_dev() 
does -- it not being called is the current problem of the card not coming 
back to life.

pnp_stop_dev() could go in this specific situation. Not much point in first 
disabling the thing it seems if a subsequent shutdown is going to take care 
of that anyway. However, suspend/resume isn't just called in the case of 
complete hibernation I guess and I know nothing about it all -- hence my 
request to the hiberhation people for how this is designed to be.

But we certainly need the pnp_start_dev() in the current flow of things. It 
not being called is the problem this fixes...

Rene.
