From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Sat, 14 Jul 2007 11:24:56 +0200
Message-ID: <200707141124.57935.rjw__44243.1694166318$1184404883$gmane$org@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<Pine.LNX.4.64.0707140017560.25614@asgard.lang.hm>
	<Pine.LNX.4.64.0707140128210.25614@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0707140128210.25614@asgard.lang.hm>
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
To: david@lang.hm
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Saturday, 14 July 2007 10:33, david@lang.hm wrote:
> by the way, a data point on kernel sizes
> 
> -rw-r--r-- 1 root root  864648 Jul 14 00:53 vmlinuz.2.6.22.1.hibernate
> -rw-r--r-- 1 root root  659496 Jul 14 01:17 vmlinuz.2.6.22.1.hibernate.stripped
> -rw-r--r-- 1 root root 3948168 Jul 14 01:10 vmlinuz.2.6.22.1.running
> 
> the running one matches the config I'm running on my home server, the 
> hibernate is a pretty stripped down version, and the stripped is close to 
> a minimum (including turning off printk and BUG()). All three are with all 
> drivers built-in, no module support.
> 
> this is on a amd64 64 bit system
> 
> configs are available if anyone cares, the point is how much smaller a 
> kernel could be if it doesn't need all the stuff that you put in your main 
> kernel. In my case this includes not enabling the 3-ware card that holds 
> my 12-disk raid array, instead the hibernate image would be stored on one 
> of the scsi drives attached to the adaptec 78xx card.
> 
> I expect that on a normal desktop/laptop with more features (like sound) 
> the savings could be even more significant

But the kernel needs some data to work too (a 'struct page' for each memory
page etc.).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
