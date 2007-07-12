From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 12:03:42 -0400
Message-ID: <469650DE.4000901__25732.622764963$1184256273$gmane$org@rtr.ca>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121446.14170.rjw@sisk.pl> <469631FA.2070405@rtr.ca>
	<200707121735.40077.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707121735.40077.rjw@sisk.pl>
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
Cc: david@lang.hm, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday, 12 July 2007 15:51, Mark Lord wrote:
>..
>> Currently, TuxOnIce(suspend2) takes about 10 seconds to suspend my notebook.
>> Switching to this new scheme would double that to 10 seconds to boot/probe,
>> plus the original 10 seconds to hibernate.  Assuming the new implementation
>> even comes close to suspend2 speed.
> 
> How much RAM is there in your machine?

2GB, but It doesn't need to dump that much for good performance.
Hibernate here consists of:

   echo "$(( 256 * 1024 * 1024 ))" > /sys/power/image_size
   echo -n disk > /sys/power/state

Plus a couple of fiddly commands to deal with the ATI binary X server.

We use this on other machines here too, with 2GB RAM (most of them)
and 1.3GB RAM (very slow HD, so it takes longer on that one).

Cheers
