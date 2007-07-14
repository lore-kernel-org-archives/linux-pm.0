From: david@lang.hm
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Sat, 14 Jul 2007 13:34:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707141257290.14672__14539.8734057837$1184445653$gmane$org@asgard.lang.hm>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707131341.35801.rjw@sisk.pl>
	<Pine.LNX.4.64.0707140017560.25614@asgard.lang.hm>
	<200707142200.17515.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707142200.17515.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

in the past, Rafael J. Wysocki wrote:

> BTW, please read this message and tell me what you think:
>
> http://lkml.org/lkml/2007/7/13/265
>
> Greetings,
> Rafael
>
>
>

since I've deleted this message here's the relavent portion of it

>Okay, I have thought it through and I think that, as an initial step, we
>can do something like this:
>
>- preload the image-saving kernel before hibernation
>- in the hibernation code path replace device_suspend() with the shutting 
>down of all devices without unregistering them (not very nice, but should be 
>sufficient for a while)
>- when we've called device_power_down() and save_processor_state(), jump 
>to the image-saving kernel and let it run
>- make the image-saving kernel set up everything, save the image without
>  starting any user space (we may use the existing image-saving code for 
>this purpose, with some modifications) and power off the system (or make it 
>enter S4)
>- use the existing restoration code to load the image and jump to the
>  hibernated kernel
>- in the restore code patch replace device_resume() with the reprobing of 
>all devices.
>
>Comments?

I think this is far more complicated then it needs to be.

it sounds like it should be possible to do the following

1. figure out what pages should be backed up (creating a data structure to 
hold them)

2. kexec into the hibernate kernel (this step handles all device 
transitions today)

3. have the hibernate userspace find the data structures created in step 
#1

4. have the hibernate userspace write the pages somewhere in the suspend 
format.

5. have the hibernate kernel power down the box.

the only things here that sounds like they're not available in stock 
kernels are steps #1 and #3.

now this won't do the fancier suspend-to-ram-and-disk and it won't let you 
go back from the hibernate kernel to the main kernel, but it should be 
enough to let you do the suspend safely and reliably.

for the restore, as I understand it the process is

1. boot a kernel, any working kernel.

2. read the suspend formatted data from wherever it was saved and feed it 
to /dev/suspend

David Lang
