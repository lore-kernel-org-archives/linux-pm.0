From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: -mm:
 pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
 breaks resuming isapnp cards
Date: Sun, 13 Jan 2008 07:13:35 +0100
Message-ID: <4789AC0F.9030007__39560.8253697448$1200325255$gmane$org@keyaccess.nl>
References: <200801092343.48726.linux@rainbow-software.org>
	<200801122008.10313.rjw@sisk.pl> <47891E21.8060209@keyaccess.nl>
	<200801122250.44220.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801122250.44220.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ALSA development <alsa-devel@alsa-project.org>, Ondrej Zary <linux@rainbow-software.org>, Takashi Iwai <tiwai@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, Pavel Machek <pavel@suse.cz>, Pierre Ossman <drzeus@drzeus.cx>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 13-01-08 06:50, Bjorn Helgaas wrote:

> On Saturday 12 January 2008 1:08:01 pm Rene Herman wrote:

>> pnp-do-not-stop-start-devices-in-suspend-resume-path.patch in current -mm
>> breaks resuming isapnp cards from hibernation. They need the pnp_start_dev
>> to enable the device again after hibernation.
>>
>> They don't really need the pnp_stop_dev() which the above mentioned patch
>> also removes but with the pnp_start_dev() restored it seems pnp_stop_dev()
>> should also stay. Bjorn Helgaas should decide  -- currently the patch as
>> you have it breaks drivers though. Could you drop it?
> 
> Yes, please drop pnp-do-not-stop-start-devices-in-suspend-resume-path.patch
> for now.

Okay, thanks for the reply. And, now that I have your attention, while it's 
not important to the issue anymore with the tests removed as the submitted 
patch did, do you have an opinion on (include/linux/pnp.h):

/* pnp driver flags */
#define PNP_DRIVER_RES_DO_NOT_CHANGE    0x0001  /* do not change the state 
of the device */
#define PNP_DRIVER_RES_DISABLE          0x0003  /* ensure the device is 
disabled */

I find DISABLE including DO_NOT_CHANGE rather unexpected...

By the way, I also still have this next one outstanding for you... :-/

http://lkml.org/lkml/2008/1/9/168

Rene.
