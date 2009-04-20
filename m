From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Disable suspend on a specific device] This is a
 little change in linux power scheme
Date: Mon, 20 Apr 2009 14:55:37 +0200
Message-ID: <49EC70C9.2030705@gandalf.sssup.it>
References: <200904072257.23756.rjw@sisk.pl> <200904081013.25301.rjw@sisk.pl>
	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl>
	<49DC6442.3040506@gandalf.sssup.it> <20090407080611.GF1408@ucw.cz>
	<20090420124650.GD8776@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090420124650.GD8776@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Hi,

Mark Brown wrote:
> On Tue, Apr 07, 2009 at 10:06:11AM +0200, Pavel Machek wrote:
>
>   
>>> the WM8753.  Audio from a bluetooth headset is decoded by and sent digitially 
>>> to the WM8753 which does the digital to analogue conversion and 
>>> routes it out via the appropriate outputs.
>>> Analogue problem has the ti-caplyso when the audio is routed for a phone call.
>>>       
>
>   
>> I still believe it should be done in the driver... at least
>> today. Perhaps driver should just keep i2s/bluetooth powered up when
>> it is in use.
>>     
>
> The driver needs some way to figure out what it's supposed to do - it's
> not immediately obvious without some policy information if suspend means
> to suspend everything or if things that can keep working should do so.
> The natural assumption for most systems would be that suspend means
> suspend everything so that's what ASoC (the embedded audio subsystem
> within ALSA) is doing.
>
> Note also that there are multiple drivers involved in this decision.
> The audio subsystem is separate from the bluetooth subsystem (which is
> mostly managed from user space rather than by a driver) and the audio
> subsystem is itself decomposed with three separate drivers in play,
> though there is also an entry point for the subsystem which orchestrates
> the audio side.  Keeping the audio live if the bluetooth suspends isn't
> too useful.
>
>   
I sent a new patches moving the decision to the driver and implement a flag
that notify the driver is in_use by userspace application as proposed by 
Alan Stern
during the previus discussion.

Michael
