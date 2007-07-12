From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 12:35:03 -0400
Message-ID: <46965837.8030907__24529.2729036466$1184258208$gmane$org@rtr.ca>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<200707121446.14170.rjw@sisk.pl> <469631FA.2070405@rtr.ca>
	<200707121735.40077.rjw@sisk.pl> <469650DE.4000901@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <469650DE.4000901@rtr.ca>
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

Mark Lord wrote:
> Rafael J. Wysocki wrote:
>..
>> How much RAM is there in your machine?
> 
> 2GB, but It doesn't need to dump that much for good performance.
> Hibernate here consists of:
> 
>   echo "$(( 256 * 1024 * 1024 ))" > /sys/power/image_size
>   echo -n disk > /sys/power/state
> 
> Plus a couple of fiddly commands to deal with the ATI binary X server.

Whoops.. wrong half of the script.
For TuxOnIce in 10 seconds, it does this:

  echo 288 > /sys/power/suspend2/image_size_limit
  echo > /sys/power/suspend2/do_suspend
