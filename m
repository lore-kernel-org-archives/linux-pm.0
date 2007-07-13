From: Mark Lord <lkml@rtr.ca>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 22:38:16 -0400
Message-ID: <4696E598.4010609__33606.5096701079$1184294345$gmane$org@rtr.ca>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>	<200707121446.14170.rjw@sisk.pl>
	<469631FA.2070405@rtr.ca>	<200707121735.40077.rjw@sisk.pl>
	<469650DE.4000901@rtr.ca>	<46965837.8030907@rtr.ca>
	<87y7hl2xro.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87y7hl2xro.fsf@jbms.ath.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
Cc: david@lang.hm, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Jeremy Maitin-Shepard wrote:
>
> A typical usage pattern of hibernate on a laptop is to shut the lid,
> causing the system to start to hibernate, and to place the machine in

All laptops we have here, and those of all people I have seen
with laptops, do suspend-to-RAM on lid-close, not hibernate.

And even then, I generally wait to verify that the machine actually
did shut down, simply because the one time I didn't wait, Linux failed
to shutdown.  Which was discovered hours later at the end of the journey,
when a very hot notebook with a dead battery was unpacked.  Ugh.

Cheers
